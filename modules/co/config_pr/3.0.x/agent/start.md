<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Pull Request (config_pr) — agent index

info.yml name **"Config Pull Request"**, version **3.0.0** (version-dir 3.0.x), package Administration,
core `^10 || ^11 || ^12`. Depends on core `config` and `field`. License GPL-2.0-or-later.

Lets an administrator turn **configuration changes made in the Drupal UI into a pull/merge request on a Git
host**, pushed **directly through the host's REST API** (no local Git clone on the server needed). The operator
opens a **Pull Request** tab on the Configuration Management page, ticks which changed config objects to
include, gives the PR a title/branch/description, and submits; the module creates a branch, commits the
selected `*.yml` files into the site's `config_sync_directory`, and opens the PR.

## Providers are submodules (enable exactly one for your host)

Base `config_pr` ships only a `DummyController`; real hosts live in submodules, each registering controller
services tagged `config_pr.repo_controller`:

| Submodule | Controllers (settings "Repo provider" options) | Library (composer) |
|---|---|---|
| `config_pr_github` | `Github`, `Github Enterprise` (self-hosted via `repo_url`) | `knplabs/github-api` (base require) |
| `config_pr_gitlab` | `GitLab`, `Gitlab Self Managed` (self-hosted via `repo_url`) | `m4tthumphrey/php-gitlab-api` (require-dev) |
| `config_pr_bitbucket` | `BitBucket` | **inert stub** — every method returns FALSE; "not ready yet" |

## How it works (from source)

- **Settings** `config_pr.settings` form (route `config_pr.settings`, path
  `/admin/config/development/configuration/pull_request/settings`, permission
  `administer configuration pull request`): pick the repo provider controller, optional `repo_url` (required
  for self-hosted GitHub Enterprise / GitLab self-managed), `repo_owner`, `repo_name`, and four editable
  commit-message templates (create/update/delete/rename; token `@config_name`, also `@action`). Owner/name are
  prefilled from `<project>/.git/config` when present (`RepoControllerManager::getLocalRepoInfo()`).
- **Per-user token**: each operator stores their Git access token in the user-profile string field
  **`field_config_pr_auth_token`** ("Repository Access Token") at `/user/{uid}/edit`. `config_pr_install()`
  places the field on the user form; `config_pr_form_user_form_alter()` hides it unless the viewer holds
  `issue configuration pull requests`.
- **PR form** `config_pr.pull_request` (`ConfigPrForm`, path
  `/admin/config/development/configuration/pull_request`, permission `issue configuration pull requests`,
  registered as a **Pull Request** local task under `config.sync`): diffs `config.storage.sync` vs
  `config.storage` with a `StorageComparer`, lists create/update/delete/rename changes (create/delete are
  inverted because committing to the repo is the opposite action of importing), lets the user tick items,
  choose a source branch + new branch name (default `Ymd-config`), title and description. On submit it
  authenticates, creates the branch, commits each selected object's `active` YAML as `{config_sync_dir}/{name}.yml`
  (prepending `web/` when the sync dir is under `sites/default`), then opens the PR. Also renders a table of
  currently open PRs/MRs for the repo.
- **Controller interface** (`RepoControllerInterface` + `RepoControllerTrait`): `authenticate()`,
  `getProjectDetails()`, `getBranches()`, `createBranch()`, `getOpenPrs()`, `createPr()`, `getFileSha()`,
  `createFile()`/`updateFile()`/`deleteFile()`, `fileExists()`, plus owner/name/token/sha/committer setters.
  The GitHub controller uses the knplabs client (`repo`/`pull_request`/`contents`/`References` APIs); GitLab
  uses the php-gitlab-api client (`repositories`/`repositoryFiles`/`mergeRequests`, base64 file encoding).

## Install / enable

```bash
composer require drupal/config_pr        # base require pulls knplabs/github-api + php-http/discovery
drush en config_pr config_pr_github -y   # + require m4tthumphrey/php-gitlab-api for the GitLab submodule
```

Then set the provider + repo on the settings page, add each operator's token on their user profile, and use
the Pull Request tab. A PR can only be created after the repo already contains an initial config commit.

## Facts

- Two permissions, both `restrict access: true`: `issue configuration pull requests`,
  `administer configuration pull request`. No Drush commands. Provides config schema (`config_pr.settings`).
- No routes take request-supplied URLs; the self-hosted `repo_url` is admin config only.
- Operator-supplied config pushed to a repo can contain sensitive values depending on the site — review the
  selected config and prefer a private repository; grant the permissions only to trusted operators.
