using CSV, DataFrames, GLMakie

# Ruta al archivo CSV
project_root = joinpath(@__DIR__, "..")
csv_path = joinpath(project_root, "data", "pendulum_output.csv")

# Cargar datos
df = CSV.read(csv_path, DataFrame)

# Extraer columnas
t = df.t
theta1 = df.theta1
theta2 = df.theta2

# Parámetros del péndulo
L1 = 1.0
L2 = 1.0

# Calcular posiciones cartesianas
x1 = L1 .* sin.(theta1)
y1 = .-L1 .* cos.(theta1)
x2 = x1 .+ L2 .* sin.(theta2)
y2 = y1 .- L2 .* cos.(theta2)

# Crear figura y ejes con escalado automático
fig = Figure(size = (600, 600))
ax = Axis(fig[1, 1], xlabel = "x", ylabel = "y", title = "Animación del péndulo doble")
axislimits = 1.1 * (L1 + L2)
limits!(ax, -axislimits, axislimits, -axislimits, axislimits)

# Crear líneas iniciales
pendulum_plot = lines!(ax, [0.0, x1[1], x2[1]], [0.0, y1[1], y2[1]], linewidth = 3, color = :red)

# Animar y guardar
nframes = length(t)
record(fig, joinpath(project_root, "visualization", "pendulum_animation.mp4"), 1:nframes; framerate = 60) do i
    pendulum_plot[1] = [0.0, x1[i], x2[i]]
    pendulum_plot[2] = [0.0, y1[i], y2[i]]
end