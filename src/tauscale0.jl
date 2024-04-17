

#=
determine tauscale that gives R~1
using smooth spline for R(T) and convex optim
=#

include("j0.jl")

# using Interpolations
using DataInterpolations
using SmoothingSplines
using StatsBase 
import Optim as Opt


Ts  = range( 2., 6.5, 100_000 ) |> collect 

#' collect R and contact type from gen
function genstats( T; generation=4 )
	p = merge(P, (;T = T))
	o = simbp(p ; maxgenerations = generation+1)
	# println( o.H )
	d = [ [u.R, u.contacttype] for u in o.G if u.generation==generation ]
	length(d) == 0 && return(missing)
	d = DataFrame(d, :auto) |> permutedims
	# push!( countmap(d.x2), :R => mean( d.x1 ))
	Dict(:T=>T, :R=>mean(d.x1), pairs( countmap(d.x2))... )
end 



ot0 = time() 
o = map(genstats, Ts) 
ot1 = time() 
println( ot1 - ot0 )


y = [ [x[:T] x[:R]] for x in skipmissing(o) ]
y = vcat( y... )

sp = fit( SmoothingSpline, y[:,1], y[:,2] , 10.0 )
yp = predict( sp )
scatter( y[:,1], y[:,2])
plot!( y[:,1], yp )
plot!( y[:,1], (yp.-1.0).^2 )

# liy = linear_interpolation( y[:,1], (yp.-1.0).^2)
liy = LinearInterpolation( (yp.-1.0).^2, y[:,1]; extrapolate=true )
Tstar = Opt.optimize( liy, 1., 9. ).minimizer 
println(Tstar )

# mean: 4.299657975412291
