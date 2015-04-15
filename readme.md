"ask git"

## Installation

With Rubygems

```bash
$ gem install asgit
```

With Bundler

```ruby
gem 'asgit'
```

## Use

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
# => "https://github.com/stevenosloan/asgit/blob/commit_sha/lib/asgit.rb"

repo.urls.compare '0.1.0', 'master'
# => "https://github.com/stevenosloan/asgit/compare/0.1.0...master"
# github atleast is very flexible, this can take any two references,
# could be branch, tag, or commit
```


## Services

### Packaged Services

**[GitHub](https://github.com)**  
```ruby
repo = Asgit::Project.new(
  service: 'github',
  organization: 'stevenosloan',
  project: 'asgit',
  default_branch: 'master'
)
repo.urls.project
# => "https://github.com/stevenosloan/asgit"
```

**[GitHub Enterprise](https://enterprise.github.com/home)**  
To configure for GitHub Enterprise, define your project as you would for GitHub except define the `base_url` where your Enterpise app is located.

```ruby
repo = Asgit::Project.new(
  service: 'github',
  organization: 'stevenosloan',
  project: 'asgit',
  default_branch: 'master',
  base_url: 'https://git.myserver.com'
)
repo.urls.project
# => "https://git.myserver.com/stevenosloan/asgit"
```

**[BitBucket](https://bitbucket.org)**  
```ruby
repo = Asgit::Project.new(
  service: 'bitbucket',
  organization: 'stevenosloan',
  project: 'asgit',
  default_branch: 'master'
)
repo.urls.project
# => "https://bitbucket.org/stevenosloan/asgit"
```

### Creating a custom service

Lets imagine we're hosting our own [GitLab](http://gitlab.org/) application at 'example.com'. First we'll open up a new class and extend from the Asgit::Services::Service class and register it under the name of `:gitlab`.

```ruby
class GitLab < Asgit::Services::Service
  register_as :gitlab

  def base_url
    "https://example.com"
  end
  # define a base_url method to act as the
  # root for our url structures

end
```

With our base class defined, we can create a new project using that class.

```ruby
repo = Asgit::Project.new(
  service: :gitlab,
  organization: 'stevenosloan',
  project: 'asgit',
  default_branch: 'master'
)
```

This isn't very useful though, because it doesn't know the url structure for anything. So lets add those:

```ruby
class GitLab < Asgit::Services::Service
  # ... previous code

  def base_structure
    "%{base_url}/%{organization}/%{project}"
  end
  # the start of every URI

  def commit_uri
    "commit/%{commit}"
  end
  # URI for individual commits

  def branch_uri
    "commits/%{branch}"
  end
  # URI for branches

  def file_uri
    "blob/%{branch}/%{file_path}"
  end
  # URI for an individual file

end
```

You may note that we're missing a `file_at_commit_uri` structure, if we try and access a url structure that isn't defined in our custom service, a `Asgit::Services::Service::MissingUrlStructure` error will be raised.


## Testing

```bash
$ rspec
```


## Contributing

If there is any thing you'd like to contribute or fix, please:

- Fork the repo
- Add tests for any new functionality
- Make your changes
- Verify all new &existing tests pass
- Make a pull request


## License

The Asgit gem is distributed under the MIT License.