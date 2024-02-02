module mem_test(input logic clk,
	output logic[4:0]addr,
	output logic[7:0]data_in,
	output logic read,
	output logic write,
	input logic[7:0]data_out);



logic[4:0]wr_addr;
logic[7:0]wr_data;
logic debug = 0;
logic[4:0] rd_addr;
logic[7:0]rd_data;
logic i;


initial begin

for(int i=0;i<5;i=i+1)begin

	write_mem(i,8'h0,1);

end

//write operation

for(int i=0;i<5;i=i+1)begin

	write_mem(i,i,1);

end

//read operation

for(int i=0;i<5;i=i+1)begin

	read_mem(i,rd_data,1);

end

end

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
$display("Write: Addr = %0d, Data = %h",addr,data_in);
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
$display("Read: Data = %h",data_out);
end

endtask





endmodule