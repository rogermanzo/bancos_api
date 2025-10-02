# API Specification - Bancos API

## Información General
- **Versión**: 1.0.0
- **Base URL**: `http://localhost:3000/api/v1`
- **Formato**: JSON
- **Autenticación**: No requerida (para esta versión)

## Endpoints

### 1. Crear Banco
**POST** `/api/v1/bancos`

**Request Body:**
```json
{
  "banco": {
    "nombre": "string (required)",
    "direccion": "string (required)",
    "latitud": "decimal (required, -90 to 90)",
    "longitud": "decimal (required, -180 to 180)"
  }
}
```

**Response (201 Created):**
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

**Response (422 Unprocessable Entity):**
```json
{
  "errors": ["Nombre can't be blank", "Latitud must be between -90 and 90"]
}
```

### 2. Obtener Banco por ID
**GET** `/api/v1/bancos/:id`

**Response (200 OK):**
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

**Response (404 Not Found):**
```json
{
  "error": "Banco no encontrado"
}
```

### 3. Banco Más Cercano
**GET** `/api/v1/bancos/cercano?latitud=-12.0464&longitud=-77.0428`

**Query Parameters:**
- `latitud` (required): Latitud del punto de consulta
- `longitud` (required): Longitud del punto de consulta

**Response (200 OK):**
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

**Response (400 Bad Request):**
```json
{
  "error": "Latitud y longitud son requeridas"
}
```

**Response (404 Not Found):**
```json
{
  "error": "No se encontraron bancos"
}
```

## Códigos de Estado HTTP

| Código | Descripción |
|--------|-------------|
| 200 | OK - Solicitud exitosa |
| 201 | Created - Recurso creado exitosamente |
| 400 | Bad Request - Parámetros inválidos |
| 404 | Not Found - Recurso no encontrado |
| 422 | Unprocessable Entity - Errores de validación |
| 500 | Internal Server Error - Error del servidor |

## Validaciones

### Banco
- **nombre**: Requerido, string
- **direccion**: Requerido, string
- **latitud**: Requerido, decimal entre -90 y 90
- **longitud**: Requerido, decimal entre -180 y 180

### Banco Más Cercano
- **latitud**: Requerido, decimal entre -90 y 90
- **longitud**: Requerido, decimal entre -180 y 180

## Notificaciones

Cuando la distancia al banco más cercano supera los 10km, se registra una alerta en los logs:

```
[BANK_DISTANCE_ALERT] ALERTA: Banco más cercano (Banco Nacional) está a 15.2km desde coordenadas (-12.0464, -77.0428)
```

## Ejemplos de Uso

### cURL - Crear Banco
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

### cURL - Banco Más Cercano
```bash
curl "http://localhost:3000/api/v1/bancos/cercano?latitud=-12.0464&longitud=-77.0428"
```

### JavaScript - Fetch API
```javascript
// Crear banco
const response = await fetch('http://localhost:3000/api/v1/bancos', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({
    banco: {
      nombre: "Banco de Prueba",
      direccion: "Calle Test 456",
      latitud: -12.0464,
      longitud: -77.0428
    }
  })
});

const data = await response.json();
console.log(data);
```
