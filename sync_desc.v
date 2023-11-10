module vga_sync_generator(
  input ck,
  output reg h_sync,
  output reg v_sync
);
  reg [15:0] pixel, lines;

  localparam h_pulse_begin = 640+16;
  localparam h_pulse_end = 640+16+96;
  localparam h_reset = 640+16+96+48;

  localparam v_pulse_begin = 480+10;
  localparam v_pulse_end = 480+10+2;
  localparam v_reset = 480+10+2+33;

  always_ff @(posedge ck) begin
    pixel <= pixel + 1;
    case (pixel)
      h_pulse_begin: h_sync <= 1'b1;
      h_pulse_end: h_sync <= 1'b0;
      h_reset: begin
        pixel <= 0;
        lines <= lines + 1;
      end
    endcase

    case (lines)
      v_pulse_begin: v_sync <= 0;
      v_pulse_end: v_sync <= 1;
      v_reset: lines <= 0;
    endcase

  end
endmodule

