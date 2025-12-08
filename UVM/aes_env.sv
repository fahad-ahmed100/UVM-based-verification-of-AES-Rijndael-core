class aes_env extends uvm_env;
    `uvm_component_utils(aes_env)

    aes_agent agent;
    function new(string name, uvm_component parent);
            super.new(name, parent)
    endfunction //new()

    function build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        agent = aes_agent::type_id::create("agent", this);

    endfunction

endclass //aes_env extends uvm_env