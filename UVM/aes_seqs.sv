class aes_seqs extends uvm_sequence #(aes_packet);
  
  // Required macro for sequences automation
  `uvm_object_utils(aes_seqs)

  // Constructor
  function new(string name="aes_seqs");
    super.new(name);
  endfunction

  task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask : pre_body

  task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
  endtask : post_body

endclass : yapp_base_seq

class rand_seq extends aes_seqs;
    `uvm_object_utils(rand_seq)
    aes_packet req;
    function new(string name="aes_seqs");
        super.new(name);
    endfunction
    
    function build_phase(uvm_phase phase);
        super.build_phase(phase);
        req = aes_packet::type_id::create("req", this);
    endfunction

    virtual task body();
        `uvm_info(get_type_name(), "random sequences generation", UVM_MEDIUM)
        repeat(2)
            `uvm_do(req)
    endtask
endclass