module mem(
	input logic clk,
	input logic[4:0]addr,
	input logic[7:0]data_in,
	input logic read,
	input logic write,
	output logic[7:0]data_out
);

logic[7:0]mem[4:0];

always_ff@(posedge clk)begin
if(write & !read)begin

mem[addr] <= data_in;

end
end

always_ff@(posedge clk)begin
if( !write & read)begin

data_out <= mem[addr] ;

end
end


endmodule