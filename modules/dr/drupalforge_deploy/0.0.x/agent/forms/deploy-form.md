<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The deploy form, wizard & readiness evaluation

`DrupalForgeDeployForm` (`src/Form/DrupalForgeDeployForm.php`, extends `FormBase`, form id
`drupalforge_deploy_form`) is the module's whole UI, at route `drupalforge_deploy.deploy`
(`/admin/config/development/drupalforge-deploy`, permission `administer drupalforge deploy`). It uses
`ReadinessMessagesTrait` for the Git/backup status markup. Static `pageTitle()` supplies the title.

Injected services (`create()`): `git_repository_inspector`, `php_image_resolver`,
`backup_catalog_service`, `backup_option_formatter`, `deploy_readiness_evaluator`,
`deployment_url_builder`, and the module logger.

## Four-step wizard (`buildForm`)

Each step is a `#type => details` panel with `status_messages`. Gates:

1. **Configure backup destination** — pass = `backupReadiness['has_compatible_destination_provider']`.
2. **Create a deployment backup** — pass = `has_available_backup` (non-expired backup exists).
3. **Configure Git repository** — pass = repo present, not detached HEAD, supported remote.
4. **Generate deployment URL** — the actual selection + Deploy link.

The form opens on the first failing step (`$defaultStep`); a `?step=<destination|backup|git|generate>`
query can jump forward only up to the highest reachable step. Readiness comes from
`DeployReadinessEvaluator::isReady($inspection, $backupReadiness)`. The Git root passed to the
inspector is `DRUPAL_ROOT` (or `getcwd()`), **not** user input.

## Step 4 fields

- `resolved_image` — disabled textfield from `PhpImageResolver::resolveImage()`.
- `selected_backup` — select of `BackupOptionFormatter::buildSelectableOptions()`, default =
  `buildDefaultBackupId()`; or a "No backups discovered" notice.
- `selected_branch` — required textfield with `#autocomplete_route_name =
  drupalforge_deploy.git_reference_autocomplete`.
- `deploy` — an `<a>` (html_tag) whose `href` is the generated launch URL when ready, else `#`.
- `submit` ("Save selection") — disabled until ready.
- `raw_url_preview` — the launch URL inside `<code>` (escaped with `Html::escape`).
- `payload_preview` — editable `KEY=VALUE` textarea of the launch parameters.
- `data-drupalforge-*` attributes carry JSON maps (env vars, backup paths, branches, reference URLs)
  consumed by `js/drupalforge-deploy.js` to keep the preview/href in sync client-side.

## Launch URL assembly (`buildLaunchContext`)

Merges, in order: configured env vars (`deployment_env_vars` config) → destination env vars
(`S3_BUCKET`, `AWS_REGION`, `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` from the S3 destination) →
`S3_DATABASE_PATH` (destination prefix + selected backup id) → `ORIGIN_URL`
(`$request->getSchemeAndHttpHost()`). Ordered keys are placed first, then the rest, and passed to
`DeploymentUrlBuilder::buildLaunchUrl($repoUrl, $branch, $image, $envVars)`. The repo URL/branch come
from `resolveSelectedReferenceContext()` (splits `remote/branch`, looks up the remote's
`normalized_url`). An `InvalidArgumentException` (missing repo/branch/image) is caught → empty URL +
logged warning.

## Validation & submit

- `validateForm()` — a non-empty `selected_branch` must be one of `inspection['remote_branches']`
  (re-inspected server-side); else error "must match a GitHub or GitLab remote branch."
- `submitForm()` — parses `payload_preview`, removes derived `DP_REPO_BRANCH`/`DP_IMAGE`, and saves
  the remaining `KEY=VALUE` lines to `drupalforge_deploy.settings:deployment_env_vars`.

## ReadinessMessagesTrait (`src/Form/ReadinessMessagesTrait.php`)

Builds the Git step's error/warning/status items: repo-missing and unsupported-remote errors carry
copy-paste `git remote add` guidance; a private-repo-not-supported warning; a "Default Git reference"
link and a "Compatible remotes" list with inline GitHub/GitLab SVG badges. All interpolated values
(repo URLs, branch labels, remote names) are escaped with `htmlspecialchars(...ENT_QUOTES...)` before
being wrapped in `Markup::create()`, and branch names are `rawurlencode`d per segment for `/tree/` and
`/-/tree/` links. Also supplies the Step 1/Step 2 "configured"/"available" status messages.
