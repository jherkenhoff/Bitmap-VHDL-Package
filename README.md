# Bitmap VHDL Package


## Overview
Debugging image processing pipelines is very challenging.
Running the design on real hardware lets you see what your image actually looks like, but lacks the in depth information a simulator can provide. The other way around you are able to see whats happening to your signals inside your design, but not how those signals translate to your image.

This small vhdl package "extends" the debugging capabilities of the simulator by providing the ability to view the image data flowing down the pipeline.
Simply hook the bmp_sink component to your image pipeline and start simulating. It stores the arriving image data into a bitmap file on your hard drive. By using multiple bmp_sink components you can evaluate the image data on different stages as they get processed.

The bmp_source component does exactly what its name implies. It reads a bitmap file from your harddrive and sources it to your pipeline.
This way you can test your pipeline with real images.

Of course the files provided are **not synthesizable**, since it uses file IO on the host.

## Customizing
You may build your own glue-logic to fit your specific video-bus by utilizing the low level bitmap access functions provided in the bmp_pkg.vhd file.

## TODO
- [ ] Add support for sourcing image sequences
- [ ] Unit tests for all modules
