module asyc_reg(
input logic clk,
input logic[7:0] data_in,
input logic rst,
output logic [7:0]data_out
);

always_ff @(posedge clk or negedge rst)
begin

if(!rst)
data_out <= 0;
else
data_out <= data_in;
end

endmodule