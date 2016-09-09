class AdminsController < ApplicationController
	before_filter :authenticate_admin!

	def index
		@soh_students = Student.where(school: "SOH").count
		@som_students = Student.where(school: "SOM").count
		@sose_students = Student.where(school: "SOSE").count
		@soss_students = Student.where(school: "SOSS").count
		@students = @soh_students + @som_students + @sose_students + @soss_students

		@soh_accounts = Account.where(school: "SOH").count
		@som_accounts = Account.where(school: "SOM").count
		@sose_accounts = Account.where(school: "SOSE").count
		@soss_accounts = Account.where(school: "SOSS").count
		@accounts = @soh_accounts + @som_accounts + @sose_accounts + @soss_accounts
	end

	def students
		@students = Student.all.order('id ASC').paginate(:page => params[:page], :per_page => 30)
	end

	def accounts
		@accounts = Account.all.order('student_id ASC').paginate(:page => params[:page], :per_page => 30)

		@account_number = Account.count
	end
end
