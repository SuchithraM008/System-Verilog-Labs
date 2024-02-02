module mem(
	mem_interface.dut mem_inf
);

logic[7:0]mem[4:0];

always_ff@(posedge mem_inf.clk)begin
if(mem_inf.write & !mem_inf.read)begin

mem[mem_inf.addr] <= mem_inf.data_in;

end
end

always_ff@(posedge mem_inf.clk)begin
if( !mem_inf.write & mem_inf.read)begin

mem_inf.data_out <= mem[mem_inf.addr] ;

end
end


endmodule