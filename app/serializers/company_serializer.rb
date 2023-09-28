class CompanySerializer < ActiveModel::Serializer
  attributes :id, :organization_id, :name, :country, :founded, :industry, :description, :number_of_employees, :website
end
