
/*
class aes_test_tb extends uvm_test;
`uvm_component_utils(aes_test_tb)

aes_tb tb;

function new(string name = "base_test", uvm_component parent = null);
super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);

// uvm_config_int::set(this, "*", "recording_detail", 1);

// // Default sequence for previous base_test (can be left or removed)
// uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase", 
//                         "default_sequence", yapp_5_packets::get_type());

`uvm_info(get_type_name(), "base_test build_phase executing", UVM_HIGH)
tb = aes_tb::type_id::create("tb", this);
  // Pass the interface to driver and monitor
    // aes_vif_config::set(this, "tb.env1.agent.driver",  "vif", aes_if_inst);
    // aes_vif_config::set(this, "tb.env1.agent.monitor","vif", aes_if_inst);

endfunction


function void end_of_elaboration_phase(uvm_phase phase);
super.end_of_elaboration_phase(phase);
uvm_top.print_topology();
endfunction


function void check_phase(uvm_phase phase);
super.check_phase(phase);
check_config_usage();
endfunction


virtual task run_phase(uvm_phase phase);
uvm_objection obj;

obj = phase.get_objection();
obj.set_drain_time(this, 200ns);
endtask

endclass : aes_test_tb


class simple_test extends aes_test_tb;
`uvm_component_utils(simple_test)

function new(string name = "simple_test", uvm_component parent = null);
super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
// 1. YAPP UVC: create short YAPP packets
// yapp_packet::type_id::set_type_override(short_yapp_packet::get_type());


// 2. Call base build_phase to create TB and UVCs
super.build_phase(phase);

// 3. YAPP default sequence
uvm_config_wrapper::set(this, "tb.env1.agent.sequencer.run_phase", "default_sequence", rand_packet::get_type()); // 4) Set default sequence for all Channel UVCs at once (wildcard 'chan*') // Ensure channel_rx_resp_seq is compiled and visible via channel_pkg. 
// uvm_config_wrapper::set(this, "tb.chan*.rx_agent.sequencer.run_phase", "default_sequence", channel_rx_resp_seq::get_type()); // 5) Clock & Reset default sequence 
// uvm_config_wrapper::set(this, "tb.clk_rst.agent.sequencer.run_phase", "default_sequence", clk10_rst5_seq::get_type());

// 6. HBUS UVC: no default sequence needed


endfunction

endclass : simple_test
*/



//------------------------------------------------------
// Base Test Class
//------------------------------------------------------
class aes_test_tb extends uvm_test;
  `uvm_component_utils(aes_test_tb)

  aes_tb tb;  // top-level testbench handle
  virtual aes_interface vif; // virtual interface handle

  // Constructor
  function new(string name = "aes_test_tb", uvm_component parent = null);
    super.new(name, parent);
  endfunction


  // Build Phase
  virtual function void build_phase(uvm_phase phase);

    uvm_config_int::set( this, "*", "recording_detail", 1);
    super.build_phase(phase);

    `uvm_info(get_type_name(), "Build Phase Started for AES Base Test", UVM_HIGH)

    tb = aes_tb::type_id::create("tb", this);



    // Connect virtual interface to driver & monitor (must exist in hw_top)
  /*  if (!uvm_config_db#(virtual aes_interface)::get(this, "", "vif", vif))
      `uvm_error(get_type_name(), "Virtual interface not found in config DB")
    else begin
      aes_vif_config::set(this, "tb.env.agent.driver",  "vif", vif);
      aes_vif_config::set(this, "tb.env.agent.monitor", "vif", vif);
      `uvm_info(get_type_name(), "Virtual interface connected to driver and monitor", UVM_LOW)
    end
  */
  endfunction


  // End of Elaboration Phase
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction


  // Check Phase
  function void check_phase(uvm_phase phase);
    super.check_phase(phase);
    check_config_usage();
  endfunction

/*
  // Run Phase
  virtual task run_phase(uvm_phase phase);
    uvm_objection obj;
    obj = phase.get_objection();

    `uvm_info(get_type_name(), "AES Base Test Run Phase Started", UVM_HIGH)

  obj.raise(this);
   #2000ns; // Simulation run duration
 obj.drop(this);

    `uvm_info(get_type_name(), "AES Base Test Run Phase Completed", UVM_LOW)
  endtask
*/

virtual task run_phase(uvm_phase phase);
  rand_packet seq;
  
  // NO objections here - let sequence handle it
  `uvm_info(get_type_name(), "AES Base Test Run Phase Started", UVM_HIGH)
  
  seq = rand_packet::type_id::create("seq");
  seq.starting_phase = phase;  // ← CRITICAL: Tell sequence which phase to use
  seq.start(tb.env.agent.sequencer);
  
  `uvm_info(get_type_name(), "AES Base Test Run Phase Completed", UVM_LOW)
  // NO drop objection here
endtask


endclass : aes_test_tb



//------------------------------------------------------
// Simple Test Class (Derives from aes_test_tb)
//------------------------------------------------------
class simple_test extends aes_test_tb;
  `uvm_component_utils(simple_test)
  function new(string name = "simple_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    `uvm_info(get_type_name(), "Building simple_test - setting default sequences", UVM_HIGH)

/*
   uvm_config_db#(uvm_object_wrapper)::set(
  this,
  "tb.env.agent.sequencer",
  "default_sequence",
  rand_packet::get_type()
);
*/
  endfunction



endclass : simple_test



/*
class simple_test extends aes_test_tb;
    `uvm_component_utils(simple_test)
    
    function new(string name = "simple_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Building simple_test", UVM_HIGH)
        
        // You can configure number of packets here if you want
        uvm_config_db#(int)::set(this, "*", "num_packets", 10);
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        rand_packet seq;
        int num_pkts;
        
        `uvm_info(get_type_name(), "Simple Test Run Phase Started", UVM_HIGH)
        
        seq = rand_packet::type_id::create("seq");
        seq.starting_phase = phase;
        
        // Get configured number of packets (or use default)
        if (!uvm_config_db#(int)::get(this, "", "num_packets", num_pkts))
            num_pkts = 10;  // Default
        
        seq.num_packets = num_pkts;
        
        seq.start(tb.env.agent.sequencer);
        
        `uvm_info(get_type_name(), "Simple Test Run Phase Completed", UVM_LOW)
    endtask
endclass : simple_test
*/



