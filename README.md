# bundle exec rake db:drop db:create db:migrate db:seed (Rails 7)

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
