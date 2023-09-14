module UTDR_SYNC_FUNCLOAD_2STAGE (bsd_reset, tdi, tdo, bsd_shift_en, bsd_capture_en, capture_clk, bsd_update_en, update_clk, inst_enable, DOUT, DIN, FUNC_EN, FUNC_CLK);
parameter WIDTH = 4;
input	bsd_reset, tdi, bsd_shift_en, bsd_capture_en, capture_clk, bsd_update_en, update_clk, inst_enable;
output	tdo;
input	FUNC_EN, FUNC_CLK;
input	[WIDTH-1:0]	DIN;
output	[WIDTH-1:0]	DOUT;

reg	[WIDTH-1:0]	capture, update;

// capture stage
always @(posedge capture_clk)
  if (bsd_capture_en && bsd_shift_en)
    capture[WIDTH-1:0] <= {tdi, capture[WIDTH-1:1]};

assign tdo = capture[0];

// update stage
assign update_clk_muxed = (inst_enable) ? update_clk : FUNC_CLK;

always @(negedge bsd_reset or posedge update_clk_muxed)
  if (!bsd_reset)
    update <= 2'b00;
  else if (inst_enable && bsd_update_en)
    update <= capture;
  else if (!inst_enable && FUNC_EN)
    update <= DIN;

// send update value to output port
assign DOUT = update;

endmodule




module UTDR_SYNC_NOLOAD_2STAGE (bsd_reset, tdi, tdo, bsd_shift_en, bsd_capture_en, capture_clk, bsd_update_en, update_clk, DOUT);
parameter WIDTH = 4;
input	bsd_reset, tdi, bsd_shift_en, bsd_capture_en, capture_clk, bsd_update_en, update_clk;
output	tdo;
output	[WIDTH-1:0]	DOUT;

reg	[WIDTH-1:0]	capture, update;

// capture stage
always @(posedge capture_clk)
  if (bsd_capture_en && bsd_shift_en)
    capture[WIDTH-1:0] <= {tdi, capture[WIDTH-1:1]};

assign tdo = capture[0];

// update stage
always @(negedge bsd_reset or posedge update_clk)
  if (!bsd_reset)
    update <= 2'b00;
  else if (bsd_update_en)
    update <= capture;

// send update value to output port
assign DOUT = update;

endmodule




module UTDR_SYNC_FUNCLOAD_1STAGE (bsd_reset, tdi, tdo, bsd_shift_en, bsd_capture_en, capture_clk, inst_enable, DOUT, DIN, FUNC_EN, FUNC_CLK);
parameter WIDTH = 4;
input	bsd_reset, tdi, bsd_shift_en, bsd_capture_en, capture_clk, inst_enable;
output	tdo;
input	FUNC_EN, FUNC_CLK;
input	[WIDTH-1:0]	DIN;
output	[WIDTH-1:0]	DOUT;

reg	[WIDTH-1:0]	capture, update;

