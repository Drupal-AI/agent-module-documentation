<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs table — applying it & item routes

There is **no configure route** (`configure: null`). You enable the table formatter/widget
**per field** on the host entity's *Manage display* / *Manage form display* (the field must
be a Paragraphs reference field, i.e. `entity_reference_revisions`).

## Enable the table FORMATTER (view display)

UI: *Manage display* → set the paragraphs field's Format to **"Paragraphs table"**, open the
cog to choose `vertical`, `mode` (Datatables / Bootstrap Table / Google Charts), caption, etc.

Drush / config (component on the `entity_view_display`):

```bash
drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $d->setComponent("field_my_paragraphs", [
    "type" => "paragraphs_table_formatter",
    "region" => "content",
    "settings" => ["mode" => "bootstrapTable", "vertical" => FALSE, "view_mode" => "default"],
  ])->save();
'
```

## Enable the table WIDGET (form display)

UI: *Manage form display* → set the field's Widget to **"Paragraphs table"**, then configure
`vertical`, `paste_clipboard`, `show_all`, features, etc.

Drush / config (component on the `entity_form_display`):

```bash
drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $d->setComponent("field_my_paragraphs", [
    "type" => "paragraphs_table_widget",
    "region" => "content",
    "settings" => ["vertical" => TRUE, "paste_clipboard" => FALSE, "show_all" => FALSE],
  ])->save();
'
```

Settings are stored under the component's `settings` (schemas
`field.formatter.settings.paragraphs_table_formatter`,
`field.widget.settings.paragraphs_table_widget`,
`field.formatter.settings.paragraphs_table_json_formatter`).

## Paragraph item routes (individual paragraph management)

`paragraphs_table.routing.yml` adds routes/controllers to manage single paragraph items,
used by the table's row operations and AJAX/JSON loading:

- `entity.paragraphs_item.canonical` → `/paragraphs_item/{paragraph}`
- `paragraphs_item.add_page` → `/paragraphs_item/add/{paragraph_type}/{entity_type}/{entity_field}/{entity_id}`
- `entity.paragraphs_item.edit_form` / `.delete_form` / `.clone_form` → `/paragraphs_item/{paragraph}/edit|delete|clone`
- `paragraphs_item.ajax` / `.json` / `.jsonData` → `/paragraphs_item/{ajax|json|jsondata}/{field_name}/{host_type}/{host_id}`
- `paragraphs_table.field_reference` → reference-search endpoint for the widget.

## Permission

`administer paragraphs_item fields` — "Create, duplicate and delete fields on paragraphs"
(restricted). Access to the item routes is enforced by the module's access controllers.
