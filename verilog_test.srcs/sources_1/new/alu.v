`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/09 11:08:27
// Design Name: 
// Module Name: alu
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


module alu(
    input clk,
    input [31:0] a,
    input [31:0] b,
    input [2:0] op,
    output reg [31:0] c
    );

    always @(posedge clk) begin
        case (op)
            3'b000: c <= a + b;
            3'b001: c <= a - b;
            3'b010: c <= a & b;
            3'b011: c <= a | b;
            3'b100: c <= a ^ b;
            3'b101: c <= a << b;
            3'b110: c <= a >> b;
            3'b111: c <= a >>> b;
        endcase
    end

endmodule
