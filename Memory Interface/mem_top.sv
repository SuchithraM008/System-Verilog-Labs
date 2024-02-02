module mem_top;

logic clk;

mem_interface mem_inf(.clk(clk));

mem_test test(.*);

mem dut(.*);


   always
  begin
    #5 clk = 1;
    #5 clk = 0;
  end



endmodule