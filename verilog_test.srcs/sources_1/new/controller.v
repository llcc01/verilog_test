`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/11 09:22:48
// Design Name: 
// Module Name: controller
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

`define REG_RD_QUEUE_SIZE 2
`define ALU_QUEUE_SIZE 3
`define RAM_QUEUE_SIZE 4
`define REG_WR_QUEUE_SIZE 5

module controller(
    input clk,
    input reset,
    input [31:0] bus,
    
    output [1:0] reg_rd_addr1,
    output [1:0] reg_rd_addr2,
    output reg_wr_en,
    output [1:0] reg_wr_addr,
    output [2:0] alu_op,
    output ram_en,
    output ram_rd_wr,
    output [31:0] ram_addr
    );

    assign reg_wr_en = 1'b0;
    assign reg_rd_addr1 = 2'b0;
    assign reg_rd_addr2 = 2'b0;
    assign reg_wr_addr = 2'b0;
    assign alu_en = 1'b0;
    assign alu_op = 3'b000;
    assign ram_en = 1'b0;
    assign ram_rd_wr = 1'b0;

    reg [1:0] reg_rd_addr1_queue [`REG_RD_QUEUE_SIZE-1:0];
    reg [1:0] reg_rd_addr2_queue [`REG_RD_QUEUE_SIZE-1:0];

    reg [2:0] alu_op_queue [`ALU_QUEUE_SIZE-1:0];

    reg [`RAM_QUEUE_SIZE-1:0] ram_access_queue;
    reg [31:0] ram_addr_queue [`RAM_QUEUE_SIZE-1:0];

    reg [`REG_WR_QUEUE_SIZE-1:0] reg_wr_en_queue;
    reg [1:0] reg_wr_addr_queue [`REG_WR_QUEUE_SIZE-1:0];

    reg [31:0] pc;

    initial begin
        pc <= 0;
    end

    always @(posedge clk) begin
        for (integer i = 0; i < `REG_RD_QUEUE_SIZE-1; i = i + 1) begin
            reg_rd_addr1_queue[i] <= reg_rd_addr1_queue[i + 1];
            reg_rd_addr2_queue[i] <= reg_rd_addr2_queue[i + 1];
        end
        //

        for (integer i = 0; i < `ALU_QUEUE_SIZE-1; i = i + 1) begin
            alu_op_queue[i] <= alu_op_queue[i + 1];
        end
        //

        for (integer i = 0; i < `RAM_QUEUE_SIZE-1; i = i + 1) begin
            ram_access_queue[i] <= ram_access_queue[i + 1];
            ram_addr_queue[i] <= ram_addr_queue[i + 1];
        end
        //
        
        for (integer i = 0; i < `REG_WR_QUEUE_SIZE-1; i = i + 1) begin
            reg_wr_en_queue[i] <= reg_wr_en_queue[i + 1];
            reg_wr_addr_queue[i] <= reg_wr_addr_queue[i + 1];
        end
        //

        if (!ram_access_queue[0]) begin
            pc <= pc + 1;
        end

    end


    assign reg_rd_addr1 = reg_rd_addr1_queue[0];
    assign reg_rd_addr2 = reg_rd_addr2_queue[0];
    assign alu_op = alu_op_queue[0];
    assign ram_addr = ram_access_queue[0] ? ram_addr_queue[0] : pc;
    assign reg_wr_en = reg_wr_en_queue[0];
    assign reg_wr_addr = reg_wr_addr_queue[0];
    

endmodule
