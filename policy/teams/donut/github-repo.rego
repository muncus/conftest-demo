package github.repo

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
