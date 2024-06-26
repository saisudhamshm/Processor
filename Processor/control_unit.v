`timescale 1ns / 1ps
// fpga4student.com 
// FPGA projects, VHDL projects, Verilog projects 
// Verilog code for RISC Processor 
// Verilog code for Control Unit 
module Control_Unit(
      input[3:0] opcode,
      output reg[1:0] alu_op,
      output reg beq,mem_read,mem_write,reg_dst,mem_to_reg,reg_write,load   
    );


always @(*)
begin
 case(opcode) 
 4'b0000:  // LW
   begin
    reg_dst <= 1'b0;
    mem_to_reg <= 1'b1;
    reg_write <= 1'b1;
    mem_read <= 1'b1;
    mem_write <= 1'b0;
    beq <= 1'b0;
    alu_op <= 2'b10;
     load <= 0;
   end
 4'b0001:  // SW
   begin
    reg_dst <= 1'b0;
    mem_to_reg <= 1'b0;
    reg_write <= 1'b0;
    mem_read <= 1'b0;
    mem_write <= 1'b1;
    beq <= 1'b0;
    alu_op <= 2'b10;
     load <= 0;
   end
 4'b0010:  // add
   begin
    reg_dst <= 1'b1;
    mem_to_reg <= 1'b0;
    reg_write <= 1'b1;
    mem_read <= 1'b0;
    mem_write <= 1'b0;
    beq <= 1'b0;
    alu_op <= 2'b00;
     load <= 0;
   end
    4'b0011:  // subtract
   begin
    reg_dst <= 1'b1;
    mem_to_reg <= 1'b0;
    reg_write <= 1'b1;
    mem_read <= 1'b0;
    mem_write <= 1'b0;
    beq <= 1'b0;
    alu_op <= 2'b01;
     load <= 0;
   end
    4'b0100:  // load const 
   begin
    reg_dst <= 1'b0;
    mem_to_reg <= 1'b0;
    reg_write <= 1'b1;
    mem_read <= 1'b0;
    mem_write <= 1'b0;
    beq <= 1'b0;
    alu_op <= 2'b00;
     load <= 1;
   end
 4'b0101:  // BEQ
   begin
    reg_dst <= 1'b0;
    mem_to_reg <= 1'b0;
    reg_write <= 1'b0;
    mem_read <= 1'b0;
    mem_write <= 1'b0;
    beq <= 1'b1;
    alu_op <= 2'b00;
     load <= 0;
   end

 default: begin
    reg_dst <= 1'b1;
    mem_to_reg <= 1'b0;
    reg_write <= 1'b1;
    mem_read <= 1'b0;
    mem_write <= 1'b0;
    beq <= 1'b0;
    alu_op <= 2'b00; 
   end
 endcase
 end

endmodule