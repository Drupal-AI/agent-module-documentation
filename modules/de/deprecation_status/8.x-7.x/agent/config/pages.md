<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Report pages, routes, data pipeline & update flow

## Install / enable

`drush en deprecation_status`. Depends only on core `file`. The REST resources additionally need
core `rest` enabled and each resource configured/granted like any REST resource. No config objects
are installed; there is no settings form to save — `configure` points at the Projects page. Visit
`/drupal11/deprecation_status` or `/drupal12/deprecation_status`.

## Routes & permissions (`deprecation_status.routing.yml`)

Two parallel sets exist, suffixed `11` and `12`. The `11` routes add a `target_version: 11`
default; the `12` routes omit it and controllers/forms default the argument to `12`.

| Route (12 / 11 suffix) | Path | Handler | Permission |
|---|---|---|---|
| `summary12` / `summary11` | `/drupal{12,11}/deprecation_status` | `SummaryController::summaryPage` | `access content` |
| `projects_form12/11` | `…/projects` | `Form\ProjectsForm` | `access content` |
| `errors_form12/11` | `…/errors` | `Form\ErrorsForm` | `access content` |
| `error12/11` | `…/errors/{error_index}` | `Form\SingleErrorForm` | `access content` |
| `project12/11` | `…/projects/{machine_name}` | `Form\SingleProjectForm` | `access content` |
| `charts12/11` | `…/charts` | `Controller\ChartController::chartPage` | `access content` |
| `update12/11` | `…/update` | `Form\UpdateForm` | `administer deprecation status data` |

Local tasks (`deprecation_status.links.task.yml`) render the tabs Summary / Projects / Errors /
Charts / Update, with Error detail and Project detail as sub-tasks. `deprecation_status.links.menu.yml`
is entirely commented out. The single permission is defined in `deprecation_status.permissions.yml`
with `restrict access: true`. All report pages only *read* shipped ecosystem data; the update route
is the only state-changing one.

## The DataSource pipeline (`src/DataSource.php`)

All data access is static. `DataSource::$datafiles` lists the 30 CSV base files (15 per version,
prefixed `11_` / `12_`).

- `getFullPath($filename, $target_version = 12)` — builds `<prefix>$filename`, looks up a managed
  `file` entity at `private://deprecation_status_<prefix>$filename`; if present uses that URI,
  otherwise returns the shipped `modules/…/deprecation_status/data/<prefix>$filename`. So an admin
  update transparently overrides the shipped copy.
- `getMetaData($v)` / `getShippedMetaData($v)` — read `metadata.csv` (`id;date`) split on `;`.
- `updateDataFiles()` — for each file, `\Drupal::httpClient()->get('https://git.drupalcode.org/project/deprecation_status/raw/8.x-7.x/data/<file>?<time()>')`,
  buffers all in memory, then writes each to `private://deprecation_status_<file>` via
  `file.repository` `writeData(… EXISTS_REPLACE)`. All-or-nothing; returns TRUE or an error string.
  Uses the core client's default TLS verification; the URL is the module's own hardcoded repo path.
- `resetDataFiles()` — deletes the private `deprecation_status_*` file entities, returning the count.
- `formatError($error)` — turns deprecation messages into linked HTML: regex-links `deprecated
  function name()` and `Drupal\…` class references to api.drupal.org, links bare drupal.org URLs,
  and inserts zero-width spaces around backslashes so long namespaces wrap. Output is placed into
  `#markup`. Input is the scanned deprecation message from the report CSV (`errors_detail.csv`
  column 4).
- `getDataInfo($v)` / `getAvailableTargetVersions()` — dataset banner markup and the list of
  numeric target versions parsed from the file prefixes.

CSVs are parsed with `fgetcsv($fh, 0, ";", '"', '\\')` — **semicolon-separated**. Report builds set
`#cache['tags'] => ['deprecation_status']`; the Update form invalidates that tag after update/reset.

## Pages (what each renders)

- **SummaryController::summaryPage** — reads the last row of `next_steps_specific.csv` for the
  headline counts, `next_steps_help.csv` for guidance text; renders an intro, a stacked Chart.js
  bar, and per-bucket `<h2>` links into the Projects page filtered by `next_step`.
- **ProjectsForm** — loads `projects_detail.csv`, applies filters read from `$_GET`
  (`names`, `next_step`, `maintainer`, `type`, `topx`), custom `tableSort`/`tableFilter`, a core
  pager (30/page), pie charts (projects by next step, errors by category), and a linked table.
  Name filters build regexes via `preg_quote()` with `*`→`.*`; maintainer/name matching uses
  `preg_match`. Submit redirects to the same route carrying the filters as query args.
- **ErrorsForm** — loads `errors_detail.csv`, same filter/sort/pager pattern; renders each error
  message through `DataSource::formatError()`. Category, name, message-text and top-X filters.
- **SingleProjectForm** — 404s (`NotFoundHttpException`) if `{machine_name}` is not a prefix of any
  `projects_detail.csv` row; shows a summary table, next-step guidance, and the project's own error
  list (also via `formatError()`). Only projects with real errors get the error list.
- **SingleErrorForm** — 404s if `{error_index}` row is missing; shows the formatted error, counts,
  and the list of affected projects parsed from the CSV, filterable by name/top-X.
- **ChartController::chartPage** — inlines moment.js + Chart.js from `cdn.jsdelivr.net` and builds
  several historical line/bar charts from `*_segments.csv`, `error_counts*.csv`, `error_types*.csv`
  (and, in a disabled `graph11Deprecations()`, `core_deprecation_count.csv`).

## Update flow (`Form\UpdateForm`, permission `administer deprecation status data`)

`buildForm()` shows shipped vs. live vs. online dataset ids (fetching the two `*_metadata.csv` from
git.drupalcode.org to display the online id) and two buttons. `submitForm()` dispatches on the
triggering element `#name`: `reset` → `DataSource::resetDataFiles()`; `update` →
`DataSource::updateDataFiles()`. Both invalidate the `deprecation_status` cache tag. Downloaded data
is stored as private files, so it is never web-served directly.

## Notes for agents

- Filters read directly from `$_GET` (with `@` silencing) rather than validated form state; the
  values are used for `preg_match`/table filtering and are not written back into markup unescaped
  except `next_step`, which the Projects page only echoes after matching it against a known
  `next_steps_help.csv` key (the code notes this validates it).
- The whole relevant CSV is loaded into PHP arrays on every uncached page view; the "all projects"
  datasets are large, so expect proportional memory/time.
- Chart pages depend on external CDN availability (jsdelivr) for Chart.js/moment.js; offline sites
  see empty charts.
