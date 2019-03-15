class User < ApplicationRecord
  rolify
  require 'csv'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :assign_default_role

  def assign_default_role
    add_role(:user) if roles.blank?
  end

  def self.import(file)
    CSV.foreach(file.path ,headers: true) do |row|
      role = Role.find_or_create_by(name: row[6].downcase!)
      mapping = Mapping.find_or_create_by(name: row[9])
      mapping.questions.create(pri: row[0], question: row[1],teaming_stages: row[2], appears_day: row[3], frequency: row[4], question_type: row[5], required?: row[7], conditions: row[8])
    end
  end
end
