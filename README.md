# Row-level Multitenancy with ActsAsTenant (Rails 7)

---

From the GoRails video:

https://gorails.com/episodes/row-level-multitenancy-in-rails

Their Rails 4.2.1 example code:

https://github.com/gorails-screencasts/row-level-multitenancy

---
I first created the project in Rubymine as Rails app using:

- rails 7.0.4.3
- ruby 3.2.2
- database: postgresql
- javascript: importmaps
- additional option: none

After project setup in Rubymine, add .idea to .gitignore file.

Then ran:

```bash
bundle exec rake db:drop db:create db:migrate db:seed
```

#### Commit: 'Initial project setup', [173d0ac](https://github.com/robault/ActsAsTenantExample/commit/173d0ac9d8fc611ba4670a20a192eee1e90bf8b4)

---

The video assumes an existing rails project with devise already installed. So I did that setup.

I first added the devise and acts_as_tenant gems to the Gemfile and ran:

```bash
bundle # same as 'bundle install
```

Then ran:

```bash
bundle exec rails generate devise:install
bundle exec rails generate devise:views
```

The devise install walks through the steps to add the following to the config/environments/development.rb file:

```ruby
config.action_mailer.default_url_options = { host: 'lvh.me', port: 3000 }
```

I also added the following to the config/environments/development.rb file to use the 'lvh.me' host name, which is a new requirement in recent versions of Rails:

```ruby
config.hosts << 'lvh.me' # allows lvh.me to work in development
config.hosts << /.*\.lvh\.me/ # allows subdomains to work in development
```

I did not change or configure devise in any other way.

I then created a controller to use as the root of the application:

```bash
bundle exec rails generate controller Hello index
```
 ...and set the root in the routes.rb file:
 
```ruby
Rails.application.routes.draw do
  root "hello#index"
end
```

Part of the devise setup is to create a User model:

```bash
bundle exec rails generate devise User
```

Then ran the db migration:

```bash
bundle exec rake db:migrate
```

I was then able to start the server and see the root page at: http://lvh.me:3000

#### Commit: 'Gems, devise, User, and root route setup', [78e1ba3](https://github.com/robault/ActsAsTenantExample/commit/78e1ba324112b52d589163af91cae9256df1048a)

---

Next, I added the filter to the application controller for tenant lookup.

Then added an initializer for acts_as_tenant, turning the require_tenant setting off.

This allows the application to run without a tenant, which assumes there is a top level presence in a multi-tenant system that has access to all tenant data.

Next in the video, I scaffolded Post with a belongs_to User so that Posts are a tenant specific object:

```bash
bundle exec rails generate scaffold Post user:belongs_to title body:text
```

Then ran the db migration:

```bash
bundle exec rake db:migrate
```

I also added the following to the Post model:

```ruby
class Post < ApplicationRecord
  acts_as_tenant(:user)
  
  belongs_to :user
end
```

The acts_as_tenant(:user) line adds a default scope to the Post model that enforces a lookup by the tenant, which in this case is the User model.

#### Commit: 'Setting up a Post model with a tenant filter', [2789867](https://github.com/robault/ActsAsTenantExample/commit/27898670077e816ad9abd0aa05035b98bec8c68a)

---

Following along, I then removed user_id from the post params and post forms.

I also added (this is just me, it was not in the video) a menu to get around the application.

Notice the Devise sign out link uses a different format for Rails 7 now that it includes Turbo.

```html
<div>
  <span><%= link_to 'Home |', root_path %></span>
  <span><%= link_to 'Sign Up |', new_user_registration_path %></span>
  <span><%= link_to 'Login |', user_session_path %></span>
  <span><%= link_to 'Posts |', posts_path %></span>
  <span><%= link_to 'New Post |', new_post_path %></span>
  <span><%= link_to 'Logout', destroy_user_session_path, data: { turbo_method: :delete } %></span>
</div>
```

This requiring the delete method is set automatically by default in the Devise initializer as:

```ruby
config.sign_out_via = :delete
```

#### Commit: 'Post controller and forms setup', [a915038](https://github.com/robault/ActsAsTenantExample/commit/a9150389d63cde9a3deae72f3a8148c07009f3e2)

---
