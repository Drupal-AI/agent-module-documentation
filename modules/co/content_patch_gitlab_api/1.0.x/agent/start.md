<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Patch GitLab API (content_patch_gitlab_api) — agent index

info.yml name **Content Patch GitLab API**. Version **1.0.0-alpha4**. Core `^10.5 || ^11.2`.
Package `Content Patch GitLab API`. License GPL-2.0-or-later. Depends on core **`serialization`**.

**Purpose (from source):** exports a content entity — `node`, `media`, or `taxonomy_term` — plus its
referenced-entity dependency graph, to a GitLab project as a new branch commit **and** an opened
merge request, using the GitLab REST API v4. Content is serialised to YAML in Drupal **Recipe /
default-content** layout so the MR can be consumed by `drush recipe`. A Drush command exports the
same package to a local directory instead of GitLab.

## What it provides (from source)

- **Service `content_patch_gitlab_api.gitlab_api`** → `GitLabApiService` (`src/Service/GitLabApiService.php`).
  `createMergeRequest($branch, $commit_message, array $files, $mr_title)`: POSTs to
  `{gitlab_url}/api/v4/projects/{project_id}/repository/commits` with `start_branch = default_branch`
  (creates the branch + commit in one call), then POSTs `/merge_requests`
  (`source_branch → target_branch = default_branch`, `remove_source_branch: TRUE`). Returns the MR
  `web_url` or `FALSE`. Each file becomes a commit `action: create`; array-with-`base64` files are
  base64-encoded with `encoding: base64`, others `encoding: text`.
- **Service `content_patch_gitlab_api.export`** → `ContentExportService` (`src/Service/ContentExportService.php`).
  `exportEntity(EntityInterface)` returns an array keyed by repo-relative path. Recursively walks
  non-empty, non-computed fields (keeps `path`), follows `entity_reference` / `image` /
  `entity_reference_revisions` targets (dedup by `entity_type:uuid`), and for `file` entities reads
  the bytes off disk and emits them base64. Writes each entity to `content/{type}/{uuid}.yml`
  (`_meta` + `default`) and adds a `recipe.yml` under the `recipe_directory` (default `demo_content`).
  Config entities are skipped.
- **Form `SettingsForm`** at `/admin/config/services/content-patch-gitlab-api`
  (route `content_patch_gitlab_api.settings`, config object `content_patch_gitlab_api.settings`).
  Fields: `recipe_directory`, `gitlab_url` (default `https://gitlab.com`), `project_id`,
  `export_path` (default `recipes/exported-content`), `default_branch` (default `main`). The token is
  **not** a form field — see Credentials.
- **Form `ExportForm`** at `/admin/content/export-gitlab-api/{entity_type}/{entity_id}`
  (route `content_patch_gitlab_api.export`, `entity_type: node|media|taxonomy_term`). Collects branch
  name, commit message, MR title; on submit exports the entity and calls `createMergeRequest`,
  prefixing every path with the configured `export_path`.
- **`hook_entity_operation`** (`.module`) adds an "Export to GitLab" operation on node/media/term
  rows when the user has the export permission.
- **Drush `content-patch:export` (alias `cpe`)** (`src/Commands/ContentExportCommands.php`):
  `drush content-patch:export <entity_type> <entity_id> <destination>` writes the recipe package to a
  local directory (no GitLab call).
- **2 permissions** (`content_patch_gitlab_api.permissions.yml`): `administer site configuration`
  (core, gates settings) and `export content to gitlab api` (gates the export form + operation).
- **Kernel test** `tests/src/Kernel/ContentExportImportTest.php` — export → delete → `drush recipe`
  round-trip.

## Credentials (from source)

The GitLab access token is read **only** from `settings.php` via
`Settings::get('content_patch_gitlab_api.gitlab_token')`. Set it with:

```php
$settings['content_patch_gitlab_api.gitlab_token'] = 'your-private-token';
```

It is deliberately kept out of config/database — `SettingsForm` shows help text (and warns if the
setting is empty) but has no token input. The token is sent as the `PRIVATE-TOKEN` header to the
configured `gitlab_url`. A token needs GitLab scopes `api` + `write_repository` and (per README) the
**Maintainer** role to push to protected branches.

## Docs

- `usage.md` — task-oriented summary.
- `human-docs/` — manual UI walkthrough (installation, configuration).

No subdocs beyond these: two small services, two forms, one Drush command — the index covers the
surface without over-splitting.
