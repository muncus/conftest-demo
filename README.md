# Demo: Using Conftest to create consistency across a large organization

Conftest (http://conftest.dev) can be used to add lightweight "validation" on
many kinds of structured data. These types of validations are critical for large
organizations, where Best Practices(tm) often change over time - making
consistent enforcement difficult.

This repo shows how an organization might use conftest to validate a variety of
checks across different repositories using github actions.

The Workflows and Actions provided here are provided as a demonstration. The
Action will need to be hosted in its own repository in order to be reusable by
other repositories, as described in [About Custom
Actions](https://docs.github.com/en/actions/creating-actions/about-custom-actions#choosing-a-location-for-your-action) in the GHA docs.

## Policies

The policies provided here are some examples of using conftest. Before trying
them out with Github Actions, you can test them out from the commandline. Each
namespace expects a different input, and is described below.

#### Namespace: `github.repo`

**Input**: The json representation of a github Repository, as described in the
[github api docs for
Repositories](https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#get-a-repository)

Try out these policies with the following command:

```
gh api /repos/${OWNER}/${REPO} | conftest test -n github.repo -
```

Note the trailing `-`, which tells conftest to read from stdin.

#### Namespace: `github.branch_protection`

**Input**: The json representation of github branch protection rules, as
described by [github api docs for
branch protection](https://docs.github.com/en/rest/branches/branch-protection?apiVersion=2022-11-28#get-branch-protection)

Try out these policies with the following command:

```
gh api /repos/${OWNER}/${REPO}/branches/${BRANCH}/protection | conftest test -n github.branch_protection -
```

NOTE: branch protection requires admin permissions on the repo in question.

#### Namespace: `renovate`

**Input**: The contents of a [renovatebot config
file](https://docs.renovatebot.com/configuration-options/). It has not been
tested with a `.json5` file.

Local testing can be done with `conftest test -n renovate
./path/to/renovate.json`
