using CSV, DataFrames, GLMakie

# Construir ruta absoluta desde el directorio del proyecto
project_root = joinpath(@__DIR__, "..")
csv_path = joinpath(project_root, "data", "pendulum_output.csv")

# Cargar datos
df = CSV.read(csv_path, DataFrame)

# Extraer columnas
t = df.t
theta1 = df.theta1
theta2 = df.theta2

# Visualización de ángulos vs tiempo
fig = Figure(resolution = (800, 400))
ax = Axis(fig[1, 1], xlabel = "t (s)", ylabel = "Ángulo (rad)", title = "Ángulos del péndulo doble")

lines!(ax, t, theta1, label = "θ₁", color = :blue)
lines!(ax, t, theta2, label = "θ₂", color = :red)
axislegend(ax)

display(fig)

sleep(15)