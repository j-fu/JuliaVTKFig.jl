# JuliaVTKFig.jl: Julia adapter for vtkfig


[vtkfig](https://github.com/j-fu/vtkfig) is a  C++ graphics library with an API that attempts to be as easy  to use as that  of python/matplotlib while being different.

It is multithreaded and uses vtk for fast rendering.

JuliaVTKFig.jl provides a Julia adapter based on ccall and the C API of 
vtkfig. 

## Disclaimer

So far, this package is in alpha state.

## Installation (Linux. MacOSX and the Win10 linux environment should be similar)

1. Install vtk and its development files on your system.
   This can be done either via your system's package manager, or by downloading vtk and following the compilation instructions. Please ensure that all header files are installed as well. When configuring, care about
   ensuring that graphics acceleration is enabled.

2. Download (clone) vtkfig and install it using the instructions of that package. 

3. Ensure that the directory containing `libvtkfig.so` (resp. `libvtkfig.a`) is on your `LD_LIBRARY_PATH`

4. Add this repository to your Julia environment by

````
    Pkg.add("https://github.com/j-fu/JuliaVTKFig.jl")
````

5. Download an example and try.



