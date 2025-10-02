class Api::V1::BancosController < ApplicationController
  before_action :set_banco, only: [:show]

  # POST /api/v1/bancos
  def create
    @banco = Bank.new(banco_params)
    
    if @banco.save
      render json: @banco, status: :created
    else
      render json: { errors: @banco.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /api/v1/bancos/:id
  def show
    render json: @banco
  end

  # GET /api/v1/bancos/cercano
  def cercano
    latitude = params[:latitud].to_f
    longitude = params[:longitud].to_f
    
    if latitude.zero? || longitude.zero?
      render json: { error: 'Latitud y longitud son requeridas' }, status: :bad_request
      return
    end

    # Usar directamente el servicio
    finder = NearestBankFinder.new(latitude, longitude)
    nearest_bank, distance = finder.find
    
    if nearest_bank
      render json: {
        banco: nearest_bank,
        distancia_km: distance.round(2)
      }
    else
      render json: { error: 'No se encontraron bancos' }, status: :not_found
    end
  end

  private

  def set_banco
    @banco = Bank.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Banco no encontrado' }, status: :not_found
  end

  def banco_params
    params.require(:banco).permit(:nombre, :direccion, :latitud, :longitud)
  end
end
