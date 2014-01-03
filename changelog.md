# 0.1.1
- delegate to HereOrThere::Local for shelling out

# 0.1.0
- projects/repos are now created as instances, instead of global config -- this allows multiple per app/runtime
- services impementation is now split to discrete classes

# 0.0.7
- strip newline from `#current_branch` to return to existing behavior

# 0.0.6
- fix botched release using `--porcelain` flag for working_tree_clean?

# 0.0.5 (yanked)
- use `--short` flag for current branch (no more parsing!)
- use `--porcelain` flag for remote_up_to_date?
- use `--porcelain` flag in working_tree_clean?

# 0.0.4
- add a default branch option for config

# 0.0.3
- add a `configured?` boolean method to check if completely configured

# 0.0.2
- add file link methods

# 0.0.1
- port status helpers from Statistrano
- add a config & url helpers