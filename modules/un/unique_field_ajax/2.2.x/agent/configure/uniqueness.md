# Configure field / title uniqueness

There is **no admin settings page**. You configure uniqueness on the field itself (or, for the
node title, on the content type). Everything is stored as third-party settings.

## On a field (Manage fields → field settings)

The "Unique field settings" fieldset appears on a field's settings form
(`field_config_edit_form`, *Manage fields → Edit* for a field) **only** when the field is:
- single-cardinality (not multiple), and
- one of these types: `string`, `string_long`, `list_string`, `text`, `email`,
  `entity_reference`, `path`, `uri`, `link`, `integer`, `decimal`, `color_field_type`.

Tick **Unique** and (optionally) the sub-options, then save. The values are written to the
field's config entity under `third_party_settings.unique_field_ajax`:

| Key | Type | Meaning |
|---|---|---|
| `unique` | 0/1 | Master switch. If off, the whole `unique_field_ajax` block is removed on save. |
| `per_lang` | 0/1 | Only forbid duplicates within the same language (adds a `langcode` condition). |
| `case_sensitive` | 0/1 | Match with `LIKE BINARY` (exact case) instead of `=`. |
| `use_ajax` | 0/1 | Add live AJAX validation (event `finishedinput`) as the editor types. |
| `no_enforce` | 0/1 | Warn only (CSS class `warning`) but still allow saving, instead of a form error. |
| `message` | string | Custom **error** message (used when enforcing). Supports `%link` and `%label`. |
| `message_warning` | string | Custom **warning** message (used when `no_enforce` is on). Supports `%link`, `%label`. |

Config location: `field.field.<entity_type>.<bundle>.<field_name>` →
`third_party_settings.unique_field_ajax.*`.

Set it with drush (example: make an existing Article field unique + case-sensitive):

```bash
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_code");
  $fc->setThirdPartySetting("unique_field_ajax", "unique", 1);
  $fc->setThirdPartySetting("unique_field_ajax", "case_sensitive", 1);
  $fc->save();
'
drush cget field.field.node.article.field_code third_party_settings.unique_field_ajax
```

## On the node title (Content type add/edit form)

The "Unique title settings" fieldset is added to `node_type_add_form` / `node_type_edit_form`
and governs the node `title` base field for that bundle. The same keys apply, stored on the
content type: `node.type.<bundle>` → `third_party_settings.unique_field_ajax.*`.

```bash
drush php:eval '
  \Drupal::entityTypeManager()->getStorage("node_type")->load("page")
    ->setThirdPartySetting("unique_field_ajax", "unique", 1)->save();
'
```

## Behavior notes
- Uniqueness is checked by `unique_field_ajax_is_unique()`: an entity query filtered by the
  field value, the bundle, excluding the current entity id, optionally by language, with access
  checks disabled. It returns TRUE if unique, otherwise the conflicting entity id.
- `%link` in a message renders a link to the conflicting entity (respecting its view access);
  `%label` renders the field label.
- When `use_ajax` is off, checking happens only on submit via `#element_validate`. When on, an
  additional throttled AJAX request (JS library `unique_field_ajax/unique_event`) validates live.
- With `no_enforce`, a failing check shows a warning and still saves; without it, `setErrorByName`
  blocks the save.
- Cardinality change: if a field is later made multiple, the settings fieldset no longer appears.
