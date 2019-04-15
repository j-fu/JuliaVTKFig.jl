module VTKFig
import Libdl

###########################################################################

const libvtkfig="libvtkfig"
const errorstring=
"""
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1

Package VTKFig: Unable to open libvtkfig.so.

Please ensure to have compiled and installed the vtkfig package and
to have the directory containing libvtkfig.so on your LD_LIBRARY_PATH.

For detailed instructions, see [TODO].

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
"""


function checklib()
    if VERSION >= v"1.1" 
        lib=something(Libdl.dlopen(libvtkfig,Libdl.RTLD_NOW, throw_error=false), C_NULL)
    else
        lib=something(Libdl.dlopen_e(libvtkfig,Libdl.RTLD_NOW),C_NULL)
    end        
    if lib==C_NULL
        println(errorstring)
        throw(LoadError("",0,""))
    end
end

checklib()

###########################################################################
function print_openglinfo()
    ccall(("vtkfigPrintOpenGLInfo",libvtkfig),Cvoid, ())
end

export print_openglinfo


###########################################################################
mutable struct Frame
    cobj::Ptr
    Frame()= Frame(new())
end

function Frame(this::Frame)
    this.cobj=ccall( ("vtkfigCreateFrame",libvtkfig), Ptr{Cvoid}, ())
    finalizer(destruct,this)
    return this
end

destruct(this::Frame)=ccall( ("vtkfigDestroyFrame",libvtkfig), Cvoid, (Ptr{Cvoid},),this.cobj)


###########################################################################
mutable struct DataSet
    cobj::Ptr
    DataSet()= DataSet(new())
end

function DataSet(this::DataSet)
    this.cobj=ccall( ("vtkfigCreateDataSet",libvtkfig), Ptr{Cvoid}, ())
    finalizer(destruct,this)
    return this
end

destruct(this::DataSet)=ccall( ("vtkfigDestroyDataSet",libvtkfig), Cvoid, (Ptr{Cvoid},),this.cobj)


###########################################################################
mutable struct ScalarView
    cobj::Ptr
    ScalarView()= ScalarView(new())
end

function ScalarView(this::ScalarView)
    this.cobj=ccall( ("vtkfigCreateScalarView",libvtkfig), Ptr{Cvoid}, ())
    finalizer(destruct,this)
    return this
end
destruct(this::ScalarView)=ccall( ("vtkfigDestroyScalarView",libvtkfig), Cvoid, (Ptr{Cvoid},),this.cobj)


###########################################################################
mutable struct GridView
    cobj::Ptr
    GridView()= GridView(new())
end

function GridView(this::GridView)
    this.cobj=ccall( ("vtkfigCreateGridView",libvtkfig), Ptr{Cvoid}, ())
    finalizer(destruct,this)
    return this
end
destruct(this::GridView)=ccall( ("vtkfigDestroyGridView",libvtkfig), Cvoid, (Ptr{Cvoid},),this.cobj)

###########################################################################
mutable struct VectorView
    cobj::Ptr
    VectorView()= VectorView(new())
end

function VectorView(this::VectorView)
    this.cobj=ccall( ("vtkfigCreateVectorView",libvtkfig), Ptr{Cvoid}, ())
    finalizer(destruct,this)
    return this
end
destruct(this::VectorView)=ccall( ("vtkfigDestroyVectorView",libvtkfig), Cvoid, (Ptr{Cvoid},),this.cobj)


###########################################################################
mutable struct XYPlot
    cobj::Ptr
    XYPlot()= XYPlot(new())
end

function XYPlot(this::XYPlot)
    this.cobj=ccall( ("vtkfigCreateXYPlot",libvtkfig), Ptr{Cvoid}, ())
    finalizer(destruct,this)
    return this
end
destruct(this::XYPlot)=ccall( ("vtkfigDestroyXYPlot",libvtkfig), Cvoid, (Ptr{Cvoid},),this.cobj)



###########################################################################
interact(this::Frame)=ccall(
    ("vtkfigInteract",libvtkfig),
    Cvoid,(Ptr{Cvoid},),
    this.cobj)

show(this::Frame)=ccall(
    ("vtkfigShow",libvtkfig),
    Cvoid,(Ptr{Cvoid},),
    this.cobj)

add_figure(this::Frame, fig::ScalarView)=ccall(
    ("vtkfigAddScalarView",libvtkfig),
    Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),
    this.cobj,fig.cobj)

add_figure(this::Frame, fig::ScalarView, pos::Int)=ccall(
    ("vtkfigAddScalarViewAt",libvtkfig),
    Cvoid, (Ptr{Cvoid},Ptr{Cvoid}, Cint,),
    this.cobj,fig.cobj,pos)


