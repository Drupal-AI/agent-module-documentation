<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The output plugin — Config Patch GitLab API

Class `Drupal\config_patch_gitlab_api\Plugin\config_patch\output\GitlabApi`
(`src/Plugin/config_patch/output/GitlabApi.php`). It is a **`config_patch` output plugin**, not
a new plugin type — the type (`@ConfigPatchOutput`, manager + base classes) is defined by the
`config_patch` module. This module supplies one instance of it.

```
@ConfigPatchOutput(
  id = "config_patch_gitlab_api",
  label = "Merge requestion in Gitlab with API",
  action = "Create GitLab merge request"
)
```
Extends `OutputPluginBase`, implements `ContainerFactoryPluginInterface` and
`CliOutputPluginInterface` (so it works from both the UI and Drush). Injects
`config.storage.export`, `state`, `config.factory` (reads `config_patch.settings`) and
`config_patch_gitlab_api.client_factory`.

## Export entry points
- `output(array $patches, FormStateInterface $form_state)` — UI export. Reads collections from
  `$form_state->get('collections')`, the per-collection export list, `source_branch`,
  `commit_message`, `target_branch`, `start_branch`.
- `outputCli(array $patches, array $config_changes, array $params)` — Drush export. Same logic,
  values from `$params` (`source-branch`, `message`, `target-branch`, `start-branch`).

Both call `collectGitlabActions()` then, if any actions, `performGitlabActions()`; otherwise a
"There was no action to perform" warning.

## Building the commit actions — `collectGitlabActions()`
Reads project settings from State (`config_patch_gitlab_api.project_branch`) and creates a
client. Determines an existing branch to read the current tree from: the `source_branch` if it
already exists on GitLab, else the configured `branch_name`. Fetches the repo **tree** under
`config_patch.settings:config_base_path` to know which files already exist.

For each changed config object it emits one GitLab commit **action**:
- `type` maps to the action: `create` / `update` / `delete`; a Config Patch `rename` becomes
  `move`; a `create` whose target file already exists in the tree is downgraded to `update`.
- `file_path` = `<config_base_path>/<config_name>.yml`; for non-default collections the
  collection name is appended as a sub-path (dots → slashes).
- `content` = the exported YAML of the object (`Yaml::encode(...)`), read from
  `config.storage.export` (collection-aware), or `NULL` for deletes.

This is the payload shape for GitLab's
["create a commit with multiple files and actions"](https://docs.gitlab.com/ee/api/commits.html) API.

## Committing + the merge request — `performGitlabActions()`
1. Reads `{project_id, branch_name}` from State; requires a numeric `project_id` and a
   `branch_name` (else throws `MissingMandatoryParametersException` → warning linking to the
   project/branch form). Defaults: `target_branch` ← `branch_name`; `start_branch` ← `target_branch`.
2. `client->createCommit(project_id, start_branch, source_branch, actions, commit_message)` —
   commits the actions onto `source_branch`, creating it from `start_branch` if it doesn't exist
   (commit author name is hardcoded "Drupal Config Patch module,").
3. If an **open** MR already exists (`source_branch` → `target_branch`), it reports/updates it;
   otherwise `client->createMergeRequest(project_id, source_branch, target_branch, commit_message)`
   opens a new one. Either way a status message links to the MR `web_url`.

`MissingCredentialsException` → warning linking to the credentials form; other throwables →
error linking to the credentials form.

## The export form additions — `alterForm()`
Before showing the export form the plugin does a "dummy" `client->version()` call to verify
credentials, and requires project settings; on failure it returns `[]` with a warning. It adds
required fields: `commit_message` (textarea), `start_branch` (default = configured branch),
`source_branch` (default `config-patch-<timestamp>`), `target_branch` (default = configured
branch). `getDefaultSourceBranchName()` returns `config-patch-<time()>`.

## Notes
- Source-branch default is time-based, so repeated exports create distinct branches/MRs unless
  you reuse a branch name.
- `getListKey()` is copied from `config_patch`'s config_compare service (comment notes a
  circular-reference reason it can't be injected).
