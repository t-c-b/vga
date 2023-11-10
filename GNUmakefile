V = verilator
VFLAGS = -cc --trace --exe --build

obj_dir/V%: %.v %.cpp
	$(V) $(VFLAGS) $^

desc: obj_dir/Vsync_desc

comp: obj_dir/Vsync_comp
