#include "verilated.h"
#include "verilated_vcd_c.h"

#include "Vsync_desc.h"

int main(int argc, char **argv)
{
  auto duv = new Vsync_desc();

  Verilated::commandArgs(argc, argv);

  // Trace
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp = new VerilatedVcdC;
  duv->trace(tfp, 99);
  tfp->open("dump_desc.vcd");

  for (int i = 0; i < 2048; ++i) {
    duv->ck = 0;
    duv->eval();
    duv->ck = 1;
    duv->eval();
    tfp->dump(i);
  }

  tfp->close();

  return 0;
}
