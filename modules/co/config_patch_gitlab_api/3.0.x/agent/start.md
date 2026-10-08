<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Patch GitLab API (config_patch_gitlab_api) — agent index

`config_patch` **output plugin**: on config-patch export it commits the changed config `.yml`
files to a new GitLab branch via the GitLab REST API and opens/updates a merge request.
Version **3.0.0-alpha3** (**alpha** — it writes to your repository). Core `^10 || ^11`.
Depends on `config_patch:config_patch` and the `m4tthumphrey/php-gitlab-api` library.

- **Setup / config UI / credentials / project & branch** → [configure/config_patch_gitlab_api.md](configure/config_patch_gitlab_api.md)
- **The output plugin — export flow, GitLab actions, commit/MR logic** → [plugins/config_patch_gitlab_api.md](plugins/config_patch_gitlab_api.md)
- **`ConfigPatchGitlabClient` service + factory (call GitLab programmatically)** → [api/config_patch_gitlab_api.md](api/config_patch_gitlab_api.md)
- **Drush export (`config:patch config_patch_gitlab_api`) and its added options** → [drush/config_patch_gitlab_api.md](drush/config_patch_gitlab_api.md)

Quick facts:
- Config plugin id: `config_patch_gitlab_api`, label "Merge requestion in Gitlab with API".
- Credentials (`url`, `token`) and project settings (`project_id`, `branch_name`) are stored in
  Drupal **State** (not config; not exported), under keys `config_patch_gitlab_api.credentials`
  and `config_patch_gitlab_api.project_branch`.
- Token = a GitLab **project access token** with `api` + `write_repository` scopes.
- Permissions: `administer config_patch_gitlab_api` (`restrict access: true`) gates the
  project/branch form + project autocomplete; the credentials form is gated by core
  `administer site configuration`.
- No `config/` directory: no shipped config schema, no default config.
