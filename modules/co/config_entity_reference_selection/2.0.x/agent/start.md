<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config entity reference selection (config_entity_reference_selection) — agent index

Derives an `EntityReferenceSelection` handler **per configuration entity type** so an
`entity_reference` field can be limited to a hand-picked subset of that type instead of
offering every config entity that exists (and every one added later).
Version **2.0.3**. No dependencies, no permissions, no routes, no UI beyond field settings.
Core requirement `^10.1 || ^11 || ^12`.

## Mechanism in one screen

- One base plugin, id **`config`**, extends core `DefaultSelection`, group `config`.
  File: `src/Plugin/EntityReferenceSelection/ConfigEntityReferenceSelection.php`.
- A **deriver** (`src/Plugin/Derivative/ConfigEntityReferenceSelection.php`) iterates
  `entityTypeManager->getDefinitions()` and emits one derivative for every entity type whose
  class implements `ConfigEntityInterface`. On a real site that yields
  `config:image_style`, `config:node_type`, `config:user_role`, `config:view`,
  `config:filter_format`, `config:menu`, `config:taxonomy_vocabulary`, `config:field_config`,
  and so on — one handler per config entity type present.
- Field settings gain an **Allowed &lt;plural label&gt;** multi-select. Chosen ids are stored at
  `handler_settings.filter.allowed_ids` as a keyless sequence (keys stripped in
  `validateConfigurationForm`). Empty list = allow all.
- `buildEntityQuery()` calls `parent::buildEntityQuery()` then, when `allowed_ids` is non-empty,
  adds `->condition(<entity id key>, allowed_ids, 'IN')`. That is the whole filter.
- The options list is built by `getOptions()`: `loadMultiple()`, keep only entities passing
  `$entity->access('view label')`, dispatch a `LabelDisplayEvent` per entity to resolve the
  displayed label, `asort()`.
- **Auto-create is force-disabled** (`$form['auto_create']['#access'] = FALSE`) — you cannot
  create new config entities from a content form.

## Extension point

- `Events::LABEL_DISPLAY` (`'config_entity_reference_selection_label_display'`), event class
  `src/Event/LabelDisplayEvent.php`. Subscribe to rewrite the label shown for a config entity in
  the allowed-ids picker. The module ships `FieldConfigLabelDisplaySubscriber`, which turns
  `field_config` options into `Entity type - Bundle - Field` so ambiguous field labels are
  distinguishable.

## Files

- `agent/plugins/config-selection-handler.md` — the derived handler, deriver, query filter, label event.
- `agent/fields/limit-config-reference.md` — configuring a field (UI + code) to use a `config:<type>` handler.

## Config schema

`config/schema/config_entity_reference_selection.schema.yml` extends
`entity_reference_selection.default` with `filter.allowed_ids` (nullable sequence of strings).

## Security

Selection handlers are admin-configured; the allowed-ids picker filters by `view label` access,
and the query uses parameterised `IN` conditions. No permissions, routes, or user-supplied input
paths of note. See the maintainers' security posture in usage; no known issues in this version.
