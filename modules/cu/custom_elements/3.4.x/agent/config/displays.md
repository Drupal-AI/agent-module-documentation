<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Elements Display config entity

Config entity type **`entity_ce_display`** (`Drupal\custom_elements\Entity\EntityCeDisplay`,
extends core `EntityDisplayBase`). One per `{targetEntityType}.{bundle}.{mode}`, config prefix
`custom_elements.entity_ce_display.*.*.*`. It is the 3.x primary mechanism: it maps each field
(component) to a `CustomElementsFieldFormatter` plugin, the way a core entity view display maps
fields to core formatters.

## Stored properties (schema `custom_elements.schema.yml`)

- `id`, `targetEntityType`, `bundle`, `mode` (view/form mode machine name).
- `customElementName` — the element tag. Defaults (via
  `EntityCeDisplay::getDefaultCustomElementName()`) to `{entity}-{bundle}-{mode}` or
  `{entity}-{mode}` for bundleless types.
- `useLayoutBuilder` (bool) — build via Layout Builder (only honoured if the core display also
  enables Layout Builder).
- `forceAutoProcessing` (bool) — use the tagged-processor pipeline instead of components (2.x-style).
- `content` — a sequence of components, each `{formatter, field_name, is_slot, weight,
  configuration}`. `configuration` schema is resolved by
  `custom_elements.field_formatter.configuration.[%parent.formatter]` (permissive `type: ignore`
  fallback for un-typed contrib plugins).

## Runtime behaviour

- `getRenderer($component_name)` instantiates the component's formatter plugin, injecting
  `field_definition`, `view_mode`, `name`, `is_slot` + the component's stored `configuration`.
- `getCustomElementName()`, `getUseLayoutBuilder()`, `getForceAutoProcessing()`,
  `getComponents()` / `setComponent()` / `removeComponent()`.
- Auto-creation: `CustomElementGenerator::getEntityCeDisplay()` falls back requested-mode →
  `default` mode → an in-memory display (mode `default`) that enables all fields of the core view
  display, all with the `auto` formatter. So rendering works even with no saved CE display.

## The UI submodule (`custom_elements_ui`)

Depends on `custom_elements` + `field_ui`. `RouteSubscriber` adds, for every entity type with a
`field_ui_base_route`, a **"Manage custom element"** tab:
- `<field-ui-path>/ce-display` (default mode) → `entity.entity_ce_display.<type>.default`
- `<field-ui-path>/ce-display/{view_mode_name}` → `entity.entity_ce_display.<type>.view_mode`

Form: `EntityCustomElementsDisplayEditForm` (`_entity_form: entity_ce_display.edit`). Access is the
custom check `_custom_elements_ui_view_mode_access` (`CustomElementViewModeAccessCheck`): the
`default` mode is always visible, other modes only if their CE display exists and is enabled; then
it requires the dynamic per-entity-type permission **`administer <entity_type_id> custom element
display`** (defined by `CustomElementsUiPermissions::ceDisplayPermissions()` for each fieldable
entity type, dependent on that entity's provider module). Config entity access is handled by
`EntityCeDisplayAccessControlHandler`.

Note: the UI submodule is the only part of the project that defines permissions; the main module
defines none.
