# Enable cloning per bundle

## Admin UI & permissions

- Overview: route `content_entity_clone.overview` → `/admin/config/content_entity_clone`
  (permission `administer entity cloning`). Lists every content-entity type/bundle, its enabled
  status, and an **Edit** link to its settings.
- Per-bundle form: route `content_entity_clone.bundle.field_settings` →
  `/admin/config/content_entity_clone/field_settings/{entity_type}/{bundle}`
  (permission `administer entity cloning`). The `{entity_type}` param is converted to a
  `ContentEntityTypeInterface` by a custom param converter (`content_entity_clone:entity_type`);
  non-content or unknown entity types 404.
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
  body:
    processor:
      id: copy_values
  field_image:
    processor:
      id: copy_values
```

Only fields present in `fields` are processed onto the clone; a field with no entry (the form's
"Skip field" option) is left at its default (empty) on the new entity. Each field names a
**processor id** (a `content_entity_clone` FieldProcessor plugin) plus optional `settings`
(schema `content_entity_clone.field_processor.settings.<id>`). The bundle form only writes
`processor.id`; it does not collect per-plugin `settings` (a shipped example schema exists for
`add_suffix`, and the README lists a settings form as a TODO). The form skips fields that are
internal, computed, or read-only, and shows only processors whose `supports()` matches the field.

## Scriptable enable / read

```php
\Drupal::configFactory()->getEditable('content_entity_clone.bundle.settings.node.article')
  ->set('enabled', TRUE)
  ->set('local_task_label', 'Clone')
  ->set('langcode', 'en')
  ->set('fields', [
    'title' => ['processor' => ['id' => 'entity_label_clone_suffix']],
    'body'  => ['processor' => ['id' => 'copy_values']],
  ])
  ->save();
```

```bash
drush cget content_entity_clone.bundle.settings.node.article
```

## How a clone happens (and its access checks)

1. For a user with `clone content entities`, the `CloneLinkGenerator` service adds a **Clone**
   entity operation (`hook_entity_operation`) and a **Clone** local task
   (`hook_menu_local_tasks_alter`) when the bundle config has `enabled: true`. The link is only
   emitted if: the user can reach the target entity type's **creation route**
   (`accessManager->checkNamedRoute(...)`) AND has **update** access to the source entity.
2. The link points to the entity's creation route with `?content_entity_clone=<source_id>`
   (and `content_entity_clone_language=<langcode>`). The creation route is inferred from the
   entity type's `add_form` route, else its `add-form` / `create` / `collection` link templates.
3. The OOP `entity_prepare_form` hook (runs first, `Order::First`) re-checks: the user has
   `clone content entities`, the request carries `content_entity_clone=<id>`, the form entity is a
   **new** `ContentEntityInterface`, cloning is enabled for its bundle, the source loads, and the
   current user has **update** access to the source. It then clones each configured field, calls
   the processor's `process()`, and copies the processed values onto the new **unsaved** entity.
   The user reviews and saves.

## Config schema

`content_entity_clone.bundle.settings.*.*` — `enabled` (bool), `langcode`, `local_task_label`
(label), `fields` (sequence of `{ processor: { id, settings } }`, where `settings` uses schema
`content_entity_clone.field_processor.settings.<id>`).

## Update path

`content_entity_clone_update_90001()` migrates legacy `fields.<field>.id` entries to the current
`fields.<field>.processor.id` shape and backfills a missing `langcode`. Run `drush updatedb`
after upgrading from 1.x.
