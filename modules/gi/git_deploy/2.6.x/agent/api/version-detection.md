<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Version detection mechanism (git_deploy)

Everything the module does lives in three core hooks in `git_deploy.module` (317 lines) plus a
`hook_requirements()` in `git_deploy.install`. There is no UI, config, route, service, or plugin —
so this is the only "operable" surface: understanding the algorithm and how to make it fire.

## When it runs — `git_deploy_system_info_alter(&$info, Extension $file, $type)`

Implements `hook_system_info_alter()` (line 20). Core calls this for every extension while building
the extension info list (Extend page, update status). Static caches are kept in `drupal_static()`
keyed on the function name (`:projects`, `:available`, `:update`) so a repo is inspected only once
per request and memory can be freed later.

The body only acts when the extension has **no usable version** (line 28), i.e. `hidden` is empty
AND one of:
- `$info['version']` is empty; or
- origin is `core` and the version contains `-dev`; or
- for non-core: the version equals `\Drupal::VERSION`, or does not match `/^\d\..+\..+/`
  (i.e. it is not a real packaged `x.y.z`-style string).

A packaged release already has a valid version, so the module skips it. Only Git checkouts (whose
`.info.yml` never got a packaging stamp) fall through.

Then:
1. `HOME` workaround (line 30): if `getenv('HOME')` is FALSE it prefixes every git call with
   `HOME=<DRUPAL_ROOT> ` so git does not fail for a PHP user without a home directory.
2. `git -C <path> rev-parse --show-toplevel` (line 33) confirms the extension dir is inside a repo
   and returns the repo root. For `core` origin it additionally requires the root to be
   `DRUPAL_ROOT` or `DRUPAL_ROOT/core` — i.e. it will not stamp core versions from an unrelated repo.
3. `git ls-files <relpath>` (line 41) confirms the info file is actually tracked.
4. Calls `_git_deploy_get_upstream($git, $patterns)` with patterns `['8.*','9.*','10.*','11.*']`
   for core, else `['*.*']` (line 43).
5. Derives and merges (line 118, `$info = $projects[$directory] + $info;` — computed values win):
   - `project` — for core it is the literal `drupal`; otherwise `basename(<remote fetch URL>, '.git')`
     read from `git config --get remote.<remote>.url` (lines 44–53).
   - `version` — the release `tag` if the checkout is on/contains a tag, else `"<branch>-dev"`
     (a non-`master` branch), else refined from update-status release data (lines 66–115).
   - `datestamp` and `_info_file_ctime` — the `%at` (author Unix timestamp) of the last common
     commit (lines 56–65).

## The upstream picker — `_git_deploy_get_upstream($git, array $patterns)`

Returns an array with any of: `branch`, `remote`, `synced` (bool), `tag`, `last_tag`, `datestamp`.
Steps (lines 141–258):
- Bails unless `git remote` lists at least one remote.
- `git describe --tags --abbrev=0 --match <pattern.*>` → most recent matching tag.
- `git log -1 --pretty=format:%H` → current HEAD.
- `git rev-parse --abbrev-ref @{upstream}` → tracked upstream branch. If it matches a
  `<remote>/<major>.x`-style pattern, that branch/remote is used and the last common commit is
  `git merge-base HEAD <remote>` (lines 155–171); `tag` is set only if
  `git describe --tags --contains` proves the tag is an ancestor.
- Otherwise (no tracked branch) it picks a remote (`origin` preferred, else the tracked or first
  remote), lists `git branch -r --list <patterns> master`, sorts them with `version_compare`, and
  walks newest→oldest comparing branch tips against local history via `merge-base` /
  `merge-base --is-ancestor` to choose the best-matching remote branch and whether local is
  `synced` (lines 173–253).
- `datestamp` is `git log -1 --pretty=format:%at <last_base>`.

All git stderr is redirected to `GIT_DEPLOY_ERROR_DUMP` (`/dev/null`, or `nul` on Windows;
line 15), so git noise never reaches the page.

## Update-status sync — `git_deploy_update_projects_alter(&$projects)`

Implements `hook_update_projects_alter()` (line 263). Reads the `:update` static (project → last
tag) collected during the info scan, resets the three statics to free memory, and for each queued
project calls `\Drupal::service('update.processor')->processFetchTask(...)` to refetch release data,
then reconciles the chosen version against the `update_available_releases` expirable key/value
store. `_git_deploy_datestamp_sync(&$project, $release)` (line 301) nudges the checkout's datestamp
up to the release date when the commit is within the packaging delay window (43200s for a matching
dev release, else 300s, plus a 100s buffer) so "update available" comparisons are accurate. No
outbound HTTP is made by this module itself — the fetch is core's own update processor.

## How to operate / verify

- Enable: `drush en git_deploy -y`. No config follows.
- Requirement (`git_deploy.install`, `hook_requirements()`): PHP `exec()` must be enabled and the
  `git` binary reachable from PHP, else a `REQUIREMENT_ERROR` at install and at
  `/admin/reports/status`.
- Verify: on a Git checkout of a contrib module, `/admin/reports/updates` should show a real
  `x.y-dev` or tag version instead of an unsupported/unknown-version warning.
- The module only fires for extensions Drupal.org packaging did not stamp; a Composer-installed
  release keeps its own version and is left untouched.
