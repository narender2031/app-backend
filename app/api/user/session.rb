require 'grape-swagger'
module User
  class Session < Grape::API
		default_format :json
		# authantication methods in helpers 
		helpers do 
			def authenticate
				token = headers['Authorization']
				User.exists?(token: token)
				if User.exists?(token: token)
						@current_user = User.find_by(token: token)
				else
						error! 'Unauthorized', 401
				end
			end
			def current_user
					@current_user
			end
		end
		# login SignUp Api's
		resource :destinor do 
			desc "Quries Destinors"
			params do 
				#require all parameter come from request and also define the data flow in body or header
				requires :email, type:String, documentation: { in: 'body' }
				requires :name, type:String
				requires :phone, type:String
			end
			#define the methos here post, get, put delete
			post '/' do 
				status 200
				if params[:email].blank?
					error!({error:"email is missing"},404)
				end
				if params[:name].blank?
					error!({error: "Name is blank"},404)
				end
				if params[:phone].blank?
					error!({error: "phone is blank"},404)
				end
				if params[:email].include?("@")
					if params[:phone].length === 10
						Destinor.create!({
							name:params[:name],
							email:params[:email],
							phone:params[:phone]
						})
						({sucess: "Destinor is register"}) 
					else
						error!({error: "email is wrong"},401)
					end
				else
					error!({error: "email is wrong"},401)
				end
			end
		end
  end
end