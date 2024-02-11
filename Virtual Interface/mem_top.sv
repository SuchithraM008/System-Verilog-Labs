module mem_top;

logic clk;

mem_interface mbus(.clk(clk));

mem_test test(.mbus(mbus.test));

mem dut(.mbus(mbus.dut));


   always
  begin
    #5 clk = 1;
    #5 clk = 0;
  end



endmodule