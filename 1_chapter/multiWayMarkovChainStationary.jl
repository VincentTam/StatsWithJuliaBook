using LinearAlgebra, StasBase

# Transition probability matrix
P = [0.2 0.3 0.5;
     0.7 0.1 0.2;
     0.2 0.4 0.4]

# First way (very quick: 0.010701)
@time piProb1 = (P^10000000000)[1,:]

# Second way (analytical solution)
A = vcat((P' - Matrix{Float64}(I, 3, 3))[1:2,:],ones(3)')
b = [0 0 1]'
piProb2 = A\b

# Third way (analytical solution)
eigVecs = eigvecs(copy(P'))
highestVec = eigVecs[:,findmax(abs.(eigvals(P)))[2]]
piProb3 = Array{Float64}(highestVec)/norm(highestVec,1);

# Fourth way (slow and inaccurate: 8s for N = 10^7, err: 1e-4)
numInState = zeros(3)
state = 1
N = 10^7
@time for t in 1:N
    numInState[state] += 1
    global state = sample(1:3,weights(P[state,:]))
end
piProb4 = numInState/N

[piProb1 piProb2 piProb3 piProb4]
