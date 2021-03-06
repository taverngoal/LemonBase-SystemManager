class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
      # cannot :show, Account
    else
      can :update, User, id: user.id # 只能修改自己

      can :create, Account
      can [:update, :destroy], Account, officer: user
      can :read, Account do |account|
        account.officer == user || account.is_public
      end

      can :create, AccountDetail, :account => {officer: user}
      can [:update, :destroy], AccountDetail, :account => {officer: user}
      can :read, AccountDetail do |detail|
        detail.account.officer==user || detail.account.is_public
      end
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
