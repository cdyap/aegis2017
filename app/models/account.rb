class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:student_id]
  belongs_to :timeslot
  belongs_to :groupshot
  # validates_uniqueness_of :email, :student_id
  
  def to_s
    "#{self.student_id}, #{self.name}, #{self.yr} - #{self.course}"
  end

  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      #raise conditions.inspect
      if login = conditions.delete(:id)
        where(conditions.to_hash).where(["student_id = :value", { :value => login }]).first
      else
        where(conditions.to_hash).first
      end
    end
  def create_or_update
      raise ReadOnlyRecord, "#{self.class} is marked as readonly" if readonly?
      account = Account.where(student_id: self.student_id).first
      if account
        self.id = account.id
      end
      result = new_record? ? _create_record : _update_record
      result != false
    end

    # create_or_update comes from persistence.rb
end
