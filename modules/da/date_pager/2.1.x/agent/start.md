<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date Pager (date_pager) — agent index

A single **Views pager plugin** (id `date`) that pages a view through **time periods** — year,
month, day, hour or minute — instead of numbered offset pages. You pick a date field on the view and
a maximum *granularity*; the pager reads a `?date=…` query parameter (e.g. `?date=2026-09`),
constrains the view's result set to that period with a **range `WHERE`** (`start < periodEnd AND
end >= periodStart`, not an `OFFSET`), and renders a nested list of period links (years → months →
days → hours → minutes) built by `template_preprocess_datepager()`. Supported field types:
`datetime`, `daterange`, `changed`, `created`, `smartdate` (the last three stored as unix timestamps
are converted internally). There is **no settings page** — all configuration lives in the view's
pager options form.

The plugin class `DatePager` (`src/Plugin/views/pager/DatePager.php`) does the Views wiring
(options form, `query()`, `setCurrentPage()`, min/max date-range subquery, caching); a helper class
`PagerDate extends \DateTime` (`src/PagerDate.php`) handles granularity-aware date math and builds
each period's link render array (`toLink()`). Output is themed via the `datepager` theme hook
(`templates/datepager.html.twig`) and the `date_pager/datepager` CSS library.

- Depends on: `drupal:views`. Test-only dependency: `smart_date` (so smartdate fields are supported,
  but smart_date is not required at runtime).
- Core: `^10 || ^11`. Package: `views`.
- **No** `configure`/settings route (configured per view pager), **no** permissions, **no** services
  of its own, **no** drush commands, **no** custom plugin *types*. Provides config schema
  (`views.pager.date`).

## What you'd do → where

- **Add the date pager to a view; set granularity, date field, default period, sort order; the
  `?date=` URL parameter; the query/range mechanism; supported field types; theming and the
  `PagerDate` helper** → [plugins/date-pager.md](plugins/date-pager.md)

## Key facts (real machine names)

- Views pager plugin: id **`date`** (title "Date Pager", short_title "Date", `theme = "datepager"`,
  `register_theme = TRUE`), class `Drupal\date_pager\Plugin\views\pager\DatePager` (extends
  `PagerPluginBase`, implements `CacheableDependencyInterface`).
- Helper class: `Drupal\date_pager\PagerDate` (extends `\DateTime`).
- Pager option keys (config schema `views.pager.date`): `granularity` (int 0–4), `default_page`
  (string), `date_field` (string, `{entity_type}.{field_name}`), `date_sort` (bool).
- Granularity levels: `0`=Year, `1`=Month, `2`=Day, `3`=Hour (default), `4`=Minute.
- `default_page` values: `earliest`, `now` (default), `latest`.
- Supported date field types: `changed`, `created`, `datetime`, `daterange`, `smartdate`
  (`$supportedDateTypes`); unix-timestamp-stored types `changed`, `created`, `smartdate`
  (`$unixtimestampTypes`).
- URL query parameter: **`date`** (regex-validated `^\d{4}(-[0-1][0-9](-[0-3][0-9](T[0-2][0-9](:[0-6][0-9])?)?)?)?$`).
- Theme hook: `datepager` (template `datepager.html.twig`, preprocess `template_preprocess_datepager`).
- Library: `date_pager/datepager` (CSS `css/date-pager-component.css`, `css/date-pager-state.css`).
- Hooks implemented: `hook_help` (route `help.page.date_pager`), `hook_theme`,
  `template_preprocess_datepager`.
- No routes file, no `*.services.yml`, no `*.permissions.yml`, no `*.links.*.yml`.
