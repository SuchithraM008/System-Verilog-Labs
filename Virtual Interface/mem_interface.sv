interface mem_interface(input logic clk);


logic[4:0]addr;
logic[7:0]data_in;
logic read;
logic write;
logic[7:0]data_out;



modport test(input addr,data_in,read,write,output data_out,import write_mem,import read_mem);
modport dut(input addr,data_in,read,write,clk,output data_out);












endinterface