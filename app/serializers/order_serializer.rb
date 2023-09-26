class OrderSerializer < ActiveModel::Serializer
    attributes :id, :customer, :employee_id, :order_date, :required_date, :shipped_date, :shipped_id, :freight
end