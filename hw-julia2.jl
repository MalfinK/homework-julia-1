using Plots
using DataFrames
using CSV
using GLM  # Import modul GLM untuk @formula
using Statistics  # Import modul Statistics untuk mean

# Baca dataset Iris dari file CSV
iris_df = CSV.File("iris.csv") |> DataFrame

# Pisahkan data untuk masing-masing kelas
setosa_data = iris_df[iris_df.class .== "Iris-setosa", :]
versicolor_data = iris_df[iris_df.class .== "Iris-versicolor", :]
virginica_data = iris_df[iris_df.class .== "Iris-virginica", :]

# Plot data dengan kontur yang dibatasi oleh garis
scatter(setosa_data.petallength, setosa_data.petalwidth, label="Iris-setosa", color=:blue, marker=:circle)
scatter!(versicolor_data.petallength, versicolor_data.petalwidth, label="Iris-versicolor", color=:green, marker=:square)
scatter!(virginica_data.petallength, virginica_data.petalwidth, label="Iris-virginica", color=:red, marker=:diamond)

# Buat garis kontur untuk membatasi kelas-kelas yang ada secara dinamis (sesuai data) dengan menggunakan metode regresi linear
# Buat model regresi linear untuk membatasi kelas-kelas yang ada
model = lm(@formula(petalwidth ~ petallength), iris_df)

# Buat data untuk garis kontur
x = 3:0.01:7
y = predict(model, DataFrame(petallength=x))

# Buat garis kontur untuk membatasi kelas-kelas yang ada
plot!(x, y, label="Boundary 2"; marker=(:circle, 5))

# Tampilkan plot
# show()

# Simpan plot ke dalam file PNG
png("hw-julia2.png")