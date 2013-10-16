class Ability
  include CanCan::Ability

  def initialize(user, request)
    can :read, User
    can :unsubscribe, User
    can :read, Answer
    can :read, Poke
    can :read, Campaign, Campaign.accepted do |campaign|
      campaign.accepted_at
    end
    can :read, Campaign, Campaign.unmoderated do |campaign|
      !campaign.preview_code.nil? and campaign.preview_code == request.params[:preview_code]    
    end
    can :create, Poke, kind: 'email'
    can :create, Poke, kind: 'phone'

    if user && user.admin?
      can :manage, :all
    elsif user
      can :create, Campaign
      can :create, Poke
      can :update, Campaign, user_id: user.id
      can :read, Campaign, user_id: user.id
      can :update, User, id: user.id
    end

    if request.params[:format] == "json"
      if request.params[:token] == ENV['API_TOKEN']
        can :index, Poke
      else
        cannot :index, Poke
      end
    end
  end
end
