module mem_top;

logic clk;
logic[4:0]addr;
logic[7:0]data_in;
logic read;
logic write;
logic[7:0]data_out;


   always
  begin
    #5 clk = 1;
    #5 clk = 0;
  end

mem dut1(.clk(clk),.addr(addr),.data_in(data_in),.read(read),.write(write),
	.data_out(data_out));

mem_test dut2(.clk(clk),.addr(addr),.data_in(data_in),.read(read),.write(write),
	.data_out(data_out));















endmodule