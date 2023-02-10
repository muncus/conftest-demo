# Sample policies for Github Repositories.
# Input document is expected to be the json representation of a github repo object from the github api.
# see https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#get-a-repository

package github.repo

import future.keywords
import input

deny_merge_commits contains msg if {
  input.allow_merge_commit == true
  msg := "Merge commits should be disabled."
}

deny_rebase_merge contains msg if {
  input.allow_rebase_merge == true
  msg := "Rebase merges should be disabled."
}

# The default branch should be 'main'.
# Most recent repos will get this, but it may catch some stragglers.
warn_default_branch_name[msg] {
  input.default_branch != "main"
  msg := sprintf("Default branch '%s' found. Consider moving to 'main'", input.default_branch)
}

# License checks.
# TODO: round this out with other license keys.
valid_license_keys := ["apache-2.0"]
deny_supported_license[msg]{
  not has_valid_license
  msg := sprintf("Unsupported license found '%s', should be one of: %s", [ object.get(input, "license.key", "none"), valid_license_keys])
}
has_valid_license {
  input.license.key == valid_license_keys[_]
}

# delete PR branches once they are merged.
warn_delete_merged_branches[msg]{
  input.delete_branch_on_merge != true
  msg := "Consider enabling 'delete branch on merge' in your repo settings"
}

# Should suggest updating branches that require syncing.
warn_update_branch_button[msg]{
  input.allow_update_branch == false
  msg := "Consider enabling the 'suggest updating pull request branches' option in repo settings."
}

# For Squash merges, use PR title/body
warn_squash_merge_settings contains msg if {
  msg := "Consider using the PR title and body in squash commit. This can be set in repository General settings."
  input.squash_merge_commit_title != "PR_TITLE"
  input.squash_merge_commit_message != "PR_BODY"
}

