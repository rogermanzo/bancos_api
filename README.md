# Bancos API

API REST para gestión de bancos con funcionalidad de geolocalización.

## Cómo levantar el proyecto

### Prerrequisitos
- Ruby 3.4.0
- Rails 7.2.0
- SQLite3

### Instalación

1. Clonar el repositorio:
```bash
git clone https://github.com/rogermanzo/bancos_api.git
cd bancos_api
```

2. Instalar dependencias:
```bash
bundle install
```

3. Configurar la base de datos:
```bash
rails db:migrate
```

4. Levantar el servidor:
```bash
rails server
```

El servidor estará disponible en `http://localhost:3000`

## Endpoints disponibles

### 1. Crear banco
**POST** `/api/v1/bancos`

**Body:**
```json
{
  "banco": {
    "nombre": "Banco Nacional",
    "direccion": "Av. Principal 123",
    "latitud": -12.0464,
    "longitud": -77.0428
  }
}
```

**Respuesta exitosa (201):**
```json
{
  "id": 1,
  "nombre": "Banco Nacional",
  "direccion": "Av. Principal 123",
  "latitud": "-12.0464",
  "longitud": "-77.0428",
  "created_at": "2024-01-01T10:00:00.000Z",
  "updated_at": "2024-01-01T10:00:00.000Z"
}
```

### 2. Ver banco
**GET** `/api/v1/bancos/:id`

**Respuesta exitosa (200):**
```json
{
  "id": 1,
  "nombre": "Banco Nacional",
  "direccion": "Av. Principal 123",
  "latitud": "-12.0464",
  "longitud": "-77.0428",
  "created_at": "2024-01-01T10:00:00.000Z",
  "updated_at": "2024-01-01T10:00:00.000Z"
}
```

### 3. Banco más cercano
**GET** `/api/v1/bancos/cercano?latitud=-12.0464&longitud=-77.0428`

**Respuesta exitosa (200):**
```json
{
  "banco": {
    "id": 1,
    "nombre": "Banco Nacional",
    "direccion": "Av. Principal 123",
    "latitud": "-12.0464",
    "longitud": "-77.0428"
  },
  "distancia_km": 2.5
}
```

## Ejemplos de uso

### Crear un banco con cURL:
```bash
curl -X POST http://localhost:3000/api/v1/bancos \
  -H "Content-Type: application/json" \
  -d '{
    "banco": {
      "nombre": "Banco de Prueba",
      "direccion": "Calle Test 456",
      "latitud": -12.0464,
      "longitud": -77.0428
    }
  }'
```

### Buscar banco más cercano:
```bash
curl "http://localhost:3000/api/v1/bancos/cercano?latitud=-12.0464&longitud=-77.0428"
```

## Funcionalidades

- ✅ Crear bancos con coordenadas geográficas
- ✅ Consultar banco por ID
- ✅ Encontrar el banco más cercano a una ubicación
- ✅ Cálculo de distancia usando fórmula de Haversine
- ✅ Logging de advertencia cuando el banco más cercano está a más de 10km
- ✅ Validaciones de coordenadas geográficas