add_figure(this::Frame, fig::GridView)=ccall(
    ("vtkfigAddGridView",libvtkfig),
    Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),
    this.cobj,fig.cobj)

add_figure(this::Frame, fig::GridView, pos::Int)=ccall(
    ("vtkfigAddGridViewAt",libvtkfig),
    Cvoid, (Ptr{Cvoid},Ptr{Cvoid},Cint,),
    this.cobj,fig.cobj,pos)

add_figure(this::Frame, fig::VectorView)=ccall(
    ("vtkfigAddVectorView",libvtkfig),
    Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),
    this.cobj,fig.cobj)

add_figure(this::Frame, fig::VectorView, pos::Int)=ccall(
    ("vtkfigAddVectorViewAt",libvtkfig),
    Cvoid, (Ptr{Cvoid},Ptr{Cvoid},Cint,),
    this.cobj,fig.cobj,pos)

add_figure(this::Frame, fig::XYPlot)=ccall(
    ("vtkfigAddXYPlot",libvtkfig),
    Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),
    this.cobj,fig.cobj)

add_figure(this::Frame, fig::XYPlot, pos::Int)=ccall(
    ("vtkfigAddXYPlot",libvtkfig),
    Cvoid, (Ptr{Cvoid},Ptr{Cvoid},Cint),
    this.cobj,fig.cobj,pos)

remove_figure(this::Frame, fig::ScalarView)=ccall(
    ("vtkfigRemoveScalarView",libvtkfig),
    Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),
    this.cobj,fig.cobj)

remove_figure(this::Frame, fig::GridView)=ccall(
    ("vtkfigRemoveGridView",libvtkfig),
    Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),
    this.cobj,fig.cobj)

remove_figure(this::Frame, fig::VectorView)=ccall(
    ("vtkfigRemoveVectorView",libvtkfig),
    Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),
    this.cobj,fig.cobj)

remove_figure(this::Frame, fig::XYPlot)=ccall(
    ("vtkfigRemoveXYPlot",libvtkfig),
    Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),
    this.cobj,fig.cobj)


write_png(this::Frame,fname)=ccall(
    ("vtkfigWritePNG",libvtkfig),
    Cvoid, (Ptr{Cvoid},Cstring,),
    this.cobj,fname)

start_video(this::Frame,fname)=ccall(
    ("vtkfigStartVideo",libvtkfig),
    Cvoid, (Ptr{Cvoid},Cstring,),
    this.cobj,fname)


stop_video(this::Frame,fname)=ccall(
    ("vtkfigStopVideo",libvtkfig),
    Cvoid, (Ptr{Cvoid},),
    this.cobj)

set_size(this::Frame,x,y)=ccall(
    ("vtkfigSetSize",libvtkfig),
    Cvoid, (Ptr{Cvoid},Cint,Cint),
    this.cobj,x,y)

set_layout(this::Frame,x,y)=ccall(
    ("vtkfigSetLayout",libvtkfig),
    Cvoid, (Ptr{Cvoid},Cint,Cint),
    this.cobj,x,y)

set_window_title(this::Frame,title)=ccall(
    ("vtkfigSetWindowTitle",libvtkfig),
    Cvoid, (Ptr{Cvoid},Cstring,),
    this.cobj, title)

set_frame_title(this::Frame,title)=ccall(
    ("vtkfigSetFrameTitle",libvtkfig),
    Cvoid, (Ptr{Cvoid},Cstring,),
    this.cobj, title)

set_position(this::Frame,x,y)=ccall(
    ("vtkfigSetPosition",libvtkfig),
    Cvoid, (Ptr{Cvoid},Cint,Cint),
    this.cobj,x,y)



export add_figure
export remove_figure
export write_png
export write_vtk
export start_video
export stop_video
export set_size
export set_layout
export set_window_title
export set_frame_title
export set_position



##################################################################
set_rectilinear_grid(this::DataSet, X::Vector{Float64},Y::Vector{Float64})=ccall(
    ("vtkfigSetRectilinearGrid",libvtkfig),
    Cvoid,(Ptr{Cvoid},Ptr{Cdouble},Cint,Ptr{Cdouble},Cint),
    this.cobj,X, length(X),Y,length(Y))


set_point_scalar(this::DataSet, X::Vector{Float64},name)=ccall(
    ("vtkfigSetPointScalar",libvtkfig),
    Cvoid, (Ptr{Cvoid},Ptr{Cdouble},Cint,Cstring),
    this.cobj,X, length(X),name)


write_vtk(this::DataSet,fname; ftype="A")=ccall(
    ("vtkfigWriteVTK",libvtkfig),
    Cvoid, (Ptr{Cvoid},Cstring,Cstring,),
    this.cobj,fname,ftype)

