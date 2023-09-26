require 'swagger_helper'

describe 'Order API' do

  path '/orders/{id}' do

    get 'Retrieves an order' do
      tags 'Orders'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :integer
      response '200', 'Order found' do
        schema type: :object,
          properties: {
            id: { type: :integer},
            customer: { type: :string},
            employee_id: { type: :integer},
            order_date: { type: :string, format: :date},
            required_date:  { type: :string, format: :date},
            shipped_date:  { type: :string, format: :date},
            shipped_id: { type: :integer},
            freight: { type: :number, format: :float}
           
          },
          required: [ 'id', 'name', 'status' ]

        let(:id) { Order.create(name: 'foo', status: 'bar', photo_url: 'http://example.com/avatar.jpg').id }
        run_test!
      end
      response '404', 'Order not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'update an order' do
        tags 'Orders'
        consumes 'application/json'
        parameter name: :id, in: :path, type: :integer
        parameter name: :order, in: :body, schema: {
        type: :object,
        properties: {
          customer: { type: :string},
          employee_id: { type: :integer},
          order_date: { type: :string, format: :date},
          required_date:  { type: :string, format: :date},
          shipped_date:  { type: :string, format: :date},
          shipped_id: { type: :integer},
          freight: { type: :number, format: :float}
        },
        required: [ 'id', 'customer', 'employee_id' ,'order_date', 'required_date', 'shipped_date', 'shipped_id', 'freight' ]
        }
        response '200', 'Order updated' do
            let(:order) { {}}
            run_test! 
        end  
        response '422', 'invalid request' do
            let(:order) { {}}
            run_test! 
        end
        response '401', 'Unauthorised User' do
            let(:order) { {}}
            run_test! 
        end
    end

    delete 'delete an order' do
      tags 'Orders'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :integer
      response '204', 'Order found and deleted' do
        let(:id) {Order.create().id}
        end
      response '401', 'Unauthorised User' do
        let(:id) { 'invalid' }
        run_test!
      end
      response '404', 'Order record not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
 

  path '/orders' do

    get 'Retrieves all orders' do
      tags 'Orders'
      produces 'application/json'
      response '200', 'OK' do
        schema type: :array, 
          items: {
            properties: {
              id: { type: :integer},
              customer: { type: :string},
              employee_id: { type: :integer},
              order_date: { type: :string, format: :date},
              required_date:  { type: :string, format: :date},
              shipped_date:  { type: :string, format: :date},
              shipped_id: { type: :integer},
              freight: { type: :number, format: :float}
            }
          },
          required: [ 'id', 'customer', 'employee_id' ,'order_date', 'required_date', 'shipped_date', 'shipped_id', 'freight' ]
        let(:order) { create(:order) }
        run_test!
      end
      response '422', 'invalid request' do
        let(:order) { { name: 'foo' } }
        run_test!
      end
    end

    post 'Creates an order' do
      tags 'Orders'
      consumes 'application/json'
      parameter name: :order, in: :body, schema: {
        type: :object,
        properties: {
          customer: { type: :string},
          employee_id: { type: :integer},
          order_date: { type: :string, format: :date},
          required_date:  { type: :string, format: :date},
          shipped_date:  { type: :string, format: :date},
          shipped_id: { type: :integer},
          freight: { type: :number, format: :float}
        },
        required: [ 'id', 'customer', 'employee_id' ,'order_date', 'required_date', 'shipped_date', 'shipped_id', 'freight' ]
      }

      response '201', 'order created' do
        let(:order) { {}}
        run_test!
      end
      response '422', 'invalid request' do
        let(:order) { { name: 'null'} }
        run_test!
      end
      response '401', 'Unauthorised User' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end