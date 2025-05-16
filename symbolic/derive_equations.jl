using Symbolics

@variables t
@variables θ₁(t) θ₂(t)
@variables m₁ m₂ l₁ l₂ g
D = Differential(t)

# Posiciones cartesianas
x₁ = l₁ * sin(θ₁)
y₁ = -l₁ * cos(θ₁)
x₂ = x₁ + l₂ * sin(θ₂)
y₂ = y₁ - l₂ * cos(θ₂)

# Velocidades cartesianas
vx₁ = expand_derivatives(D(x₁))
vy₁ = expand_derivatives(D(y₁))
vx₂ = expand_derivatives(D(x₂))
vy₂ = expand_derivatives(D(y₂))

# Energía cinética y potencial
T = 0.5 * m₁ * (vx₁^2 + vy₁^2) + 0.5 * m₂ * (vx₂^2 + vy₂^2)
V = m₁ * g * y₁ + m₂ * g * y₂
L = T - V

# Derivadas para ecuaciones de Euler–Lagrange
∂L_∂θ₁    = expand_derivatives(Differential(θ₁)(L))
∂L_∂θ₂    = expand_derivatives(Differential(θ₂)(L))
∂L_∂θ₁dot = expand_derivatives(Differential(D(θ₁))(L))
∂L_∂θ₂dot = expand_derivatives(Differential(D(θ₂))(L))

d_dt_∂L_∂θ₁dot = expand_derivatives(D(∂L_∂θ₁dot))
d_dt_∂L_∂θ₂dot = expand_derivatives(D(∂L_∂θ₂dot))

# Ecuaciones de movimiento
eq1 = simplify(d_dt_∂L_∂θ₁dot - ∂L_∂θ₁)
eq2 = simplify(d_dt_∂L_∂θ₂dot - ∂L_∂θ₂)

println("Primera ecuación de Euler-Lagrange:")
display(eq1)
println("Segunda ecuación de Euler-Lagrange:")
display(eq2)

# Sustitución para resolver
@variables th1 om1 th2 om2 acc1 acc2

eq1_s = substitute(eq1, Dict(
    θ₁ => th1,
    D(θ₁) => om1,
    D(D(θ₁)) => acc1,
    θ₂ => th2,
    D(θ₂) => om2,
    D(D(θ₂)) => acc2
))

eq2_s = substitute(eq2, Dict(
    θ₁ => th1,
    D(θ₁) => om1,
    D(D(θ₁)) => acc1,
    θ₂ => th2,
    D(θ₂) => om2,
    D(D(θ₂)) => acc2
))

# Resolver aceleraciones
using Symbolics: solve_for
sols = solve_for([eq1_s, eq2_s], [acc1, acc2])

println("α₁ (aceleración de θ₁) =")
display(sols[1])
println("\nα₂ (aceleración de θ₂) =")
display(sols[2])