export set_point_scalar
export set_data

##################################################################
set_data(this::ScalarView, dataset::DataSet,name)=ccall(
    ("vtkfigSetData",libvtkfig),
    Cvoid, (Ptr{Cvoid},Ptr{Cvoid},Cstring),
    this.cobj,dataset.cobj,name)

export set_rectilinear_grid

####################################################

add_plot(this::XYPlot, X::Vector{Float64},Y::Vector{Float64})=ccall(
    ("vtkfigAddPlot",libvtkfig),
    Cvoid,(Ptr{Cvoid},Ptr{Cdouble},Cint,Ptr{Cdouble},Cint),
    this.cobj,X, length(X),Y,length(Y))
    
set_title(this::XYPlot,title)=ccall(
    ("vtkfigSetTitle",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cstring),
    this.cobj,title); 

show_legend(this::XYPlot,b::Bool)=ccall(
    ("vtkfigShowLegend",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cint),
    this.cobj,Int(b))

show_grid(this::XYPlot,b::Bool)=ccall(
    ("vtkfigShowGrid",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cint),
    this.cobj,Int(b))

adjust_labels(this::XYPlot,b::Bool)=ccall(
    ("vtkfigAdjustLabels",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cint),
    this.cobj,Int(b))

set_legend_position(this::XYPlot,x,y)=ccall(
    ("vtkfigSetLegendPosition",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cdouble, Cdouble,),
    this.cobj,x,y)

set_legend_size(this::XYPlot,w,h)=ccall(
    ("vtkfigSetLegendSize",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cdouble, Cdouble,),
    this.cobj,w,h)

clear(this::XYPlot)=ccall(
    ("vtkfigClear",libvtkfig),
    Cvoid,(Ptr{Cvoid},),
    this.cobj)

set_plot_linetype(this::XYPlot, ltype)=ccall(
    ("vtkfigSetPlotLineType",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cstring),
    this.cobj,ltype) 

set_plot_markertype(this::XYPlot,mtype)=ccall(
    ("vtkfigSetPlotMarkerType",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cstring),
    this.cobj,mtype) 

set_plot_color(this::XYPlot,r,g,b)=ccall(
    ("vtkfigSetPlotColor",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cdouble,Cdouble,Cdouble,),
    this.cobj,r,g,b) 

set_plot_legend(this::XYPlot, legend)=ccall(
    ("vtkfigSetPlotLegend",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cstring,),
    this.cobj,legend) 

set_grid_color(this::XYPlot,r,g,b)=ccall(
    ("vtkfigSetGridColor",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cdouble,Cdouble,Cdouble,),
    this.cobj,r,g,b) 

set_axes_color(this::XYPlot,r,g,b)=ccall(
    ("vtkfigSetAxesColor",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cdouble,Cdouble,Cdouble,),
    this.cobj,r,g,b) 

set_xtitle(this::XYPlot,title)=ccall(
    ("vtkfigSetXTitle",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cstring),
    this.cobj,title) 
  
set_ytitle(this::XYPlot,title)=ccall(
    ("vtkfigSetYTitle",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cstring),
    this.cobj,title) 

set_linewidth(this::XYPlot,w)=ccall(
    ("vtkfigSetLineWidth",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cdouble,),
    this.cobj,w)

set_markersize(this::XYPlot,s)=ccall(
    ("vtkfigSetMarkerSize",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cdouble,),
    this.cobj,s)

set_xrange(this::XYPlot, x0,x1)=ccall(
    ("vtkfigSetXRange",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cdouble, Cdouble),
    this.cobj,x0,x1) 

set_yrange(this::XYPlot, y0,y1)=ccall(
    ("vtkfigSetYRange",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cdouble, Cdouble),
    this.cobj,y0,y1) 

set_number_of_xlabels(this::XYPlot,n)=ccall(
    ("vtkfigSetNumberOfXLabels",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cint,),
    this.cobj,n)

set_number_of_ylabels(this::XYPlot,n)=ccall(
    ("vtkfigSetNumberOfYLabels",libvtkfig),
    Cvoid,(Ptr{Cvoid},Cint,),
    this.cobj,n)

export add_plot
export set_title
export show_legend
export show_grid
export adjust_labels
export set_legend_position
export set_legend_size
export clear
export set_plot_linetype
export set_plot_markertype
export set_plot_color
export set_plot_legend
export set_grid_color
export set_axes_color
export set_xtitle
export set_ytitle
export set_linewidth
export set_markersize
export set_xrange
export set_yrange
export set_number_of_xlabels
export set_number_of_ylabels

####################################################



end
