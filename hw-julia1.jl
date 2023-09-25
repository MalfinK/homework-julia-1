using Plots
using DataFrames
using CSV

# Baca dataset Iris dari file CSV
iris_df = CSV.File("iris.csv") |> DataFrame

# Pisahkan data untuk masing-masing kelas
setosa_data = iris_df[iris_df.class .== "Iris-setosa", :]
# println(setosa_data)
versicolor_data = iris_df[iris_df.class .== "Iris-versicolor", :]
virginica_data = iris_df[iris_df.class .== "Iris-virginica", :]

# Plot data dengan kontur yang dibatasi oleh garis
scatter(setosa_data.petallength, setosa_data.petalwidth, label="Iris-setosa", color=:blue, marker=:circle)
scatter!(versicolor_data.petallength, versicolor_data.petalwidth, label="Iris-versicolor", color=:green, marker=:square)
scatter!(virginica_data.petallength, virginica_data.petalwidth, label="Iris-virginica", color=:red, marker=:diamond)

# Buat garis kontur untuk membatasi kelas-kelas yang ada
#= plot!([2.5, 2.5], [0, 2.5], color=:black, label="anu")
plot!([2.5, 7], [0.8, 0.8], color=:blue, label="ana")
plot!([2.5, 7], [1.75, 1.75], color=:red, label="anabel") =#
plot!([7, 4], [0.5, 2.5], label="Boundary 1"; marker=(:circle,5))
plot!([3, 1], [0, 2.5], label="Boundary 2"; marker=(:circle,5))

# Tampilkan legenda
# legend()

png("hw-julia1.png")
