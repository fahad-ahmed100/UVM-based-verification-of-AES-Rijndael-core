

class aes_tb extends uvm_env;
`uvm_component_utils(aes_tb)

aes_env env;

  function new(string name = "aes_tb", uvm_component parent);
    super.new(name, parent);
  endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = aes_env::type_id::create("env", this);
    endfunction

endclass

