module asyc_test();

logic rst;
logic[7:0] data_in,data_out;


logic clk = 1'b1;

  always
  begin
    #5 clk = 1;
    #5 clk = 0;
  end

asyc_reg dut(.*);

 clocking cb @(posedge clk);
	input data_out;
	output data_in,rst;

	default input #1step output #3;

endclocking


initial begin

@(cb);
cb.data_in <= 0;
cb.rst <=0;
@(posedge clk);
cb.rst <=1;

for(int i=0;i<8;i++)begin
@(posedge clk);
 cb.data_in <= i;
end

@(posedge clk);
$finish;

end

endmodule