<!--
SPDX-License-Identifier: GPL-2.0-or-later
-->
# Displaying the field (form widget + view formatters)

The module has **no settings form** (`configure` is `null`) and adds **no config objects**.
"Configuration" here means the node form/display and per-field-display settings.

## On the node edit form
`hook_form_node_form_alter()` places the "Published on" widget into the
`revision_information` group (the *Authoring/revision information* vertical tab). Visibility is
by permission (see permissions/permissions.md):
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
`hook_field_formatter_info_alter()`, so you can format it as an absolute date or as
"published N days ago".

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
Or via Views: add the **Published on** field/sort to any node-based view to sort by true
publication date instead of `created`.
