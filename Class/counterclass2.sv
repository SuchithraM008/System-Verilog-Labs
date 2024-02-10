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


module counterclass7;
    
 class counter;
  int count;
  int max, min;
  
  function new(input int start, upper, lower);
    check_limits(upper, lower);
    check_set(start);
  endfunction

  function void check_limits (input int upper, lower);
    if (lower > upper) begin
      $display("lower bound %0d > upper bound %0d - bounds swapped", lower, upper);
      max = lower;
      min = upper;
      end
    else begin
      max = upper;
      min = lower;
    end
  endfunction

  function void check_set(input int set);
    if ((set < min) || (set > max))
      begin
      $display("count set value %0d outside bounds %0d to %0d - set to min", set, min, max);
      count = min;
      end
    else
      count = set;
  endfunction
  
  function int getcount();
    return (count);
  endfunction

  function void load(input int value);
    check_set(value);
  endfunction

endclass

class upcounter extends counter;

  logic carry;



  function new(input int start, upper, lower);
    super.new(start, upper, lower);
   
  endfunction

  function void next();
    if (count == max) begin
      carry = 1;
      count = min;
    end
    else begin
      carry = 0;
      count++;
    end
    //$display("upcounter next %0d %0d", count, carry);
  endfunction



endclass

class downcounter extends counter;

  logic borrow;

  static int no_down;

  function new(input int start, upper, lower);
    super.new(start, upper, lower);
    no_down++;
  endfunction

  function void next();
    if (count == min) begin
      borrow = 1;
      count = max;
    end
    else begin
      borrow = 0;
      count--;
    end
    $display("downcounter next %0d %0d", count, borrow);
   endfunction

  static function int number_of();
    return (no_down);
  endfunction
   
endclass   

class timer;

  upcounter hours,minutes,seconds;

  function new(input int unsigned hr=0, min=0, sec=0);
    hours   = new(hr,23,0);
    minutes = new(min,59,0);
    seconds = new(sec,59,0);
  endfunction

  function void load(input int unsigned hr, min, sec);
    hours.load(hr);
    minutes.load(min);
    seconds.load(sec);
  endfunction

  function void showval();
    $display("Timer display is %2d:%2d:%2d", hours.count, minutes.count, seconds.count);
  endfunction

  function void next();
    seconds.next();
    if (seconds.carry == 1) begin
      minutes.next();
      if (minutes.carry == 1)
        hours.next();
    end
  
  endfunction
  

 
endclass

timer t1;
 
 
       
  // Stimulus and response
  initial
    begin
    
      t1 = new();
      t1.showval();
      $display("Loading timer with 00:00:59");
      t1.load(0,0,59);
      t1.showval();
     
      $display("Incrementing timer from 00:00:59");
      t1.next();
      t1.showval();
      $display("Loading timer with 00:59:59");
      t1.load(0,59,59);
      t1.showval();
      
      $display("Incrementing timer from 00:59:59");
      t1.next();
      t1.showval();
      $display("Loading timer with 23:59:59");
      t1.load(23,59,59);
      t1.showval();
     
      $display("Incrementing timer from 23:59:59");
      t1.next();
      t1.showval();
      
      $finish(0);
    end

endmodule
