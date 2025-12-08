interface aes_interface (input CLK, input logic CLR);
timeunit 1ns;
timeprecision 100ps;

import uvm_pkg::*;
 `include "uvm_macros.svh";



  logic CK;                         // Secondary clock/control
  logic enc_dec;                    // 1 = encrypt, 0 = decrypt
  logic [1:0] KL;                   // Key length control

  logic [31:0] KEY [7:0];           // Key array (8 x 32-bit)
  logic [31:0] state_i [3:0];       // Input state

  logic [31:0] state_o [3:0];       // Output state from DUT
  logic CF;                         // Finish/Completion flag

  
  bit drvstart, monstart;

  // Local buffer (internal storage for stimulus)
  logic [31:0] key_mem [8];
  logic [31:0] state_mem [4];

  // ----------------------------
  // Reset Task
  // ----------------------------
  task cipher_reset();
    @(posedge CLR);
    enc_dec   <= '0;
    KL        <= '0;
    CK        <= 1'b0;

    foreach(KEY[i])   KEY[i]   <= 'hz;
    foreach(state_i[i]) state_i[i] <= 'hz;

    drvstart <= 0;
    monstart <= 0;

    disable send_to_dut;
  endtask : cipher_reset


  // ----------------------------
  // DRIVER TASK — Apply Inputs
  // ----------------------------
  task send_to_dut(
        input bit enc_mode,                 // encrypt/decrypt
        input bit [1:0] key_length,         // KL value
        input bit [31:0] key_array [8],     // key
        input bit [31:0] state_array [4],   // input state
        input int delay_cycles              // delay before driving
        );

    repeat(delay_cycles)
      @(posedge CLK);

    drvstart = 1;

    // Latch values into interface
    enc_dec <= enc_mode;
    KL      <= key_length;

    CK      <= 1'b1;

    // Drive KEY
    foreach (KEY[i]) begin
      KEY[i] <= key_array[i];
    end

    // Drive State
    foreach (state_i[i]) begin
      state_i[i] <= state_array[i];
    end

    @(posedge CLK);

    CK <= 1'b0; // pulse complete

    drvstart = 0;
  endtask : send_to_dut


  // ----------------------------
  // MONITOR TASK — Collect Output
  // ----------------------------
  task collect_output(
        output bit [31:0] out_state [4],
        output bit comp_flag
        );

    @(posedge CLK iff (CF == 1'b1));

    monstart = 1;

    foreach (state_o[i]) begin
      out_state[i] = state_o[i];
    end

    comp_flag = CF;

    monstart = 0;
  endtask : collect_output


  // ----------------------------
  // ASSERTIONS
  // ----------------------------

  // CF should not stay asserted forever (protocol deadlock indicator)
  property complete_flag_clears;
    @(posedge CLK) CF |-> ##[5:20] !CF;
  endproperty

  COMPLETE_CLEAR_CHECK : assert property(complete_flag_clears)
    else begin
      $display("** Cipher IF Assertion Error: CF stuck HIGH! Possible protocol error.");
      $finish;
    end

endinterface : aes_interface
