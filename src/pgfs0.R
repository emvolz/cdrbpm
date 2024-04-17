

f <- function(x) (2809 + 2000*x + 95*x^2) / 4904 
fp <- function(x) (2000 + 2*95*x) / 4904
fpp <- function(x) (2*95) / 4904
fppp <- function(x) 0

fp(1) |> print()
# [1] 0.4465742
# [1] 0.4465742
f1 <- function(x) x*fp(x) / fp(1)
f1(1)
.f1 <- function(x) (2000*x+2*95*x^2) / 4904 / fp(1)
( c(2000, 2*95) / 4904 / fp(1) )
c(2809 , 2000 , 95) / 4904 
# [1] 0.57279772 0.40783034 0.01937194

g <- function(x) (2943 + 1009*x + 477*x^2 + 475*x^3)/4904
gp <- function(x) (1009 + 2*477*x^1 + 3*475*x^2)/4904
gpp <- function(x) (2*477 + 2*3*475*x^1)/4904
gppp <- function(x) (2*3*475)/4904

gp(1) |> print()
# [1] 0.6908646
c(2943 , 1009 , 477 , 475)/4904
# [1] 0.60012235 0.20575041 0.09726754 0.09685971

hshape <- 0.26
hrate <- 1.85 * 7

h <- function(x) (1-log(x)/hrate)^(-hshape)
hp <- function(x) hshape *(1-log(x)/hrate)^(-hshape-1) / (  (hrate*x) )
hpp <- function(x) hshape*((hrate-log(x))/hrate)^(-hshape) * (-hrate+hshape+log(x)+1) / (x^2 * (hrate-log(x))^2)
hppp <- function(x) hshape*((hrate-log(x))/hrate)^(-hshape)  * (hshape^2+3*hshape+2*(hrate-log(x))^2 -3*(hrate-log(x))*(hshape+1)+2 ) / (x^3*(hrate-log(x))^3) 

# finding optimal care rate s.t. 1/3 remain unsequenced after a year 
of = function(r) (pexp( 1, rate =r ) - 2/3)^2
optimise  optimize  
optimise( of, lower = 1e-5, upper = 10 ) 
	   # $minimum
	   # [1] 1.098613
				#
	   # $objective
	   # [1] 1.628415e-13
				#
pexp( 1 , rate = 1.09) 
	   # [1] 0.6637835

# oo contact rates:
m = 0.02 
sigma = 0.039 
gshape = (m/sigma)^2
gscale = (sigma^2/m)
gshape
# [1] 0.2629849
gscale
# [1] 0.07605
