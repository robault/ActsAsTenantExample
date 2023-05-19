class Post < ApplicationRecord
  acts_as_tenant(:user)

  # the above line is doing this behind the scenes:
  # default_scope { where(user: user) }
  # that way you can use Post.all, Post.new, or Post.find, and it will always be scoped to the tenant
  # this allows you to scaffold objects using the rails generator, add acts_as_tenant,
  # and not have to change the generated code

  belongs_to :user
end
