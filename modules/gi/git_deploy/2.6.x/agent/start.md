<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Git Deploy (git_deploy) — agent index

Zero-config utility for sites run from **Git checkouts** of core/contrib. When Drupal.org packages a
release it stamps `version`, `project`, and `datestamp` into each `.info.yml`; a raw `git clone` has
none of that, so the Update Status system flags the project as an unsupported/unknown version. Git
Deploy reconstructs those fields at runtime by shelling out to the `git` binary in each extension's
repository — deriving the best-matching upstream branch/tag and the last common commit — so update
reports show real versions and stop warning. Its entire surface is three implemented core hooks; it
has **no UI, no settings page, no routes, no services, no permissions, no plugins, no config, and no
Drush commands**, and it invites no hooks/API of its own. Enabling the module is the whole setup.

Mechanism (`git_deploy.module`): `hook_system_info_alter()` (line 20) runs for each non-hidden
extension whose `version` is missing, `-dev`, equal to core's `\Drupal::VERSION`, or not a
`\d+.\d+.\d+` string. It verifies a repo with `git rev-parse --show-toplevel`, confirms core
checkouts are really Drupal (path is `DRUPAL_ROOT` or `DRUPAL_ROOT/core`), then calls the internal
helper `_git_deploy_get_upstream()` (line 141) which uses `git describe --tags`, `rev-parse
@{upstream}`, `merge-base`, `branch -r`, and `log` to pick the branch/tag and commit timestamp. It
injects `version` (a release tag, or `<branch>-dev`), `project` (the `basename` of the remote fetch
URL), and `datestamp`/`_info_file_ctime` (the commit's `%at`). `hook_update_projects_alter()` (line
263) refetches via the `update.processor` service and syncs dev-release datestamps against the
`update_available_releases` key/value store so "update available" comparisons are correct.

- **Depends on:** nothing (no `dependencies:` in info.yml). Interoperates with core `update` module when present (guarded by `moduleExists('update')`).
- **Core:** `^8 || ^9 || ^10 || ^11`.
- **Package:** none (no `package:` key in info.yml).
- **Settings page / configure route:** none (`configure` = null). No config, no schema, no config/install.
- **Permissions:** none. **Drush:** none. **Plugin types:** none. **Services:** none provided.
- **Runtime requirements** (`hook_requirements()`, `git_deploy.install`): PHP `exec()` must be
  enabled and the `git` binary must be executable from PHP — either missing is a `REQUIREMENT_ERROR`
  at install and at `/admin/reports/status`.

## What you'd do → where
Nothing to configure — there is no settings page, route, or plugin. The only substance is the
version-detection algorithm and how to make it fire, documented in
[api/version-detection.md](api/version-detection.md). To use it: `drush en git_deploy -y`, then
confirm Git-checked-out projects report real versions at `/admin/reports/updates`. To debug: check
`/admin/reports/status` for the `git`/`exec()` requirement.

## Key facts (real machine names)
- Hooks implemented: `hook_system_info_alter()`, `hook_update_projects_alter()` (`git_deploy.module`);
  `hook_requirements()` (`git_deploy.install`).
- Internal helpers (not a public API): `_git_deploy_get_upstream($git, $patterns)`,
  `_git_deploy_datestamp_sync(&$project, $release)`.
- Constant: `GIT_DEPLOY_ERROR_DUMP` (`/dev/null`, or `nul` on Windows) — stderr sink for git calls.
- Info-array fields written: `version`, `project`, `datestamp`, `_info_file_ctime`.
- External touchpoints: `update.processor` service (`processFetchTask`); `update_available_releases`
  expirable key/value collection. Sets `HOME=DRUPAL_ROOT` for git when the env `HOME` is unset.
- Routes: none. Config keys: none. Widgets/formatters: none. Libraries: none.
- No web-facing surface: no routes, controllers, forms, or rendered output — it only reads local
  Git state during the module/theme info scan and the update-status build.
