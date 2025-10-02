# Seeds para datos de prueba
puts "🌱 Creando bancos de prueba..."

# Bancos en Lima, Perú
banks_data = [
  {
    nombre: "Banco de Crédito del Perú",
    direccion: "Av. Larco 123, Miraflores, Lima",
    latitud: -12.1194,
    longitud: -77.0342
  },
  {
    nombre: "BBVA Continental",
    direccion: "Av. Javier Prado 4200, San Isidro, Lima",
    latitud: -12.0931,
    longitud: -77.0465
  },
  {
    nombre: "Scotiabank",
    direccion: "Av. Arequipa 2620, Lince, Lima",
    latitud: -12.0839,
    longitud: -77.0311
  },
  {
    nombre: "Interbank",
    direccion: "Av. El Derby 254, Santiago de Surco, Lima",
    latitud: -12.1500,
    longitud: -77.0167
  },
  {
    nombre: "Banco de la Nación",
    direccion: "Av. Abancay 491, Cercado de Lima",
    latitud: -12.0464,
    longitud: -77.0428
  }
]

banks_data.each do |bank_data|
  bank = Bank.find_or_create_by(nombre: bank_data[:nombre]) do |b|
    b.direccion = bank_data[:direccion]
    b.latitud = bank_data[:latitud]
    b.longitud = bank_data[:longitud]
  end
  
  puts "✅ Banco creado: #{bank.nombre}"
end

puts "🎉 ¡Bancos de prueba creados exitosamente!"
puts "📍 Total de bancos: #{Bank.count}"