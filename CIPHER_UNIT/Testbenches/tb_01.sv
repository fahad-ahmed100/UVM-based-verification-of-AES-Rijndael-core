`timescale 1ns / 1ps

module aes_tb();

  logic CLK = 0;
  logic CLR;
  logic CK;      //Whenever this is asserted, key is reset
  logic [31:0] KEY [7:0];
  logic [1:0] KL; 
  logic enc_dec;
  logic [31:0]state_i[3:0];
  logic [31:0]state_o[3:0];
  logic CF;

  cipher_unit a(
    .CLK(CLK),
    .CLR(CLR),
    .CK(CK),
    .KEY(KEY),
    .KL(KL), 
    .enc_dec(enc_dec),
    .state_i(state_i),
    .state_o(state_o),
    .CF(CF)
  );

  always #20 CLK = ~CLK;

  // (your debug signals / aliases)
  logic [31:0] Kzero;     //This is the round key for each round
  logic [3:0] round;      //This is the round counter
  logic Mux0;
  logic Mux1;
  logic [1:0]Mux2;
  logic Mux3;
  logic Mux4;
  logic Mux5;
  logic Mux6;
  logic [31:0]bso[3:0];
  logic [31:0]rso[3:0];
  logic [31:0]mco[3:0];
  logic [31:0]arko[3:0];
  logic [31:0]bsi[3:0];
  logic [31:0]rsi[3:0];
  logic [31:0]mci[3:0];
  logic [31:0]arki[3:0];
  logic [3:0]STate;

  assign STate = a.s.STATE;
  assign Kzero = a.kexp.kout[0];
  assign round = a.s.R;
  assign Mux0 = a.s.mux0;
  assign Mux1 = a.s.mux1;
  assign Mux2 = a.s.mux2;
  assign Mux3 = a.s.mux3;
  assign Mux4 = a.s.mux4;
  assign Mux5 = a.s.mux5;
  assign Mux6 = a.s.mux6;

  assign bsi = a.Bs.state_i;
  assign bso = a.Bs.state_o;

  assign rsi = a.Rs.state_i;
  assign rso = a.Rs.state_o;

  assign mci = a.Mc.state_i;
  assign mco = a.Mc.state_o;

  assign arki = a.Ark.state_i;
  assign arko = a.Ark.state_o;

  // ------------ File-driven testbench ------------
  // Input/Output files in the simulation working directory:
  // input.txt  -> contains one 32-bit hex per line (e.g. DEADBEEF or 0xDEADBEEF)
  // output.txt -> produced by this TB; four 32-bit hex words per line (state_o[3]..state_o[0])

  initial begin
    integer inf, outf;
    integer r;
    reg [31:0] w0, w1, w2, w3;
    integer MAX_WAIT_CYCLES;
    integer wait_count;

    // default test parameters
    MAX_WAIT_CYCLES = 20000; // fallback timeout (clock cycles) if CF never asserts

    // initial signals
    CLK = 0;
    CLR = 1;
    CK  = 1; // clears the round keys while high (per your previous flow)
    KL  = 1;
    enc_dec = 0; // 1 = encryption, 0 = decryption (you can change)

    // default key (remaining same as you had)
    KEY[0] = 32'h54686174;
    KEY[1] = 32'h73206D79;
    KEY[2] = 32'h204B756E;
    KEY[3] = 32'h67204675;
    KEY[4] = 32'h00000000;
    KEY[5] = 32'h00000000;
    KEY[6] = 32'h00000000;
    KEY[7] = 32'h00000000;

    // open files
    inf  = $fopen("input.txt", "r");
    outf = $fopen("output.txt", "w");

    if (inf == 0) begin
      $display("ERROR: cannot open input.txt");
      $finish;
    end
    if (outf == 0) begin
      $display("ERROR: cannot open output.txt");
      $fclose(inf);
      $finish;
    end

    // Allow key/reset settle like your original sequence
    #40;
    CLR = 0;
    CK  = 0; // release CK so key expansion can proceed (matches your original flow)

    // Main file-processing loop: read 4 lines at a time
    while (!$feof(inf)) begin

      // read four words (stop if file ends prematurely)
      r = $fscanf(inf, "%h\n", w3); if (r != 1) break; // note: mapping to your ordering state_i[3]..[0]
      r = $fscanf(inf, "%h\n", w2); if (r != 1) break;
      r = $fscanf(inf, "%h\n", w1); if (r != 1) break;
      r = $fscanf(inf, "%h\n", w0); if (r != 1) break;

      // apply the 4 inputs to the DUT (synchronized to clock)
      @(posedge CLK);
      state_i[3] = w3;
      state_i[2] = w2;
      state_i[1] = w1;
      state_i[0] = w0;
      // after assigning input, allow one clk edge for DUT to sample
      @(posedge CLK);

      // wait for completion: prefer CF==1, else timeout fallback
      wait_count = 0;
      while ((CF !== 1) && (wait_count < MAX_WAIT_CYCLES)) begin
        @(posedge CLK);
        wait_count = wait_count + 1;
      end

      if (CF === 1) begin
        $display("Block processed, CF asserted after %0d cycles", wait_count);
      end else begin
        $display("Warning: CF never asserted for this block (timed out after %0d cycles). Proceeding.", wait_count);
      end

      // give one cycle to ensure state_o stable (optional)
      @(posedge CLK);

      // write outputs: one line with four 32-bit hex words (most-significant first)
      $fwrite(outf, "%08h\n%08h\n%08h\n%08h\n", state_o[3], state_o[2], state_o[1], state_o[0]);

      // small gap between blocks so DUT can settle (optional)
      repeat (100) @(posedge CLK);

    end // while !$feof

    $display("All blocks processed. Closing files.");
    $fclose(inf);
    $fclose(outf);

    // finish simulation after small delay
    #200;

  end // initial

endmodule
