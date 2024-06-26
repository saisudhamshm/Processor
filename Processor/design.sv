// Code your design here
`timescale 1ns / 1ps
// fpga4student.com 
// FPGA projects, VHDL projects, Verilog projects 
// Verilog code for RISC Processor 


`include "alu.v"
`include "data.v"
`include "register.v"
`include "prog.v"
`include "parameter.v"
`include "datapath.v"
`include "control_unit.v"


module Risc_16_bit(
 input clk
);
 wire beq,mem_read,mem_write,reg_dst,mem_to_reg,reg_write,load;
 wire[1:0] alu_op;
 wire [3:0] opcode;
 // Datapath
 Datapath_Unit DU
 (
  .clk(clk),
  .beq(beq),
  .mem_read(mem_read),
  .mem_write(mem_write),
  .reg_dst(reg_dst),
  .mem_to_reg(mem_to_reg),
  .reg_write(reg_write),
  .alu_op(alu_op),
   .opcode(opcode),
   .load(load)
 );
 // control unit
 Control_Unit control
 (
  .opcode(opcode),
  .reg_dst(reg_dst),
  .mem_to_reg(mem_to_reg),
  .alu_op(alu_op),
  .beq(beq),
  .mem_read(mem_read),
  .mem_write(mem_write),
   .reg_write(reg_write),
   .load(load)
 );
endmodule