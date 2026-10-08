<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views integration

Views support comes from `entity` module's base data plus two small custom handlers and one
optional shipped view.

## Views data (`Drupal\log\LogViewsData`)

Extends `entity` module's `EntityViewsData`. In `getViewsData()` it re-points the
`timestamp` column on the data table `log_field_data` to the module's custom handlers:

- `data['log_field_data']['timestamp']['sort']['id'] = 'log_standard'`
- `data['log_field_data']['timestamp']['field']['id'] = 'log_field'`

Everything else (fields, filters, relationships for all base fields) is standard entity
Views data.

## Sort handler `log_standard` (`Plugin\views\sort\LogStandardSort`)

`#[ViewsSort('log_standard')]`, extends core `Date`. Sorts by the timestamp **and then by
`id`** so logs with an identical timestamp get a stable, deterministic order. Honors a
`granularity` option (`second` default, `minute`, `hour`, `day`, `month`, `year`) applied via
a date-format formula; the secondary `id` order is always added. Schema: `views.sort.log_standard`
with a `granularity` string. `getDateField()` targets `<table>.timestamp`.

## Field handler `log_field` (`Plugin\views\field\LogField`)

`#[ViewsField('log_field')]`, extends core `EntityField`. Overrides `clickSort()` so that
click-sorting the timestamp column also adds a secondary sort on `id` (same tie-break as the
sort handler). Schema: `views.field.log_field`.

## Optional admin view `log_admin`

`config/optional/views.view.log_admin.yml` — base table `log_field_data`, a page display at
path `admin/content/log` (overriding the entity collection route at that path), titled
"Logs". Access: `type: perm`, `perm: 'administer log'`. Provides a bulk-operations listing
(the log actions in [../api/actions.md](../api/actions.md)). Being in `config/optional`, it
installs only when Views is enabled (it always is — Views is a hard dependency).
