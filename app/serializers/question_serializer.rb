class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :pri, :question, :teaming_stages, :appears_day, :frequency, :question_type, :conditions, :mapping_id, :required?
end
