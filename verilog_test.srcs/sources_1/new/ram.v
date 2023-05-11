`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/09 11:12:58
// Design Name: 
// Module Name: ram
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


module ram(
    input clk,
    input en,
    input rd_wr,
    input [7:0] addr,
    inout [31:0] data
    );

    reg [31:0] ram [255:0];

    assign data = (en & !rd_wr) ? ram[addr] : 1'bz;
    always @(posedge clk) begin
        if (rd_wr) begin
            ram[addr] <= data;
        end
    end

endmodule
