module counter(
  input ck,
  input enable,
  input reset,
  output reg [15:0] count
);
  always_ff @(posedge ck) begin
    if (reset)
      count <= 0;
    else if (enable)
      count <= count + 1;
    else
      count <= count;
  end
endmodule

module sr_ff(
  input ck,
  input s,
  input r,
  output reg q
);
  always_ff @(posedge ck) begin
    if (s)
      q <= 1;
    else if (r)
      q <= 0;
    else 
      q <= q;
  end
endmodule

module vga_sync_generator(
  input ck,
  output h_sync,
  output v_sync
);
  localparam h_pulse_begin = 640+16;
  localparam h_pulse_end = 640+16+96;
  localparam h_reset = 640+16+96+48;

  localparam v_pulse_begin = 480+10;
  localparam v_pulse_end = 480+10+2;
  localparam v_reset = 480+10+2+33;

  wire [15:0] pixel, line;

  sr_ff h_ff(
    ck, 
    pixel == h_pulse_begin, 
    pixel == h_pulse_end, 
    h_sync
  );
  sr_ff v_ff(
    ck,
    line == v_pulse_end,
    line == v_pulse_begin,
    v_sync
  );

  counter h_counter(
    ck, 
    1,
    pixel == h_reset,
    pixel
  );
  counter v_counter(
    ck,
    pixel == h_reset,
    line == v_reset,
    line
  );
endmodule
