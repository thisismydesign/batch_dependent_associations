# BatchDependentAssociations

#### Use dependent associations with Rails safely, with automatic batching.

| Branch | Status |
| ------ | ------ |
| Release | [![Build Status](https://travis-ci.org/thisismydesign/batch_dependent_associations.svg?branch=release)](https://travis-ci.org/thisismydesign/batch_dependent_associations)   [![Coverage Status](https://coveralls.io/repos/github/thisismydesign/batch_dependent_associations/badge.svg?branch=release)](https://coveralls.io/github/thisismydesign/batch_dependent_associations?branch=release)   [![Gem Version](https://badge.fury.io/rb/batch_dependent_associations.svg)](https://badge.fury.io/rb/batch_dependent_associations)   [![Total Downloads](http://ruby-gem-downloads-badge.herokuapp.com/batch_dependent_associations?type=total)](https://rubygems.org/gems/batch_dependent_associations) |
| Development | [![Build Status](https://travis-ci.org/thisismydesign/batch_dependent_associations.svg?branch=master)](https://travis-ci.org/thisismydesign/batch_dependent_associations)   [![Coverage Status](https://coveralls.io/repos/github/thisismydesign/batch_dependent_associations/badge.svg?branch=master)](https://coveralls.io/github/thisismydesign/batch_dependent_associations?branch=master) |

As the [discussion]((https://github.com/rails/rails/issues/22510#issuecomment-162448557)) in [this](https://github.com/rails/rails/issues/22510) open Rails issue from 2015 points out `dependent: :(destroy|delete)` loads the entire relation and does not batch. This makes the usage of this otherwise great feature very dangerous and disencouraged at the very last because of possible OOM issues.

This gem is the sweet spot between the memory safety of custom batching and the convenience of letting Rails take care of dependencies. When included it [prepends](https://medium.com/appaloosa-store-engineering/caution-when-using-before-destroy-with-model-association-71600b8bfed2) a `before_destroy` hook that removes all `has_many` associations with `dependent` option. It will call `destroy` or `delete` based on how `dependent` is defined.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'batch_dependent_associations'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install batch_dependent_associations

## Usage

```ruby
require "batch_dependent_associations"

class SafePerson < ActiveRecord::Base
  include BatchDependentAssociations

  has_many :bank_accounts, dependent: :destroy
end
```

Is equivalent to:

```ruby
class SafePerson < ActiveRecord::Base
  has_many :bank_accounts, dependent: :destroy
  before_destroy :batch_dependent_associations, prepend: true
  
  def batch_dependent_associations
    bank_accounts.find_each(batch_size: 5, &:destroy)
  end
end
```

## Development

```bash
git clone git@github.com:thisismydesign/batch_dependent_associations.git
bundle
RAILS_ENV=test bundle exec rake db:drop db:create db:migrate # Ignore schema.rb error: https://source.xing.com/growth/inquiry/pull/92
bundle exec rake
```

## Feedback

Any feedback is much appreciated.

I can only tailor this project to fit use-cases I know about - which are usually my own ones. If you find that this might be the right direction to solve your problem too but you find that it's suboptimal or lacks features don't hesitate to contact me.

Please let me know if you make use of this project so that I can prioritize further efforts.

## Conventions

This gem is developed using the following conventions:
- [Bundler's guide for developing a gem](http://bundler.io/v1.14/guides/creating_gem.html)
- [Better Specs](http://www.betterspecs.org/)
- [Semantic versioning](http://semver.org/)
- [RubyGems' guide on gem naming](http://guides.rubygems.org/name-your-gem/)
- [RFC memo about key words used to Indicate Requirement Levels](https://tools.ietf.org/html/rfc2119)
- [Bundler improvements](https://github.com/thisismydesign/bundler-improvements)
- [Minimal dependencies](http://www.mikeperham.com/2016/02/09/kill-your-dependencies/)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/thisismydesign/batch_dependent_associations.
