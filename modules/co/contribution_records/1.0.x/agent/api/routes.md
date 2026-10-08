<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, permissions & endpoints

All routes are defined in `contribution_records.routing.yml` and served by
`src/Controller/ContributionRecordController.php` (except the settings form). Query-parameter
meanings: `username`, `organization` (org node title), `machine_name` (project machine name),
`page`, `months` (last N months; omit for all-time), `is_sa` (0/1), `csv_export` (0/1).

## Public read / redirect endpoints (`_permission: 'access content'`)

- **`contribution_records.process`** — `GET /contribution-record`. `process()`: given
  `source_link`, redirects to the existing record if the link is already imported
  (`isDuplicated`), to `/node/add/contribution_record?source_link=…` if the link is valid-format
  but not yet fetchable, or **creates** the record (`SourceLink::createContribRecord()`) and
  redirects to it (or to its JSON:API URL when `format=jsonapi`). This is the public
  "attribute your contribution" entry point.
- **`contribution_records.by_user`** — `GET /contribution-records-by-user`. `byUsername()`
  resolves the user via `drupalorg.user_service`, then 302-redirects into the
  `jsonapi_views.contribution_records.by_user` display with mapped `views-argument`/`views-filter`
  query args. `csv_export=1` redirects to `/contribution-records-by-user-export/{uid}` instead.
- **`contribution_records.by_organization`** — `GET /contribution-records-by-organization`.
  `byOrganization()` resolves the org node by title via `drupalorg.organization_service` and
  redirects into `jsonapi_views.contribution_records.by_organization`.
- **`contribution_records.by_organization_by_user`** — `GET
  /contribution-records-by-organization-by-user`. Combined org+user filter, includes
  `field_contributors`.
- **`contribution_records.metrics`** — `GET /contribution-records-metrics`. `metrics()` runs the
  `contribution_records_metrics` view for a required `display` (one of `credits`, `demographics`,
  `region`, `account_age`) and required 4-digit `year` (optional `month`), returning aggregated
  per-year-month counts as JSON (formatted by `formatMetrics*()`).

## Source activity (`_access: 'TRUE'`)

- **`contribution_records.source_activity_information`** — `GET /contribution-record-source-activity`.
  `sourceActivityInformation()` validates the `source_link` (domain-allowlisted to
  www.drupal.org / git.drupalcode.org, or dev domains only when enabled) and returns issue meta +
  per-user activity (comments/files/reactions) as a `CacheableJsonResponse` (max-age 600, or 0
  when `maintainer=1`). Consumed by `js/issue_activity.js`.

## Trusted / privileged endpoints

- **`contribution_records.import`** — `POST /contribution-record-import`, `_format: json`,
  `_custom_access: ContributionRecordController::executeImportAccess`. Access requires a non-empty
  `Drupalorg-Credit-Migration-Token` header equal (strict `===`) to
  `drupalorg.settings.credit_migration_token`. `import()` validates required fields
  (`url`, `title`, `credits`), then either queues the payload
  (`contribution_records_import_queue_worker`) when `queue` is set, skips duplicates, or builds the
  record directly via `SourceLink::createContribRecordFromRawData()`.
- **`contribution_records.save_contributors_order`** — `POST /contribution-record-save-order`,
  `_permission: 'edit any contribution_record content'`. `saveContributorsOrder()` additionally
  re-checks that the current user `isMaintainer()` of the record's project **or** has
  `administer contribution records` before calling `SourceLink::sortContributors()`.
- **`contribution_records.settings`** — `/admin/config/contribution-records/settings`,
  `_permission: 'administer site configuration'`. See [../config/settings.md](../config/settings.md).

## Permission & entity access (`.module`)

- Permission **`administer contribution records`** (`contribution_records.permissions.yml`) —
  lets a non-maintainer edit any field of any record.
- `hook_entity_access` on `contribution_record`: **delete** requires
  `administer contribution records`; **update** requires that permission **or**
  `SourceLink::isMaintainer($user)` (maintainer resolved live from the source project).
- `hook_form_alter` locks down the add/edit node forms and the `contributor` paragraph form;
  maintainers without `administer contribution records` are redirected away from the full node
  **edit** form (they credit via Quick Credits instead of editing individual contributions).
