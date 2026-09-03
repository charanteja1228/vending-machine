module vending_machine(
  
  input clk,reset_n,
  
  input nickel_in,dime_in,quarter_in,
  
  output reg can_dispensed,
  
  output reg nickel_out,dime_out,two_dime_out
  
);
  

   parameter idle = 4'd0,
    five = 4'd1,
    ten = 4'd2,
    fifteen = 4'd3,
    twenty = 4'd4,
    twenty_five= 4'd5,
    thirty = 4'd6,
    thirty_five = 4'd7,
    forty = 4'd8,
    forty_five = 4'd9;
    

  
     reg [3:0] state;
  
  always @(posedge clk or negedge reset_n) begin
    
    if(!reset_n) begin
            
      state<=idle;
      can_dispensed<=0;
      nickel_out<=0;
      dime_out<=0;
      two_dime_out<=0;
            
    end
    
    else begin
      
      //////////////////////
      can_dispensed<=0;
      nickel_out<=0;
      dime_out<=0;
      two_dime_out<=0;
      ///////////////////////
      
      case(state)
        
        /////////////////////////
        idle: begin
          
          if(nickel_in) //5
            state<=five;
          else if(dime_in) //10
            state<=ten;
          else if(quarter_in) //25
            state<=twenty_five;
                   
        end
        //////////////////////////
        
        /////////////////////////
        five: begin
          
          if(nickel_in) 
            state<=ten;
          else if(dime_in) 
            state<=fifteen;
          else if(quarter_in) 
            state<=thirty;
          
        end
        //////////////////////////
        
        
        //////////////////////////
        ten: begin
          
          if(nickel_in) 
            state<=fifteen;
          else if(dime_in) 
            state<=twenty;
          else if(quarter_in) 
            state<=thirty_five;
          
        end
        //////////////////////////
        
        //////////////////////////
        fifteen: begin
          
          if(nickel_in) 
            state<=twenty;
          else if(dime_in) 
            state<=twenty_five;
          else if(quarter_in) 
            state<=forty;
          
        end
        //////////////////////////
        
        twenty: begin
          
          if(nickel_in) 
            state<=twenty_five;
          else if(dime_in) 
            state<=thirty;
          else if(quarter_in) 
            state<=forty_five;
          
        end
        /////////////////////////
        
        /////////////////////////
        
        twenty_five: begin
          
          if(nickel_in) 
            state<=thirty;
          else if(dime_in) 
            state<=thirty_five;
          else if(quarter_in) begin
            state<=idle;
            can_dispensed<=1;
          end
          
        end
        //////////////////////////
        
        //////////////////////////
        
        thirty: begin
          
          if(nickel_in) 
            state<=thirty_five;
          else if(dime_in) 
            state<=forty;
          else if(quarter_in) begin
            state<=idle;
            can_dispensed<=1;
            nickel_out<=1;
          end
          
        end
        ///////////////////////////
        
        ///////////////////////////
        
        thirty_five: begin
          
          if(nickel_in) 
            state<=forty;
          else if(dime_in) 
            state<=forty_five;
          else if(quarter_in) begin
            state<=idle;
            can_dispensed<=1;
            dime_out<=1;
          end
          
        end
        ////////////////////////////
        
        ////////////////////////////
        
        forty: begin
          
          if(nickel_in) 
            state<=forty_five;
          else if(dime_in) begin 
            state<=idle;
            can_dispensed<=1;
          end
          else if(quarter_in) begin
            state<=idle;
            can_dispensed<=1;
            nickel_out<=1;
            dime_out<=1;
          end
          
        end
        ////////////////////////////
        
        ////////////////////////////
        
        forty_five: begin
          
          if(nickel_in) begin
            state<=idle;
            can_dispensed<=1;
          end
          else if(dime_in) begin
            state<=idle;
            can_dispensed<=1;
            nickel_out<=1;
          end
          else if(quarter_in) begin
            state<=idle;
            can_dispensed<=1;
            two_dime_out<=1;
          end
          
        end
        ////////////////////////////
        
        default: state<=idle;
      
      endcase
      
    end
    
  end
  
endmodule
