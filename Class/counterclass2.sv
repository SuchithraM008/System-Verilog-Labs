///////////////////////////////////////////////////////////////////////////
// (c) Copyright 2013 Cadence Design Systems, Inc. All Rights Reserved.
//
// File name   : counter.sv
// Title       : Simple class
// Project     : SystemVerilog Training
// Created     : 2013-4-8
// Description : Simple counter class
// Notes       :
// 
///////////////////////////////////////////////////////////////////////////

module counterclass;

// add counter class here    

class counter;

int count;
int max;
int min;

function void check_limit(input int a,b);
if(a>b)begin
 max = a;
 min = b;
end
else begin
 max = b;
 min = a;
end
endfunction

function void check_set(input int set);
if(set > min && set < max )begin
count = set;
end
else begin
count = min;
$display("WARNING");
end
endfunction

function new(input int start,max_limit,min_limit);
	count = start;
	max = max_limit;
	min = min_limit;
	check_limit(max,min);
	check_set(count);
endfunction

function void load(input int i);
	count = i;
	check_set(count);
endfunction

function int getcount();
	return count;
endfunction

endclass

class uppercounter extends counter;

bit carry;

function new(input int start,max_limit,min_limit,bit carry);
	super.new(start,max_limit,min_limit);
	carry = 0;
endfunction

function void next();
	if(count<max) begin
	count =  count+1;
	carry = 0;
	$display("upper count %0d", count);
	$display("upper carry %0d", carry);
	end
	else begin
	count = min;
	carry = 1;
	$display("upper count %0d", count);
	$display("upper carry %0d", carry);
	end
endfunction

endclass

class lowercounter extends counter;

bit borrow;

function new(input int start,max_limit,min_limit,bit borrow);
	super.new(start,max_limit,min_limit);
	borrow = 0;
endfunction

function void next();
	if(count>min) begin
	count = count-1;
	borrow = 0;
	$display("borrow %0d", borrow);
	$display("lower count %0d", count);
	end
	else begin
	count = max;
	borrow = 1;
	$display("borrow %0d", borrow);
	$display("lower count %0d", count);
	end
endfunction



endclass



int countval;
uppercounter u1 = new(9,10,0,0);
lowercounter lower = new(0,10,0,0);

initial begin


countval = u1.getcount();
$display("get count %0d", countval);
u1.next();


countval = lower.getcount();
$display("get count %0d", countval);

lower.next();


lower.next();



end

endmodule