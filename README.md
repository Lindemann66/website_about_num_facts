# README

Required commands for application launching:
- rbenv install 2.7.1
- gem install bundler (gem install bundler -v "~>1.0")
- bundle install
- bundle exec rake db:create
- bundle exec rails server

To start viewing you need to open http://127.0.0.1:3000/

TODO:
- Add tests
- Add a more complex interface (ability to change parameters in all requests directly from interface)
- Add rubocop
- Add html #anchors
- Separate frontend through npm or something. Inside backend repo or (preferably) not