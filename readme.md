"ask git"

## Usage

### Get current status

```ruby
Asgit.working_tree_clean?
# => true if you're working tree is clean

Asgit.current_branch
# => the branch you're on

Asgit.current_commit
# => sha of the current_commit

Asgit.remote_up_to_date?
# => true if you and remote are synced
```

### Get repo links

```ruby
# First setup the project info
Asgit.configure do |c|
  c.organization = "stevenosloan"
  c.project      = "asgit"
  c.service      = :github
end

Asgit::Url.project
# => "https://github.com/stevenosloan/asgit"

Asgit::Url.branch
# => "https://github.com/stevenosloan/asgit/tree/master"

Asgit::Url.commit
# => "https://github.com/stevenosloan/asgit/commit/1ea541b0d3ec4e89aea5c015184d36f95b73e17a"
```