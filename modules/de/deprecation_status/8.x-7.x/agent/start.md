<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Deprecation Status (deprecation_status) — agent index

Displays the Drupal Association **Project Analysis** report (deprecated-API and major-version
readiness of contributed drupal.org projects) as interactive report pages and charts. Ships the
report as CSV files for **Drupal 11** and **Drupal 12**. Not a scanner for your own site — it is
an ecosystem-wide dashboard (use Upgrade Status for a single site).

- Core requirement `^9.3 || ^10 || ^11`. Depends only on core **`file`**. License GPL-2.0-or-later.
  Package: none. Branch/version **8.x-7.x**. No composer requirements, no config objects/schema,
  no Drush, no hooks, no submodules.
- **Routes, permissions, pages, the data pipeline and the update flow** →
  [config/pages.md](config/pages.md)
- **The two REST resource plugins** → [api/rest-resources.md](api/rest-resources.md)

## What it actually is

- A set of controllers and forms that read shipped/updated CSV datasets and render tables and
  Chart.js graphs. Two URL trees, one per target version: `/drupal11/deprecation_status*` (routes
  pass `target_version: 11`) and `/drupal12/deprecation_status*` (default `target_version = 12`).
- Data access is centralized in `Drupal\deprecation_status\DataSource` (all static methods). CSVs
  live in the module's `data/` dir as `11_*.csv` / `12_*.csv`; an admin update writes fresher
  copies to `private://deprecation_status_<prefix><file>` which then take precedence.

## Provides

- **Controllers**: `Controller\SummaryController::summaryPage`, `Controller\ChartController::chartPage`.
- **Forms** (`FormBase`): `Form\ProjectsForm`, `Form\ErrorsForm`, `Form\SingleProjectForm`,
  `Form\SingleErrorForm`, `Form\UpdateForm`.
- **Service class** (not a registered service): `DataSource` — `getFullPath()`, `getMetaData()`,
  `getShippedMetaData()`, `updateDataFiles()`, `resetDataFiles()`, `formatError()`,
  `getAvailableTargetVersions()`, `getDataInfo()`.
- **REST resources**: `deprecation_status` (`GET /api/deprecation-status/{target_version}`) and
  `deprecation_versions` (`GET /api/deprecation-versions`).
- **Permission**: `administer deprecation status data` (restrict access) — gates only the Update page.
- **Library**: `deprecation_status/deprecation_status.lists` (one theme CSS file). Local menu tasks
  for each report tab. Cache tag `deprecation_status` on all report builds.

## Key facts for agents

- Every report page (`summary`, `projects`, `errors`, per-project, per-error, `charts`) requires
  only the `access content` permission; they render **public ecosystem report data** shipped with
  the module. The only privileged route is `*/update` (`administer deprecation status data`).
- The CSV field separator is `;` (semicolon), not comma. `DataSource::getFullPath($file, $version)`
  prefers a `private://` copy, else the shipped `data/<version>_<file>` file.
- Chart pages inline `<script src="https://cdn.jsdelivr.net/npm/chart.js@...">` and moment.js from
  a CDN, plus inline chart config built from the CSV numbers.
- The admin Update page downloads CSVs from
  `https://git.drupalcode.org/project/deprecation_status/raw/8.x-7.x/data/<file>` via the core
  `http_client` (Guzzle default TLS verification), all-or-nothing into memory before saving.
