using Plots
using DataFrames
using CSV
using GLM # Untuk menghasilkan formula dan model regresi linear

# Baca dataset Iris dari file CSV
iris_df = CSV.File("iris.csv") |> DataFrame

# Pisahkan data untuk masing-masing kelas
setosa_data = iris_df[iris_df.class .== "Iris-setosa", :]
versicolor_data = iris_df[iris_df.class .== "Iris-versicolor", :]
virginica_data = iris_df[iris_df.class .== "Iris-virginica", :]

# Hitung model regresi linear untuk memisahkan Iris-setosa vs. Iris-versicolor
setosa_versicolor_model = lm(@formula(petalwidth ~ petallength), vcat(setosa_data, versicolor_data))

# Hitung model regresi linear untuk memisahkan Iris-setosa vs. Iris-virginica
setosa_virginica_model = lm(@formula(petalwidth ~ petallength), vcat(setosa_data, virginica_data))

# Hitung model regresi linear untuk memisahkan Iris-versicolor vs. Iris-virginica
versicolor_virginica_model = lm(@formula(petalwidth ~ petallength), vcat(versicolor_data, virginica_data))

# Scatter plot data
scatter(setosa_data.petallength, setosa_data.petalwidth, label="Iris-setosa", color=:blue, marker=:circle)
scatter!(versicolor_data.petallength, versicolor_data.petalwidth, label="Iris-versicolor", color=:green, marker=:square)
scatter!(virginica_data.petallength, virginica_data.petalwidth, label="Iris-virginica", color=:red, marker=:diamond)

# Plot garis kontur berdasarkan model regresi
x = minimum(iris_df.petallength):0.1:maximum(iris_df.petallength)
plot!(x, predict(setosa_versicolor_model, DataFrame(petallength=x)), label="Boundary Setosa-Versicolor", color=:black)
plot!(x, predict(setosa_virginica_model, DataFrame(petallength=x)), label="Boundary Setosa-Virginica", color=:purple)
plot!(x, predict(versicolor_virginica_model, DataFrame(petallength=x)), label="Boundary Versicolor-Virginica", color=:orange)

# Tampilkan legenda
# legend()

png("hw-julia3.png")
