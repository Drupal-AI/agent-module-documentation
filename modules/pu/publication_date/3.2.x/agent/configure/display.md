<!--
SPDX-License-Identifier: GPL-2.0-or-later
-->
# Displaying the field (form widget + view formatters + Views)

The module has **no settings form** (`configure` is `null`) and adds **no config objects**.
"Configuration" here means the node form/display, per-field-display settings, and Views.

## On the node edit form
`PublicationDateHooks::formNodeFormAlter()` (`hook_form_node_form_alter()`) places the
"Published on" widget into the `revision_information` group (the *Authoring/revision information*
vertical tab). Visibility is by permission (see permissions/permissions.md):
- edit permission → widget shown and editable,
- view-only permission → widget shown but **disabled** (read-only),
- neither → widget hidden (`#access = FALSE`).

The widget is `publication_date_timestamp` (`TimestampDatetimeWidget`), a `datetime` element
with year range `1902:2037` and help text **"Leave blank to use the time of form submission."**
Leaving it empty keeps the auto-stamp-on-first-publish behavior; filling it in back/forward-dates.

## In view display / formatters
The field is `no_ui` so it does not appear in Field UI as an addable field, but it is
`setDisplayConfigurable('view', TRUE)` and ships hidden by default. `published_at` is registered
with core's **`timestamp`** (default) and **`timestamp_ago`** formatters via
`PublicationDateHooks::fieldFormatterInfoAlter()` (`hook_field_formatter_info_alter()`), so you
can format it as an absolute date or as "published N days ago".

Enable it in a view display with drush (Article example):
```bash
drush php:eval '
  $d = \Drupal::service("entity_display.repository")
    ->getViewDisplay("node", "article", "default");
  $d->setComponent("published_at", [
    "type" => "timestamp",
    "label" => "inline",
    "settings" => ["date_format" => "medium"],
  ])->save();
'
```

## In Views
`PublicationDateHooks` registers `published_at` as a field/sort/filter on node-based views, and
`PublicationDateViewsHooks::viewsDataAlter()` (`hook_views_data_alter()`) adds date **arguments**
on both `node_field_data` and `node_field_revision`:
- `published_at` — argument/filter/sort handled by the core `date` handlers.
- `published_fulldate` (CCYYMMDD), `published_year_month` (YYYYMM), `published_year` (YYYY),
  `published_month` (MM), `published_day` (DD), `published_week` (WW) — contextual date
  arguments for grouping/archives.

Add the **Published on** field/sort to any node-based view to sort by true publication date
instead of `created`.
