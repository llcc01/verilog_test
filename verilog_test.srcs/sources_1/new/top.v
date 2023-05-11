`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/07 16:33:43
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk,
    input wr_en,

    output [31:0] pc_out,
    output [31:0] dout
    );

    wire [7:0] ram_addr;

    assign dout = bus;

    wire [31:0] bus;
    
    wire [31:0] reg_rd_d1;
    wire [31:0] reg_rd_d2;

    wire reset;

    wire reg_wr_en;
    wire [1:0] reg_rd_addr1;
    wire [1:0] reg_rd_addr2;
    wire [1:0] reg_wr_addr;

    wire [2:0] alu_op;

    wire ram_en;
    wire ram_rd_wr;
    
    reg_file reg_file_inst(
        .clk(clk),
        .wr_en(reg_wr_en),
        .reset(reset),
        .read_reg1(reg_rd_addr1),
        .read_reg2(reg_rd_addr2),
        .read_data1(reg_rd_d1),
        .read_data2(reg_rd_d2),
        .write_reg(reg_wr_addr),
        .write_data(bus)
        );

    ram ram_inst(
        .clk(clk),
        .en(ram_en),
        .rd_wr(ram_rd_wr),
        .addr(ram_addr),
        .data(bus)
        );

    alu alu_inst(
        .clk(clk),
        .a(reg_rd_d1),
        .b(reg_rd_d2),
        .op(alu_op),
        .c(bus)
        );

    controller controller_inst(
        .clk(clk),
        .reset(reset),
        .bus(bus),
        
        .reg_wr_en(reg_wr_en),
        .reg_rd_addr1(reg_rd_addr1),
        .reg_rd_addr2(reg_rd_addr2),
        .reg_wr_addr(reg_wr_addr),
        .alu_op(alu_op),
        .ram_en(ram_en),
        .ram_rd_wr(ram_rd_wr),
        .ram_addr(ram_addr)
        );

    
endmodule
