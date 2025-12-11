class aes_seqs extends uvm_sequence#(aes_packet);
  `uvm_object_utils(aes_seqs)

  function new(string name="aes_seqs");
    super.new(name);
  endfunction

  task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif

    if (phase != null) begin
      // call get_type_name() with parentheses
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "Raise objection", UVM_MEDIUM);
    end
  endtask : pre_body


  task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif

    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "Drop objection", UVM_MEDIUM);
    end
  endtask : post_body

endclass : aes_seqs


class rand_packet extends aes_seqs;
  `uvm_object_utils(rand_packet)

  function new(string name="rand_packet");
    super.new(name);
  endfunction

 task body();
    aes_packet req;
    `uvm_info(get_type_name(), "Executing rand_packet sequence", UVM_LOW)
    
    repeat (100) begin  // ← Changed from 1 to 10
      //`uvm_do_with(req, {KL == 2;})
      `uvm_do(req)
    end

    //#1700; 
endtask

endclass : rand_packet


/*
class rand_packet extends aes_seqs;
    `uvm_object_utils(rand_packet)
    
    int num_packets = 10;
    int cycles_per_packet = 9;  // Adjust based on your DUT
    
    function new(string name="rand_packet");
        super.new(name);
    endfunction
    
    task body();
        aes_packet req;
        int total_delay;
        
        `uvm_info(get_type_name(), $sformatf("Sending %0d packets", num_packets), UVM_LOW)
        
        repeat (num_packets) begin
            `uvm_do(req)
        end
        
        // Calculate delay: packets × cycles × some margin
        total_delay = num_packets * cycles_per_packet * 20;  // 20× margin for safety
        
        `uvm_info(get_type_name(), $sformatf("Waiting %0d time units for DUT to complete", total_delay), UVM_LOW)
        #total_delay;
        
    endtask
endclass : rand_packet
*/
