<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal Canvas Field Component (canvas_field_component) — agent index

Exposes **rendered entity-field output as a Canvas ComponentSource** (`field_display`), so a Canvas
ContentTemplate can place the host entity's own fields — through the field's normal formatter
pipeline — without the field needing a component-prop mapping. Think "Layout Builder field block"
for the Drupal Canvas / Experience Builder page builder.

- **Version:** 1.0.2 (`1.0.x`). Core `^11.2 || ^12`, **PHP 8.3**.
- **Depends on:** `canvas:canvas` (Drupal Canvas), composer `drupal/canvas ^1.3`.
- **Configure:** `entity.component.collection` (the Canvas component collection). No routes, no
  permissions, no Drush commands.
- **Provides:** one Canvas `ComponentSource` plugin, a `config_schema_info_alter` hook, config
  schema, an install/update hook that creates the `field_display.field_display` Component entity.

## Mechanism (read the source, not the framework name)
This is **not** an SDC component and **not** a field formatter/widget. It is a Canvas
`ComponentSource` plugin — a page-builder component *source* whose render output is a Drupal field.

- `src/Plugin/Canvas/ComponentSource/FieldDisplayComponent.php` — the whole module. `#[ComponentSource(id: 'field_display', supportsImplicitInputs: TRUE, discovery: FALSE, updater: FALSE)]`, extends `Drupal\canvas\ComponentSource\ComponentSourceBase`.
- `src/Hook/ConfigSchemaHooks.php` — adds `field_display` to the allowed `source` Choice on `canvas.component.*`.
- `canvas_field_component.install` — creates the single `field_display.field_display` Component config entity in a hook (can't ship in config/install because `Component::preSave()` instantiates the source before the plugin cache knows it) and recomputes its version hash on update.
- `js/component-form-refresh.js` (library `canvas_field_component/component_form_refresh`) — on change of the field/formatter select, dispatches a Canvas store action so the live preview refreshes.
- `config/schema/canvas_field_component.schema.yml` — component_source_local_id + (empty) settings schema.

## How it works at runtime
- **Persisted inputs:** `field_name`, `entity_type_id`, `bundle`, `view_mode`, `formatter_id`, `formatter_settings`, `formatter_third_party_settings`, `label_display`.
- **Runtime-only (never saved, stripped in `optimizeExplicitInput()`):** `__entity` (resolved host entity), `__render_array`.
- `getExplicitInput()` resolves the host `FieldableEntityInterface` from the passed `$host_entity` or the component tree's root `EntityAdapter`.
- `hydrateComponent()` builds the render array via `$entity->get($field_name)->view(['type' => formatter_id, 'settings' => ..., 'label' => ..., 'third_party_settings' => ...])`; falls back to the Manage Display formatter when `formatter_id` is empty (back-compat). Wrapped in try/catch → empty render array if the formatter plugin is gone.
- `renderComponent()` just returns the pre-built `__render_array`.
- `buildComponentInstanceForm()` builds a field `select` (from `buildFieldOptions()` — configurable fields from `field_config` storage + non-hidden base fields from the display, pseudo-fields excluded), then a formatter select + label-display select + the formatter's own `settingsForm()` and any `hook_field_formatter_third_party_settings_form()` elements.

Lots of Canvas-specific glue lives here: `normalizeFormatterConfiguration()` / `normalizeSubmittedValuesByElement()` coerce Canvas's string-serialized values back to Form API types (checkbox/checkboxes/number/weight) for formatters like Smart Date; `flattenSelectOptions()`/`afterBuildFlattenOptgroups()` flatten `<optgroup>` selects the Canvas sidebar can't show; `rewriteFormatterStatesSelectors()` remaps `#states` selectors from Field-UI paths to nested Canvas prop paths; `normalizeNestedInputKeys()` repairs bracketed keys round-tripped through the Canvas form store.

Why it matters: field output goes through the core formatter pipeline — image/responsive styles,
date/text formats, entity-reference rendering, multi-value, **and core field-level access**
(`EntityViewDisplay::buildMultiple()` applies `$items->access('view')`). A component that
reimplemented field output would lose all of that.

## Solution docs
- `agent/components/field-display.md` — the `field_display` ComponentSource in depth: inputs, form, render path, and how to place/inspect it.

Documented from source, with `canvas` 1.10.1 and `canvas_field_component` 1.0.2 enabled and
verified on the running site (the `field_display.field_display` Component entity exists,
`active_version` present). Per the maintainer, the module's initial build was AI-assisted.
