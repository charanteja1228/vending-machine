module tb;
  
  reg clk,reset_n;
  
  reg nickel_in,dime_in,quarter_in;
  
  wire can_dispensed;
  
  wire nickel_out,dime_out,two_dime_out;
  
  always #5 clk=~clk;
 
  vending_machine dut(.clk(clk),.reset_n(reset_n),.nickel_in(nickel_in),.dime_in(dime_in),.quarter_in(quarter_in),.can_dispensed(can_dispensed),.nickel_out(nickel_out),.dime_out(dime_out),.two_dime_out(two_dime_out));
  
  initial begin
    
    clk=0;
    reset_n=0;
    
    nickel_in=0;
    dime_in=0;
    quarter_in=0;
    
    $dumpfile("dump.vcd");
    $dumpvars(0,tb);
    
    $monitor("time=%0t | nickel_in=%0d | dime_in=%0d | quarter_in=%0d | can_dispensed=%0d | nickel_out=%0d | dime_out=%0d | two_dime_out=%0d",
         $time, nickel_in, dime_in, quarter_in, can_dispensed,
         nickel_out, dime_out, two_dime_out);
    
    @(posedge clk); reset_n=1;
    
    // Nickel: 0 -> 5
    nickel_in = 1;
    @(posedge clk);
    nickel_in = 0;

    // Nickel: 5 -> 10
    nickel_in = 1;
    @(posedge clk);
    nickel_in = 0;

   // Quarter: 10 -> 35
   quarter_in = 1;
   @(posedge clk);
   quarter_in = 0;

   // Dime: 35 -> 45
   dime_in = 1;
   @(posedge clk);
   dime_in = 0;

   // Quarter: 45 -> 70
   quarter_in = 1;
   @(posedge clk);
   quarter_in = 0;
    
   @(posedge clk); $finish;
      
  end
  
endmodule
