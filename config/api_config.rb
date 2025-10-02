module ApiConfig
  # Configuración de la API
  API_VERSION = 'v1'
  API_BASE_PATH = '/api/v1'
  
  # Límites de distancia
  DISTANCE_THRESHOLD = 10.0 # km
  
  # Configuración de coordenadas
  LATITUDE_RANGE = -90.0..90.0
  LONGITUDE_RANGE = -180.0..180.0
  
  # Configuración de logging
  LOG_DISTANCE_ALERTS = true
  LOG_METRICS = true
end
