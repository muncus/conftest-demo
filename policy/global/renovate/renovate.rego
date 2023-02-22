# Rego policy checks for renovate.json files
# see https://docs.renovatebot.com/configuration-options/ for details.
# These rules are currently only checking for the use of presets. More complex
# rules can be added to also catch manual configuration.
package renovate

import future.keywords
import input

# Renovate configs should use a weekly schedule.
warn_weekly_schedule contains msg if {
  not extends_weekly
  msg := "Does not extend 'schedule:weekly'"
}
extends_weekly {
  input.extends[_] == "schedule:weekly"
}

# Renovate configs should group non-major updates
warn_group_nonmajor contains msg if {
  not extends_group_nonmajor
  not major_disabled_all_grouped
  msg := "Does not group minor/patch updates. Consider extending 'group:AllNonMajor'."
}
extends_group_nonmajor {
  input.extends[_] == "group:AllNonMajor"
}
major_disabled_all_grouped {
  some i
  input.packageRules[i].enabled == false
  input.packageRules[i].updateTypes[_] == "major"
  # non-zero length string
  count(input.groupName) > 0
}
