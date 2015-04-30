# About the Land Yacht project.

The land yacht project is a research project out of the University of Illinois at Urbana-Champaign's Dullerud Research Group (HoTDeC Lab)  which is exploring the autonomous control of a land yacht. More description to come soon.

# About this Repository

This repository contains all of the files necessary to recreate the firmware used on the land yacht. Below are some of the different compilation steps that are required:

## Build libopencm3 library

You will need the arm toolchain (name?) to build this. To get the toolchain, do etc.

Now run this command from the repository root to compile the library:

```bash
$ make -C bootloader/libopencm3 all
```

## Build bootloader

Once the library is compiled, you can build the aerocore bootloader. To do so, run the following command from the root:

```bash
$ make -C bootloader aerocore_bl
```
