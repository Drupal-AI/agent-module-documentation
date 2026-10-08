<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Config Patch GitLab API

Two admin screens, both under `/admin/config/config_patch_gitlab_api` (menu parent:
`system.admin_config_development`, "Development"). Settings are persisted in **Drupal State**,
not configuration — so they are NOT written to config exports and do NOT ship a config schema.

## Prerequisite: Config Patch itself
At `/admin/config/development/config_patch` (provided by `config_patch`):
- Set **Config base path** (e.g. `config/default`) — the repo-relative directory the plugin
  writes `.yml` files into (read here as `config_patch.settings:config_base_path`).
- Set the default output plugin to **"Merge requestion in Gitlab with API"** to make this the
  target of UI/CLI exports.

## 1. Credentials — route `config_patch_gitlab_api.credentials`
Path `/admin/config/config_patch_gitlab_api/credentials`. Permission: **`administer site
configuration`** (core). Form `ConfigPatchGitlabApiCredentialsForm` (extends `ConfigFormBase`
but `getEditableConfigNames()` returns `[]` — it reads/writes **State**, not config).

Fields, saved to State key `config_patch_gitlab_api.credentials`:
- `url` (`#type => url`, required) — the GitLab instance base URL, e.g. `https://gitlab.example.com`.
- `token` (required) — a GitLab **project access token** with `api` and `write_repository`
  scopes (create at `https://<instance>/<group>/<project>/-/settings/access_tokens`).

Validation: rejects a token shorter than 20 chars, then instantiates the client and calls the
GitLab **version** endpoint to verify the URL+token before saving.

## 2. Project & branch — route `config_patch_gitlab_api.project_branch`
Path `/admin/config/config_patch_gitlab_api/project_branch`. Permission: **`administer
config_patch_gitlab_api`**. Form `ConfigPatchGitlabApiProjectBranchForm`.
- **Project** — a textfield autocompleting against
  `config_patch_gitlab_api.autocomplete.projects`
  (`ProjectsAutoCompleteController::handleAutocomplete`), which calls the GitLab projects
  search API and returns `name_with_namespace (id)`; the numeric id is extracted on submit.
- **Target branch name** — a select populated (AJAX) from the chosen project's branches; this
  is the default MR target / start branch.

Saved to State key `config_patch_gitlab_api.project_branch` as `{project_id, branch_name}`.

## Permission
`administer config_patch_gitlab_api` — title "Administer config patch GitLab API settings",
`restrict access: true`. Gates the project/branch form, the `system.admin_config_patch_gitlab_api`
menu page, and the projects autocomplete route. (The credentials form is separately gated by
`administer site configuration`.)

## Routes
| Route | Path | Permission |
|---|---|---|
| `config_patch_gitlab_api.credentials` | `/admin/config/config_patch_gitlab_api/credentials` | `administer site configuration` |
| `config_patch_gitlab_api.project_branch` | `/admin/config/config_patch_gitlab_api/project_branch` | `administer config_patch_gitlab_api` |
| `system.admin_config_patch_gitlab_api` | `/admin/config/config_patch_gitlab_api` | `administer config_patch_gitlab_api` |
| `config_patch_gitlab_api.autocomplete.projects` | `/admin/config/config_patch_gitlab_api/autocomplete/projects` | `administer config_patch_gitlab_api` |
