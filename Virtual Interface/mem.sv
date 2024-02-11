module mem(
	mem_interface.dut mbus
);

logic[7:0]mem[4:0];

always_ff@(posedge mbus.clk)begin
if(mbus.write & !mbus.read)begin

mem[mbus.addr] <= mbus.data_in;

end
end

always_ff@(posedge mbus.clk)begin
if( !mbus.write & mbus.read)begin

mbus.data_out <= mem[mbus.addr] ;

end
end


endmodule