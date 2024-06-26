`timescale 1ns / 1ps
// fpga4student.com 
// FPGA projects, VHDL projects, Verilog projects 
// Verilog code for RISC Processor 
// Verilog code for Data Path of the processor
module Datapath_Unit(
 input clk,
 input beq,mem_read,mem_write,reg_dst,mem_to_reg,reg_write,load,
 input[1:0] alu_op,
 output[3:0] opcode
);
  reg  [7:0] pc_current;
  wire [7:0] pc_next,pc2;
 wire [15:0] instr;
  wire [3:0] reg_write_dest;
 wire [15:0] reg_write_data;
  wire [3:0] reg_read_addr_1;
 wire [15:0] reg_read_data_1;
  wire [3:0] reg_read_addr_2;
 wire [15:0] reg_read_data_2;
 wire [15:0] read_data2;
 wire [7:0] ext_im;
  wire [1:0] ALU_Control;
 wire [15:0] ALU_out;
 wire zero_flag;
 wire [15:0] PC_beq, PC_2beq;
 wire beq_control;
  wire [15:0] mem_read_data,load_data;
 // PC 
 initial begin
  pc_current <= 16'd0;
 end
 always @(posedge clk)
 begin 
   pc_current <= pc_next;
 end
 assign pc2 = pc_current + 8'b1;
 // instruction memory
 Instruction_Memory im(.pc(pc_current),.instruction(instr));
 // jump shift left 2
 // multiplexer regdest
  assign reg_write_dest = (reg_dst==1'b1) ? instr[3:0] :instr[11:8];
 // register file
  assign reg_read_addr_1 = instr[11:8];
  assign reg_read_addr_2 = instr[7:4];
 
 // GENERAL PURPOSE REGISTERs
 GPRs reg_file
 (
  .clk(clk),
  .reg_write_en(reg_write),
  .reg_write_dest(reg_write_dest),
  .reg_write_data(reg_write_data),
  .reg_read_addr_1(reg_read_addr_1),
  .reg_read_data_1(reg_read_data_1),
  .reg_read_addr_2(reg_read_addr_2),
  .reg_read_data_2(reg_read_data_2)
 );
 // immediate extend
  assign ext_im = instr[7:0];  
 // ALU control unit
 // multiplexer alu_src
 assign read_data2 =  reg_read_data_2;
 // ALU 
  ALU alu_unit(.a(reg_read_data_1),.b(read_data2),.alu_control(alu_op),.result(ALU_out),.zero(zero_flag));
 // PC beq add
  assign PC_beq = pc2 + ext_im;
 // beq control
 assign beq_control = beq & zero_flag;

 // PC_beq
// assign PC_2beq = (beq_control==1'b1) ? PC_beq : pc2;
 // PC_bne


 // PC_next
  assign pc_next = (beq_control==1'b1) ? PC_beq :pc2;

 /// Data memory
  Data_Memory dm
   (
    .clk(clk),
     .mem_access_addr(ext_im),
     .mem_write_data(reg_read_data_1),
    .mem_write_en(mem_write),
    .mem_read(mem_read),
    .mem_read_data(mem_read_data)
   );
 
 // write back
 assign load_data = (mem_to_reg == 1'b1)?  mem_read_data: ALU_out;
 assign reg_write_data = (load == 1'b1)?  ext_im : load_data;
 // output to control unit
 assign opcode = instr[15:12];
endmodule