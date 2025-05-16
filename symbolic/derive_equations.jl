using ModelingToolkit

@parameters t
@variables θ₁(t) θ₂(t)        # ángulos
@derivatives D'~t

@parameters m₁ m₂ l₁ l₂ g     # masas, longitudes, gravedad

# Velocidades angulares
ω₁ = D(θ₁)
ω₂ = D(θ₂)

# Posiciones cartesianas
x₁ = l₁*sin(θ₁)
y₁ = -l₁*cos(θ₁)
x₂ = x₁ + l₂*sin(θ₂)
y₂ = y₁ - l₂*cos(θ₂)

# Velocidades cartesianas
vx₁ = D(x₁)
vy₁ = D(y₁)
vx₂ = D(x₂)
vy₂ = D(y₂)

# Energía cinética
T = 0.5*m₁*(vx₁^2 + vy₁^2) + 0.5*m₂*(vx₂^2 + vy₂^2)

# Energía potencial
V = m₁*g*y₁ + m₂*g*y₂

# Lagrangiano
L = T - V

eqs = LagrangianEquations(L, [θ₁, θ₂])

println("Ecuaciones de movimiento:")
display(eqs)