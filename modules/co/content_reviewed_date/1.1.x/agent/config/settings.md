<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, settings form & stale report

## Install / enable

`drush en content_reviewed_date` (core `node` + `datetime` are pulled in). Enabling adds the two
base fields to node storage (`hook_entity_base_field_info`). Nothing is tracked until you select
bundles on the settings form.

## Config object: `content_reviewed_date.settings`

Schema — `config/schema/content_reviewed_date.schema.yml` (`type: config_object`):

- `bundles` — sequence of strings; node bundle machine names that track review dates.
- `threshold_days` — integer; global staleness threshold in days.
- `threshold_days_per_bundle` — sequence of integers keyed by bundle; per-bundle overrides.

Install defaults — `config/install/content_reviewed_date.settings.yml`: `bundles: []`,
`threshold_days: 365`, `threshold_days_per_bundle: []`.

Update hook `content_reviewed_date_update_10001` backfills `threshold_days_per_bundle: []` on sites
installed before that key existed.

## Settings form — `ReviewedDateSettingsForm`

Route `content_reviewed_date.settings` → `/admin/config/content/reviewed-date`, perm **`administer
content reviewed date`**. Menu link under *Configuration → Content* (`system.admin_config_content`).
Extends `ConfigFormBase`, edits `content_reviewed_date.settings`.

Fields built from `node_type` storage:

- `bundles` — checkboxes of all content types.
- `threshold_days` — number, `#min 1`, required; resolved default via `resolveThresholdDays()`
  (falls back to **365**).
- `threshold_days_per_bundle` — a details group with one optional number (`#min 1`) per content
  type; blank inherits the global value (shown as the field's placeholder).

`validateForm()` rejects a global threshold < 1 and any non-blank per-bundle value that is not a
numeric integer ≥ 1. `submitForm()` filters empty bundle checkboxes, coerces the threshold (default
365 if non-numeric), and keeps only per-bundle overrides that are integers ≥ 1.

## Stale-content report — `StaleContentController::listStale()`

Route `content_reviewed_date.stale_report` → `/admin/content/stale-review`, perm **`administer
content reviewed date`**. Menu link under *Content* (`system.admin_content`).

Behaviour:

- If no bundles are enabled, prints a message linking to settings.
- Groups enabled bundles by their effective threshold (`getThresholdDaysForBundle`) to minimise
  queries; per group runs an entity query with `accessCheck(TRUE)`, `status = 1`, `type IN
  (bundles)`, and an OR group `content_reviewed_date < thresholdDate` **or**
  `notExists('content_reviewed_date')` — so never-reviewed published nodes count as stale.
- De-duplicates node IDs, sorts numerically, paginates 50 per page (`pager.manager`), renders a
  table of Title / Content type / Last reviewed (`Never` when unset), `#cache max-age 0`.

## Uninstall

`content_reviewed_date_uninstall()` calls `entityDefinitionUpdateManager()` to uninstall both field
storage definitions (`content_reviewed_date`, `content_reviewed_uid`), dropping the columns and
leaving the entity schema consistent.
