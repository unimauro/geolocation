class GeolocationValue < ApplicationRecord
  acts_as_paranoid
  
  validates :ip, presence: true, uniqueness: true
  validates :web, presence: true, uniqueness: true

  # Ocultar registros soft deleted por defecto
  default_scope { where(deleted_at: nil) }

  # Método para realizar un soft delete
  def soft_delete
    update(deleted_at: Time.current)
  end

  # Método para verificar si el registro está soft deleted
  def deleted?
    deleted_at.present?
  end
end
