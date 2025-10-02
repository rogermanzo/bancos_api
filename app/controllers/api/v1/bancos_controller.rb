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
    latitud = params[:latitud].to_f
    longitud = params[:longitud].to_f
    
    if latitud.zero? || longitud.zero?
      render json: { error: 'Latitud y longitud son requeridas' }, status: :bad_request
      return
    end

    banco_cercano, distancia = Bank.banco_mas_cercano(latitud, longitud)
    
    if banco_cercano
      render json: {
        banco: banco_cercano,
        distancia_km: distancia.round(2)
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
