# Policy checks for Github Repository Branch Protection Rules
# Input is expected to be the json representation of github branch protections,
# as described at
# https://docs.github.com/en/rest/branches/branch-protection?apiVersion=2022-11-28#get-branch-protection

package github.branch_protection

import future.keywords
import input

# Disable Force Pushes
fail_allow_force_pushes contains msg if {
  msg := "Force pushes should be disabled on protected branches."
  input.allow_force_pushes.enabled != false
}
# Disable branch deletion
fail_allows_deletion contains msg if {
  msg := "Deletion should be disabled on protected branches."
  input.allow_deletions.enabled != false
}

# Required Review counts
deny_review_count contains msg if {
  msg := "Review count should be at least 1."
  input.required_pull_request_reviews.required_approving_review_count < 1
}
warn_review_count contains msg if {
  msg := "Review count over 2 is unusual, and may create additional review latency"
  input.required_pull_request_reviews.required_approving_review_count > 2
}

# Ensure CODEOWNERS approve PRs on protected branches
deny_owner_review contains msg if {
  msg := "CODEOWNER approval should be required."
  input.required_pull_request_reviews.require_code_owner_reviews != true
}

