<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Limiting an entity_reference field to chosen config entities

## Prerequisite

The field's `target_type` must be a **configuration** entity type (implements
`ConfigEntityInterface`) — e.g. `image_style`, `node_type`, `user_role`, `view`,
`filter_format`, `menu`, `taxonomy_vocabulary`, `block`, `entity_view_mode`, or any config type a
contrib module defines. Core's `DefaultSelection` already references these; this module adds the
ability to allow only a subset.

## Via the UI

1. Enable the module (`drush en config_entity_reference_selection`).
2. On an `entity_reference` field whose target is a config type, open **Field settings**
   (`admin/structure/.../fields/.../field-settings` or the field edit form).
3. Set **Reference method** (the selection handler) to
   **"Config: Filtered by specific &lt;plural label&gt;"** — internally the handler
   `config:<target_type>`.
4. A **Allowed &lt;plural label&gt;** multi-select appears. Pick the entities editors may reference.
   Select none to allow all. (Auto-create is intentionally hidden — you cannot create config
   entities from a content form.)
5. Save. Only the selected config entities now appear in the field's autocomplete / options widget.

## Via configuration (field config YAML)

The handler and its allowed list live in the field's config. Example for a field targeting
`image_style`:

```yaml
# field.field.node.article.field_layout_style.yml
field_type: entity_reference
settings:
  handler: 'config:image_style'
  handler_settings:
    filter:
      allowed_ids:
        - large
        - medium
        - thumbnail
    target_bundles: null
```

- `handler` is `config:<target_type>`.
- `handler_settings.filter.allowed_ids` is a **keyless sequence** of entity ids (config machine
  names). An empty/absent list allows every entity of the type.
- Because this is field configuration, the constraint is exported with the site and travels
  between environments.

## Via code

```php
$field_config->setSetting('handler', 'config:user_role');
$field_config->setSetting('handler_settings', [
  'filter' => ['allowed_ids' => ['editor', 'reviewer']],
]);
$field_config->save();
```

Or resolve the handler directly:

```php
$handler = \Drupal::service('plugin.manager.entity_reference_selection')->getInstance([
  'target_type' => 'view',
  'handler' => 'config:view',
  'handler_settings' => ['filter' => ['allowed_ids' => ['frontpage', 'archive']]],
]);
$referenceable = $handler->getReferenceableEntities();
```

## Behaviour recap

- With a non-empty `allowed_ids`, the query adds `<id key> IN (allowed_ids)`; label matching
  (autocomplete typing) still works via the inherited `DefaultSelection` behaviour.
- The allowed-ids picker only lists config entities the current user can `view label`.
- To customise how options are labelled, subscribe to
  `config_entity_reference_selection_label_display` (see `agent/plugins/config-selection-handler.md`).
