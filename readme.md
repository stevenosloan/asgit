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
# First initialize the project with info
repo = Asgit::Project.new(
  service: 'github',
  organization: 'stevenosloan',
  project: 'asgit',
  default_branch: 'master'
)


repo.urls.project
# => "https://github.com/stevenosloan/asgit"

repo.urls.branch 'branch_name'
# => "https://github.com/stevenosloan/asgit/tree/branch_name"

repo.urls.commit 'commit_sha'
# => "https://github.com/stevenosloan/asgit/commit/commit_sha"

repo.urls.file "lib/asgit.rb"
# => "https://github.com/stevenosloan/asgit/blob/master/lib/asgit.rb"

repo.urls.file "lib/asgit.rb", branch: 'dev'
# => "https://github.com/stevenosloan/asgit/blob/dev/lib/asgit.rb"

repo.urls.file "lib/asgit.rb", line: '11'
# => "https://github.com/stevenosloan/asgit/blob/master/lib/asgit.rb#L11"

repo.urls.file "lib/asgit.rb", line: (11..15)
# => "https://github.com/stevenosloan/asgit/blob/master/lib/asgit.rb#L11-L15"

repo.urls.file_at_commit 'lib/asgit.rb', 'commit_sha'
# -> "https://github.com/stevenosloan/asgit/blob/commit_sha/lib/asgit.rb"
```
