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
