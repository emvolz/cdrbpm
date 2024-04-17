
include("j0.jl") 

function tet(sol; state0 = UNDIAGNOSED_EHI, state1 = DIAGNOSED)
	isnothing(sol) && return(missing)
	t = sol.t 
	u = [x[3] for x in sol.u]
	i0 =  findfirst( x-> x==state0, u ); isnothing(i0) && return(missing)
	t0 = t[i0]
	i1 =  findfirst( x-> x==state1, u ); isnothing(i1) && return(missing) # return(maximum(t) - t0)
	t1 = t[ i1 ]
	# [ t0, t1 ] 
	t1 - t0
end
# tet( simbp(p;maxgenerations=1).G[1].sol ; state0 = UNDIAGNOSED_EHI , state1 = UNDIAGNOSED_AIDS )

dxdiagnosed = map(1:1000) do _ simbp(P;maxgenerations=1).G[1].sol |> tet  end |> (x-> vcat( 1/P.δ, mean(x), quantile(x)) )


p = merge( P, (; δ = 0.0 ))
dxaids = map(1:1000) do _ simbp(p;maxgenerations=1).G[1].sol |> (x->tet(x; state1=UNDIAGNOSED_AIDS))  end 
dxaids |> function(xx) 
	# x = x[ .!ismissing.(x)] 
	x = collect( skipmissing(xx) )
	(; nmissing = sum(ismissing.(xx))
		, truemean= 1/p.γ_ehi+3*p.γ_chron 
		, mean = mean(x)
		, qs = quantile(x) )  |> println
end



Γchron = Gamma( p.shape_chron,  p.γ_chron )
gamhazard( t) =	pdf( Γchron, t ) / ( 1.0-cdf(Γchron, t ))
using DifferentialEquations
dhaz(u,p,t) = gamhazard(t) 
phaz = ODEProblem( dhaz, 0., (0., 20*365.) )
shaz = solve( phaz , Tsit5() )
plot( shaz.t, 1.0.-exp.(-shaz.u)  )
plot!( shaz.t, cdf(Γchron,shaz.t), ls = :dash )

