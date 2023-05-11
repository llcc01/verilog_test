`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/09 10:24:42
// Design Name: 
// Module Name: reg_file
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


module reg_file(
    input clk,
    input wr_en,
    input reset,
    
    input [1:0] read_reg1,
    input [1:0] read_reg2,
    output reg [31:0] read_data1,
    output reg [31:0] read_data2,

    input [1:0] write_reg,
    input [31:0] write_data
    );

    reg [31:0] reg_file [3:0];
        
    always @(posedge clk) begin
        if (reset) begin
            for (integer i = 0; i < 4; i = i + 1) begin
                reg_file[i] <= 0;
            end
        end 
        else begin
            if (wr_en) begin
                reg_file[write_reg] <= write_data;
            end
        end

        read_data1 = reg_file[read_reg1];
        read_data2 = reg_file[read_reg2];
    end
    
endmodule
