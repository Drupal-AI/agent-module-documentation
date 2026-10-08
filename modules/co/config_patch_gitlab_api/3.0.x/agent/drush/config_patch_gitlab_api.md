<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush — Config Patch GitLab API

This module does not define a standalone Drush command. It registers a Drush service
(`drush.services.yml` → `Drupal\config_patch_gitlab_api\Commands\GitlabApi`, args
`['@logger.factory']`) whose only job is an **`@hook option config:patch`** that adds four
options to Config Patch's existing `config:patch` command.

## Export to GitLab from the CLI
```
drush config:patch config_patch_gitlab_api --message="Exporting config from environment."
```
The first argument is the output plugin id (`config_patch_gitlab_api`). This drives
`GitlabApi::outputCli()` — same commit + merge-request flow as the UI export.

## Options added by this module
| Option | Meaning | Falls back to |
|---|---|---|
| `--message` | Commit message (also the MR title). | required |
| `--start-branch` | Branch the new source branch is created from. | target branch (State `branch_name`) |
| `--source-branch` | New branch the commit is pushed to. | `config-patch-<timestamp>` |
| `--target-branch` | Branch the merge request targets. | State `branch_name` |

Prerequisites: credentials saved (State `config_patch_gitlab_api.credentials`) and a project +
branch selected (State `config_patch_gitlab_api.project_branch`); otherwise the run errors and
points at the corresponding admin form. The token needs GitLab `api` + `write_repository` scopes.
