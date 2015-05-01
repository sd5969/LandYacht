# About the Land Yacht project

The land yacht project is a research project out of the University of Illinois at Urbana-Champaign's Dullerud Research Group (HoTDeC Lab)  which is exploring the autonomous control of a land yacht. The vehicle is built with a sail arm servo and steering servo, which can be seen in the following image: (image). The plan is to have a built-in wind sensor that will be part of the input to the controller, outputs being the sail and steering servo angles.

# About this Repository

This repository contains all of the files necessary to recreate the firmware used on the land yacht. Much of this information and code is taken from [the Aerocore repositories](https://github.com/aerocore/manifest). I tried to maintains forks where possible but some of the code differs to the extent that I just made it its own separate entity. In addition, there may be some dependencies I have not mentioned. If any, they should be easy to obtain on a distribution like Ubuntu with extensive repositories. Please let me know if there are any dependencies I have missed or errors. Below are some of the different compilation steps that are required:

## Acquire ARM toolchain

In order to build any of the files here, you will need an ARM toolchain. To get the toolchain, from the root directory run:

```bash
$ cd build
$ ./get-toolchain.sh
$ cd ..
$ source Scripts/source-me.sh
```

Now we should have the compiler on our path.  We can test:

```bash
$ arm-none-eabi-gcc -v
```

You will need to run the source command from above every time you open a new terminal session.

## Build libopencm3 library

Now run this command from the repository root to compile the library:

```bash
$ make -C bootloader/libopencm3 all
```

## Build bootloader

Once the library is compiled, you can build the aerocore bootloader. To do so, run the following command from the root:

```bash
$ make -C bootloader aerocore_bl
```

Doing so outputs the px4aerocore\_bl.bin and px4aerocore\_bl.elf files. Next, running the script:

```bash
$ sh Scripts/copyBL.sh
```

Will move the bootloader to the flashing directory, Scripts. Alternatively, you can manually copy the binary.

## Build firmware

Building the firmware is done in two steps. First we compile NuttX and then we compile the firmware itself. To compile NuttX, run the following command:

```bash
$ make -j2 -C Firmware archives
```

The "-j2" option specifies the number of cores your processor can use for compiling ("-j<numcores>"). The NuttX build is placed in the Archives folder. Next, we compile the firmware. This can be done in two ways. The first to use the premade script I have developed:

```bash
$ sh Scripts/make.sh
```

This script will make the firmware and copy it to the flashing directory. Alternatively, you can just run:

```bash
$ make -j2 -C Firmware aerocore_default
$ cp Firmware/Images/aerocore_default.bin ./Scripts/
```

Now you are ready to flash your image to the board. Whenever you change the Aerocore modules but not the NuttX system, you only need to recompile the firmware and not NuttX. To do this, run the above commands but first clean the Aerocore compilation with:

```bash
$ make -C Firmware clean
```

To clean the NuttX compilation as well, run:

```bash
$ make -C Firmware distclean
```

## Flashing the firmware

Before flashing, supply the Aerocore with 5.5~10V DC power to the VBATT and GND pins. Also, jumper pins 1 and 3 on J11 on Aerocore (see the user manual) to put the board in bootloader programming mode. Then push the reset button on the Aerocore. Some of these details are also given in the Aerocore user manual. Next, run the flashing script.

```bash
$ cd Scripts
$ sh flash.sh
```

And that should be it!
