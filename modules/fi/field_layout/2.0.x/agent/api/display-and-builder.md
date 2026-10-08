<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Layout — display classes, builder, form trait, hooks (API)

## Entity display classes

`hook_entity_type_alter` (`FieldLayoutHooks::entityTypeAlter`) reassigns:

- `entity_view_display` → `Drupal\field_layout\Entity\FieldLayoutEntityViewDisplay`
  (extends core `EntityViewDisplay`).
- `entity_form_display` → `Drupal\field_layout\Entity\FieldLayoutEntityFormDisplay`
  (extends core `EntityFormDisplay`).

Both implement `EntityDisplayWithLayoutInterface` (`src/Display/`) and are otherwise empty — all
behavior comes from `FieldLayoutEntityDisplayTrait` (`src/Entity/`).

## `EntityDisplayWithLayoutInterface` / `FieldLayoutEntityDisplayTrait` API

Methods usable from update hooks, migrations, or display-aware code:

- `getLayoutId()` → reads third-party setting `field_layout.id`.
- `getLayoutSettings()` → reads `field_layout.settings` (default `[]`).
- `getLayout()` → instantiates the layout plugin (`plugin.manager.core.layout`) with current
  settings; returns a `LayoutInterface`.
- `setLayoutId($layout_id, array $layout_settings = [])` → when the ID changes, remaps any field
  component whose `region` is not in the new layout to the new layout's **default region**
  (`getDefaultRegion()`); then stores `id` and the plugin's normalized `getConfiguration()` as
  `settings`. Returns `$this`.
- `setLayout(LayoutInterface $layout)` → convenience wrapper over `setLayoutId()`.
- `ensureLayout($default_layout_id = 'layout_onecol')` → sets a default layout if none is set.
- `getDefaultRegion()` → the default region of the current layout definition.
- `getLayoutDefinition($layout_id)` / `doGetLayout()` → protected helpers over the core layout
  plugin manager.

Lifecycle overrides in the trait:

- `init()` calls `ensureLayout()` before `parent::init()`, so every loaded display has a layout.
- `preSave()` re-normalizes plugin config (`setLayout($this->getLayout())`) when a layout is set.
- `calculateDependencies()` adds the layout plugin's dependencies (`calculatePluginDependencies`),
  guarded for uninstall when no layout ID exists. This is why exported displays gain
  `layout_discovery` (and any layout-providing module) as a dependency.

Comments in the trait note these are stand-ins until layouts stop being third-party settings and
become a real plugin collection.

## `FieldLayoutBuilder` (`src/FieldLayoutBuilder.php`)

`ContainerInjectionInterface` helper (not a registered service; instantiated via
`\Drupal::classResolver(FieldLayoutBuilder::class)`), constructed with
`plugin.manager.core.layout` and `entity_field.manager`.

- `buildView(array &$build, $display)` — gets the layout definition (`getDefinition($id, FALSE)`,
  so a missing layout is tolerated). Builds region buckets keyed by
  `getRegionNames()`, moves each configurable field present in `$build` from the top level into
  its region bucket, then sets `$build['_field_layout'] = $display->getLayout()->build($regions)`.
  Fields in regions the layout does not define are left where they are (custom regions ignored).
- `buildForm(array &$build, $display)` — instead of moving elements, sets each field's `#group`
  to the region (respecting an existing `#group` and `$build['#parents']`), and adds a `_field_layout`
  section pre-seeded with core's `processGroup` / `preRenderGroup`. This preserves the form tree
  so `hook_form_alter` implementations still see fields in place.
- `getFields()` — returns display components that are (a) configurable for the given context
  (`isDisplayConfigurable('view'|'form')`), (b) not extra fields, and (c) present in `$build`.

## Form integration (`FieldLayoutEntityDisplayFormTrait`, `src/Form/`)

Used by `FieldLayoutEntityViewDisplayEditForm` and `FieldLayoutEntityFormDisplayEditForm` (both
`@internal`, each extending the Field UI base form and injecting `plugin.manager.core.layout`).

- `getRegions()` — overrides Field UI to return the current layout's regions (label + "No field
  is displayed." message) plus a `hidden`/Disabled region.
- `form()` — adds a `field_layouts` details element containing: a `field_layout` `<select>`
  (`getLayoutOptions()`, AJAX `::settingsAjax`, `trigger_as` a hidden "Change layout" submit), a
  `settings_wrapper` container (`#id` `field-layout-settings-wrapper`, `#tree`), the layout icon,
  and — if the layout plugin is a `PluginFormInterface` — its `buildConfigurationForm()` rendered
  in a `SubformState`.
- `getLayout()` — resolves the layout plugin from `field_layout` form value (falling back to the
  stored ID); caches it in `$form_state->get('layout_plugin')`.
- `settingsAjax()` / `settingsAjaxSubmit()` — AJAX refresh of the settings wrapper (non-JS path
  rebuilds the form).
- `validateForm()` / `submitForm()` — delegate to the layout plugin's
  `validateConfigurationForm()` / `submitConfigurationForm()` via `SubformState`, then
  `$entity->setLayout($layout_plugin)`.

## Hooks (`src/Hook/FieldLayoutHooks.php`, `#[Hook]` attributes)

- `help` — help text for `help.page.field_layout`.
- `entity_type_alter` — swaps display entity classes; swaps display edit forms **only when
  `field_ui` is installed**.
- `entity_view_alter` — routes `EntityDisplayWithLayoutInterface` displays through
  `FieldLayoutBuilder::buildView()`.
- `form_alter` — for `ContentEntityFormInterface` forms whose form display is a layout display,
  runs `FieldLayoutBuilder::buildForm()`.
- `modules_installed` — Layout Builder conversion (see `config/layout-settings.md`).

`field_layout.services.yml` sets `field_layout.skip_procedural_hook_scan: true` (all hooks are
OOP, no `.module` hook functions).
