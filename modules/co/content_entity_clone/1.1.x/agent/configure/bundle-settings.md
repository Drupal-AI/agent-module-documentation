# Enable cloning per bundle

## Admin UI & permissions

- Overview: route `content_entity_clone.overview` → `/admin/config/content_entity_clone`
  (permission `administer entity cloning`). Lists entity types/bundles and links to their settings.
- Per-bundle form: route `content_entity_clone.bundle.field_settings` →
  `/admin/config/content_entity_clone/field_settings/{entity_type}/{bundle}`.
- Permission to actually clone entities (see the Clone action): **`clone content entities`**.

## Config object

Enabling a bundle writes `content_entity_clone.bundle.settings.<entity_type>.<bundle>`:

```yaml
enabled: true
langcode: en
local_task_label: 'Clone'          # optional; label for the clone link/local task
fields:                            # which fields are carried to the clone, and how
  title:
    processor:
      id: entity_label_clone_suffix   # appends ' [CLONE]' to the label
      settings: {  }
  body:
    processor:
      id: copy_values
      settings: {  }
  field_image:
    processor:
      id: copy_values
      settings: {  }
```

Only fields present in `fields` are processed onto the clone; a field with no entry is left at its
default (empty) on the new entity. Each field names a **processor id** (a `content_entity_clone`
FieldProcessor plugin) plus optional `settings` (schema
`content_entity_clone.field_processor.settings.<id>`).

## Scriptable enable / read

```php
\Drupal::configFactory()->getEditable('content_entity_clone.bundle.settings.node.article')
  ->set('enabled', TRUE)
  ->set('local_task_label', 'Clone')
  ->set('fields', [
    'title' => ['processor' => ['id' => 'entity_label_clone_suffix', 'settings' => []]],
    'body'  => ['processor' => ['id' => 'copy_values', 'settings' => []]],
  ])
  ->save();
```

```bash
drush cget content_entity_clone.bundle.settings.node.article
```

## How a clone happens

1. For a user with `clone content entities`, the module adds a **Clone** entity operation
   (`hook_entity_operation`) and a **Clone** local task (`hook_menu_local_tasks_alter`) on the
   entity, when its bundle config has `enabled: true`.
2. The link points to the entity's creation route with `?content_entity_clone=<source_id>`
   (and `content_entity_clone_language=<langcode>`).
3. `content_entity_clone_entity_prepare_form()` (which runs first, via
   `hook_module_implements_alter`) loads the source, and for each configured field clones it, calls
   the field processor's `process()`, and copies the processed values onto the new **unsaved**
   entity. The user then reviews and saves.

## Config schema

`content_entity_clone.bundle.settings.*.*` — `enabled` (bool), `langcode`, `local_task_label`
(label), `fields` (sequence of `{ processor: { id, settings } }`).