// capture stage
always @(negedge bsd_reset or posedge capture_clk)
  if (!bsd_reset)
    capture <= {WIDTH{1'b0}};
  else if (inst_enable && bsd_capture_en && bsd_shift_en)
    capture[WIDTH-1:0] <= {tdi, capture[WIDTH-1:1]};
  else if (!inst_enable && FUNC_EN)
    capture <= DIN;

assign tdo = capture[0];

// send capture value to output port
assign DOUT = capture;

endmodule




module UTDR_SYNC_NOLOAD_1STAGE (bsd_reset, tdi, tdo, bsd_shift_en, bsd_capture_en, capture_clk, DOUT);
parameter WIDTH = 4;
input	bsd_reset, tdi, bsd_shift_en, bsd_capture_en, capture_clk;
output	tdo;
output	[WIDTH-1:0]	DOUT;

reg	[WIDTH-1:0]	capture, update;

// capture stage
always @(negedge bsd_reset or posedge capture_clk)
  if (!bsd_reset)
    capture <= {WIDTH{1'b0}};
  else if (bsd_capture_en && bsd_shift_en)
    capture[WIDTH-1:0] <= {tdi, capture[WIDTH-1:1]};

assign tdo = capture[0];

// send capture value to output port
assign DOUT = capture;

endmodule




module UTDR_ASYNC_FUNCLOAD_2STAGE (bsd_reset, tdi, tdo, bsd_shift_en, capture_clk, update_clk, inst_enable, DOUT, DIN, FUNC_EN, FUNC_CLK);
parameter WIDTH = 4;
input	bsd_reset, tdi, bsd_shift_en, capture_clk, update_clk, inst_enable;
output	tdo;
input	FUNC_EN, FUNC_CLK;
input	[WIDTH-1:0]	DIN;
output	[WIDTH-1:0]	DOUT;

reg	[WIDTH-1:0]	capture, update;

// capture stage
always @(posedge capture_clk)
  if (bsd_shift_en)
    capture[WIDTH-1:0] <= {tdi, capture[WIDTH-1:1]};

assign tdo = capture[0];

// update stage
assign update_clk_muxed = (inst_enable) ? update_clk : FUNC_CLK;

always @(negedge bsd_reset or posedge update_clk_muxed)
  if (!bsd_reset)
    update <= 2'b00;
  else if (inst_enable)
    update <= capture;
  else if (!inst_enable && FUNC_EN)
    update <= DIN;

// send update value to output port
assign DOUT = update;

endmodule




module UTDR_ASYNC_NOLOAD_2STAGE (bsd_reset, tdi, tdo, bsd_shift_en, capture_clk, update_clk, DOUT);
parameter WIDTH = 4;
input	bsd_reset, tdi, bsd_shift_en, capture_clk, update_clk;
output	tdo;
output	[WIDTH-1:0]	DOUT;

reg	[WIDTH-1:0]	capture, update;

// capture stage
always @(posedge capture_clk)
  if (bsd_shift_en)
    capture[WIDTH-1:0] <= {tdi, capture[WIDTH-1:1]};

assign tdo = capture[0];

// update stage
always @(negedge bsd_reset or posedge update_clk)
  if (!bsd_reset)
    update <= 2'b00;
  else
    update <= capture;

// send update value to output port
assign DOUT = update;

endmodule




module UTDR_ASYNC_FUNCLOAD_1STAGE (bsd_reset, tdi, tdo, bsd_shift_en, capture_clk, inst_enable, DOUT, DIN, FUNC_EN, FUNC_CLK);
parameter WIDTH = 4;
input	bsd_reset, tdi, bsd_shift_en, capture_clk, inst_enable;
output	tdo;
input	FUNC_EN, FUNC_CLK;
input	[WIDTH-1:0]	DIN;
output	[WIDTH-1:0]	DOUT;

reg	[WIDTH-1:0]	capture, update;

// capture stage
always @(negedge bsd_reset or posedge capture_clk)
  if (!bsd_reset)
    capture <= {WIDTH{1'b0}};
  else if (inst_enable && bsd_shift_en)
    capture[WIDTH-1:0] <= {tdi, capture[WIDTH-1:1]};
  else if (!inst_enable && FUNC_EN)
    capture <= DIN;

assign tdo = capture[0];

// send capture value to output port
assign DOUT = capture;

endmodule




module UTDR_ASYNC_NOLOAD_1STAGE (bsd_reset, tdi, tdo, bsd_shift_en, capture_clk, DOUT);
parameter WIDTH = 4;
input	bsd_reset, tdi, bsd_shift_en, capture_clk;
output	tdo;
output	[WIDTH-1:0]	DOUT;

reg	[WIDTH-1:0]	capture, update;

// capture stage
always @(negedge bsd_reset or posedge capture_clk)
  if (!bsd_reset)
    capture <= {WIDTH{1'b0}};
  else if (bsd_shift_en)
    capture[WIDTH-1:0] <= {tdi, capture[WIDTH-1:1]};

assign tdo = capture[0];

// send capture value to output port
assign DOUT = capture;

endmodule


