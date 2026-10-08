<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a date_recur field to use a modular widget

The module has **no settings form and no `configure` route**. You "configure" it by
selecting one of its widgets as the form-display component for a `date_recur` field.
Prerequisite: a `date_recur` field exists on some bundle (created via the `date_recur`
module). Widget plugin ids: `date_recur_modular_alpha`, `date_recur_modular_oscar`,
`date_recur_modular_sierra`.

## Via the admin UI

Structure → Content types → *(bundle)* → **Manage form display**
(`/admin/structure/types/manage/{bundle}/form-display`). In the row for your
`date_recur` field, pick a widget from the Widget select: **Modular: Alpha /
Oscar / Sierra**. Use the gear icon to edit that widget's settings (below). Save.

## Via config (`core.entity_form_display.*`)

The chosen widget lives under the field's `content.{field_name}.type`:

```yaml
# core.entity_form_display.node.article.default.yml
content:
  field_event_recur:
    type: date_recur_modular_sierra   # or _alpha / _oscar
    weight: 5
    region: content
    settings:
      interpreter: ''          # sierra: date_recur_interpreter id, '' = none
      date_format_type: medium # sierra: date format machine name
      occurrences_modal: true  # sierra: enable the exclude-occurrences modal
    third_party_settings: {}
```

## Via code / drush (recommended for evals)

```php
$fname = 'field_event_recur';
\Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default')
  ->setComponent($fname, [
    'type' => 'date_recur_modular_alpha',
    'settings' => [],
  ])
  ->save();
```

Run with `drush php:eval '...'`. Confirm the assigned widget:

```bash
drush php:eval '
  $c = \Drupal::service("entity_display.repository")
    ->getFormDisplay("node","article","default")
    ->getComponent("field_event_recur");
  print $c["type"] . "\n";'
```

## Widget settings

| Widget | Setting | Default | Meaning |
|---|---|---|---|
| `date_recur_modular_oscar` | `all_day_toggle` | `TRUE` | Show an all-day toggle |
| `date_recur_modular_sierra` | `interpreter` | `NULL` | `date_recur_interpreter` config id used to render occurrence text |
| `date_recur_modular_sierra` | `date_format_type` | `medium` | Date format machine name for occurrence display |
| `date_recur_modular_sierra` | `occurrences_modal` | `TRUE` | Enable the modal to preview/exclude occurrences |

Alpha has no widget settings.

## Permission

Sierra's modal forms (routes `/date-recur-modular/sierra-modal-form` and
`…/sierra-modal-exclude-form`) require the permission
`date_recur_modular use sierra form`. Grant it to roles that edit fields using the
Sierra widget. Alpha and Oscar need no extra permission.
