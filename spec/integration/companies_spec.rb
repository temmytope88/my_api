require 'swagger_helper'

describe 'Organizations API' do

  path '/companies/{id}' do

    get 'Retrieves an organization' do
      tags 'Organizations'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :integer
      response '200', 'Organization found' do
        schema type: :object,
          properties: {
            id: { type: :integer},
            name:  { type: :string},
            organization_id: {type: :string},
            website: {type: :string},
            founded: { type: :string, format: :date},
            number_of_employees: {type: :integer},
            industry: { type: :string },
            description: { type: :string },
            country: {type: :string}              
           
          },
          required: [ 'id', 'name', 'status' ]

        let(:id) { Company.create(name: 'foo', status: 'bar', photo_url: 'http://example.com/avatar.jpg').id }
        run_test!
      end
      response '404', 'Organization not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'update an organization' do
        tags 'Organizations'
        consumes 'application/json'
        parameter name: :id, in: :path, type: :integer
        parameter name: :order, in: :body, schema: {
        type: :object,
        properties: {
          name: {type: :string},
          website: {type: :string},
          founded: { type: :string, format: :date},
          number_of_employees: {type: :integer},
          industry: { type: :string },
          description: { type: :string },
          country: {type: :string}
        },
        required: [ "name", "website", "founded", "number_of_employees", "industry", "description", "country" ]
        }
        response '200', 'Organization updated' do
            let(:company) { {}}
            run_test! 
        end  
        response '422', 'invalid request' do
            let(:company) { {}}
            run_test! 
        end
        response '401', 'Unauthorised User' do
            let(:company) { {}}
            run_test! 
        end
    end

    delete 'delete an organization' do
      tags 'Organizations'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :integer
      response '204', 'Organization found and deleted' do
        let(:id) {Company.create().id}
        end
      response '401', 'Unauthorised User' do
        let(:id) { 'invalid' }
        run_test!
      end
      response '404', 'Organization record not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
 

  path '/companies' do

    get 'Retrieves all organization' do
      tags 'Organizations'
      produces 'application/json'
      response '200', 'OK' do
        schema type: :array, 
          items: {
            properties: {
              id: { type: :integer},
              name: { type: :string},
              organization_id: {type: :string},
              website: {type: :string},
              founded: { type: :string, format: :date},
              number_of_employees: {type: :integer},
              industry: { type: :string },
              description: { type: :string },
              country: {type: :string}
            }
          },
          required: [ 'id', 'organization_id', 'name', 'website', 'country', 'founded', 'industry', 'description', 'number_of_employees']
        let(:company) { create(:company) }
        run_test!
      end
      response '422', 'invalid request' do
        let(:order) { { name: 'foo' } }
        run_test!
      end
    end

    post 'Creates an organization' do
      tags 'Organizations'
      consumes 'application/json'
      parameter name: :order, in: :body, schema: {
        type: :object,
        properties: {
         
          name: { type: :string},
          organization_id: {type: :string},
          website: {type: :string},
          founded: { type: :string, format: :date},
          number_of_employees: {type: :integer},
          industry: { type: :string },
          description: { type: :string },
          country: {type: :string}
        },
        required: [ 'organization_id', 'name', 'website', 'country', 'founded', 'industry', 'description', 'number_of_employees' ]
      }

      response '201', 'organization created' do
        let(:company) { {}}
        run_test!
      end
      response '422', 'invalid request' do
        let(:company) { { name: 'null'} }
        run_test!
      end
      response '401', 'Unauthorised User' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end