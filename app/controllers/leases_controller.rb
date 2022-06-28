class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def create 
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    def destroy 
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end    

    private

    def render_not_found_response
        render json: { error: "Lease not found" }, status: :not_found
    end
    
    def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end

end
