
module mem_test_dyn(mem_interface.test mem_inf);


logic [7:0]dyn[];

class memclass;

rand bit [7:0]data;


function new(input int d);
	data = d;
endfunction

//constraint c1{data dist {[8'h41:8'h5a]:=4, [8'h61:8'h7a]:=1};};;
constraint c1{data<6;};


endclass

memclass mem;
logic debug = 0;
logic i;
int ok;
logic [7:0] rd_data;

initial begin

mem = new(0);
dyn = new[32];
	$display("dyn array size:%d",dyn.size());

//write operation

for(int i=0;i<5;i=i+1)begin

	 ok = mem.randomize(data)  ;
	
	//if(ok)begin
	mem_inf.write_mem(i,mem.data,1);
	dyn[i] = mem.data;
	$display("dyn array :%d",dyn[i]);
	
	//end
end
	for(int i=0;i<5;i=i+1)begin
	mem_inf.read_mem(i,rd_data,1);
	end

end




endmodule





 




   

