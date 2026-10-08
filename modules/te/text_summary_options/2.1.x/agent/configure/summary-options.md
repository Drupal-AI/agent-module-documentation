# The three summary settings

No configure route and no settings form. You set these on the **field's edit form**
(`/admin/structure/types/manage/<bundle>/fields/<field>`) for any
**Text (formatted, long, with summary)** (`text_with_summary`) field. They are stored as
third-party settings on the `FieldConfig`.

## Where they are stored

Config entity: `field.field.<entity_type>.<bundle>.<field_name>`:

```yaml
third_party_settings:
  text_summary_options:
    show_summary: true
    summary_help: 'Write a one-line teaser.'
    summary_placeholder: 'e.g. A short teaser...'
```

Config schema: `field.field.*.*.*.third_party.text_summary_options` (keys `show_summary`
bool, `summary_help` string, `summary_placeholder` string). The inputs are injected by
`text_summary_options_form_field_config_edit_form_alter()` and only appear when the field
being edited is of type `text_with_summary`.

## What each setting does at edit time

`text_summary_options_field_widget_single_element_form_alter()` reads the settings from the
field config (only for `text_with_summary`, only on real `FieldConfig` fields, and not on the
default-value widget) and:

- **`show_summary`** -- when truthy, `unset($element['summary']['#attached'])`. That removes
  core's summary toggle JS, so the summary textarea is shown **expanded by default** instead of
  hidden behind the "Edit summary" link.
- **`summary_help`** -- when non-empty, sets `$element['summary']['#description']` to this text
  (help shown under the summary box).
- **`summary_placeholder`** -- when non-empty, sets the summary textarea's
  `#attributes['placeholder']`.

Stored field values are unaffected; this only changes the editing widget.

## Via the UI

1. Go to *Manage fields* for the bundle, edit a **Text (formatted, long, with summary)** field
   (e.g. Body).
2. On the field edit form you now see: **Show summary**, **Summary help text**, **Summary
   Placeholder**.
3. Set them and **Save settings**.

## Via drush php:eval (scriptable)

```php
$fc = \Drupal\field\Entity\FieldConfig::loadByName('node', 'article', 'body');
$fc->setThirdPartySetting('text_summary_options', 'show_summary', TRUE);
$fc->setThirdPartySetting('text_summary_options', 'summary_help', 'Write a one-line teaser.');
$fc->setThirdPartySetting('text_summary_options', 'summary_placeholder', 'e.g. A short teaser...');
$fc->save();
```

Read back:

```bash
drush cget field.field.node.article.body third_party_settings.text_summary_options
```

To clear a setting, `unsetThirdPartySetting('text_summary_options', '<key>')` (or set
`show_summary` FALSE) and save.
