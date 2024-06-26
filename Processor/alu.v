module ALU(
 input  [15:0] a,  //src1
 input  [15:0] b,  //src2
  input  [1:0] alu_control, //function sel
 
 output reg [15:0] result,  //result 
 output zero
    );

always @(*)
begin 
 case(alu_control)
 2'b00: result = a + b; // add
 2'b01: result = a - b; // sub

 default:result = a + b; // add
 endcase
end
  assign zero = (a==16'd0) ? 1'b1: 1'b0;
 
endmodule