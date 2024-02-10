///////////////////////////////////////////////////////////////////////////
// (c) Copyright 2013 Cadence Design Systems, Inc. All Rights Reserved.
//
// File name   : 07_aggreate.sv
// Title       : Aggregate class
// Project     : SystemVerilog Training
// Created     : 2013-4-8
// Description : Upcounter instances used in aggregate class
// Notes       :
// 
///////////////////////////////////////////////////////////////////////////


module counterclass12;
    
  virtual class counter;
 

	virtual function void next();
		$display("I am in counterclass");
	endfunction

endclass

class upcounter extends counter;

  

  function void next();
   
   $display("I am in uppercounter");
  endfunction


endclass

class downcounter extends counter;

 
 function void next();
    $display("I am in lower counter");
   endfunction


endclass   


  



counter c1;
upcounter u1;
upcounter u2;


initial begin
u1 = new();
c1 = u1;
c1.next();
u2 = new();
$cast(u2,c1);
u2.next();
end
endmodule
