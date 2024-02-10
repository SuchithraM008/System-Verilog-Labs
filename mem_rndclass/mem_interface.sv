interface mem_interface(input logic clk);


logic[4:0]addr;
logic[7:0]data_in;
logic read;
logic write;
logic[7:0]data_out;



modport test(input addr,data_in,read,write,output data_out,import write_mem,import read_mem);
modport dut(input addr,data_in,read,write,clk,output data_out);




task write_mem(
	input logic[4:0]wr_addr,
	input logic[7:0]wr_data,
	input logic debug 
);

@(negedge clk);

addr = wr_addr;
data_in = wr_data;
write = 1;
read = 0;

if(debug)begin
$display("Write: Addr = %0d, Data = %c",addr,data_in);
end 

@(negedge clk);
write = 0;

endtask


task read_mem(
	input logic[4:0] rd_addr,
	output logic[7:0]rd_data,
	input logic debug 
);

@(negedge clk);
addr = rd_addr;
write = 0;
read = 1;

@(posedge clk);
rd_data = data_out;

@(negedge clk);
read = 0;

if(debug)begin
$display("Read: Data = %c",data_out);
end

endtask





endinterface