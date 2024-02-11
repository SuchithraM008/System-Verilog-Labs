module mem_test(mem_interface.test mbus);


class memvirtual;
  rand  bit [7:0] data;
  randc bit [4:0] addr;

        bit [7:0] rdata;

 virtual interface mem_interface vif;
 
  constraint datadist { data dist {[8'h41:8'h5a]:=4, [8'h61:8'h7a]:=1};}

 function new (input int darg = 0);
  data = darg;
 
 endfunction

 function void configure(virtual interface mem_interface aif);
   vif = aif;
   if (vif == null) $display ("vif configure error");
 endfunction

  task write_mem (input debug = 0 );
    @(negedge vif.clk);
    vif.write <= 1;
    vif.read  <= 0;
    vif.addr  <= addr;
    vif.data_in  <= data;
    @(negedge vif.clk);
    vif.write <= 0;
    if (debug == 1)
      $display("Write - Address:%d  Data:%h %c", addr, data, data);
  endtask
  
  task read_mem (input debug = 0 );
     @(negedge vif.clk);
     vif.write <= 0;
     vif.read  <= 1;
     vif.addr  <= addr;
     @(negedge vif.clk);
     vif.read <= 0;
     rdata = vif.data_out;
     if (debug == 1) 
       $display("Read  - Address:%d  Data:%h %c", addr, rdata, rdata);
  endtask

endclass





memvirtual mem ;
bit ok;

initial begin

mem = new(0);
mem.configure(mbus);


//write operation

for(int i=0;i<5;i=i+1)begin

	 ok = mem.randomize(data);
	
	//if(ok)begin
	mem.write_mem(1);
	
	//end
end
	for(int i=0;i<5;i=i+1)begin
	mem.read_mem(1);
	end

end




endmodule