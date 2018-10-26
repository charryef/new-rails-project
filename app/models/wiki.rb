class Wiki < ApplicationRecord
  #updating user association with optional: true fixed the failure error, User must exist
  belongs_to :user, optional: true
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators

  default_scope { order('created_at DESC') }
  scope :visible_to, -> (user) { user ? all : joins(:wiki).where('wikis.private' => true) }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 10 }, presence: true

  def find_collaborator(user)
    collaborators.find_by(user_id: user.id)
  end
end
