# Demo: Using Conftest to create consistency across a large organization

Conftest (http://conftest.dev) can be used to add lightweight validation on
many kinds of structured data. These types of validations are critical for large
organizations, where managing Best Practices(tm) across multiple repositories
can prove challenging.

This repo shows how an organization might use conftest to validate a variety of
checks across different repositories using github actions. To do this, we need a
few different pieces:

* **Policy Repo** - This repository holds all the Rego rules to do the policy
  checking, as well as any [exceptions](https://www.conftest.dev/exceptions/).
  Policies are discussed in greater detail below.

* [**Conftest Action**](http://github.com/muncus/conftest-action) - Optional,
  but I find this an easier way to run conftest. It is possible to [run conftest
  directly](https://www.conftest.dev/options/#github) in GHA if you prefer.

* [**Github
  Workflow**](https://github.com/muncus/conftest-demo/blob/main/.github/workflows/conftest.yaml) - This workflow demonstrates how to check out the policy repo as well as a repo under test, and perform some policy checks.

## Policies

The policies provided here are some examples of using conftest. Before trying
them out with Github Actions, you can test them out from the commandline. Each
namespace expects a different input, and is described below.

The main policies are located in the `policy/global` directory, organized by
namespace. To illustrate per-team namespaces, a `policy/teams` directory exists,
where teams may place additional rules, either in the same namespace, or create
namespaces of their own. To use these additional policies, the team directory
must be passed to conftest with the `--policy` flag. When using the Github
action (as illustrated in the workflow above), this is done through the
`extra_args` input.

#### Namespace: `github.repo`

**Input**: The json representation of a github Repository, as described in the
[github api docs for
Repositories](https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#get-a-repository)

Try out these policies with the following command:

```
gh api /repos/${OWNER}/${REPO} | conftest test -n github.repo -
```

Note the trailing `-`, which tells conftest to read from stdin.

If you do not have the github CLI (`gh`) installed, you can get similar results
with `curl`. See the Github API docs for more information.

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
