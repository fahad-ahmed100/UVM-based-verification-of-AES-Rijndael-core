class aes_test extends uvm_env;
    `uvm_component_utils(aes_test)
    aes_env env;
    function new(string name ="aes_test" , uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    function build_phase (uvm_phase phase);
        super.build_phase(phase);
        
        env = aes_env::type_id::create("env", this);
    endfunction

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Running Simulation AES_TEST", UVM_HIGH)
    endfunction

endclass //aes_test_top 