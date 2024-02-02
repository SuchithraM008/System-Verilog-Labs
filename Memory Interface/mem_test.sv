module mem_test(mem_interface.test mem_inf);



logic[4:0]wr_addr;
logic[7:0]wr_data;
logic debug = 0;
logic[4:0] rd_addr;
logic[7:0]rd_data;
logic i;


initial begin

for(int i=0;i<5;i=i+1)begin

	mem_inf.write_mem(i,8'h0,1);

end

//write operation

for(int i=0;i<5;i=i+1)begin

	mem_inf.write_mem(i,i,1);

end

//read operation

for(int i=0;i<5;i=i+1)begin

	mem_inf.read_mem(i,rd_data,1);

end

end





endmodule