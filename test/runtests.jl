using Interpolation

using Test: @test, @testset

@testset "Interpolation Tests" begin
    @testset "Simple Analytic Examples" begin
        @test isapprox(polyint([1.0, 2.0], [1.0, 2.0])(3.0), 3.0)
        @test isapprox(polyint([1.0, 2.0, 3.0], [1.0, 4.0, 9.0])(4.0), 16.0)
        @test isapprox([polyint([1.0, 2.0, 3.0], [1.0, 4.0, 9.0], 1)(4.0)...], [10.0, 14.0])
    end

    @testset "Random Third Order Polynomials" begin
        for i in 1:10
            a,b,c,d = randn(4) # Roots

            xs = randn(4)

            ys = Float64[]
            for x in xs
                push!(ys, d*(x-a)*(x-b)*(x-c))
            end

            x = randn()
            poly = d*(x-a)*(x-b)*(x-c)

            @test isapprox(polyint(xs, ys)(x), poly)
        end
    end
end
