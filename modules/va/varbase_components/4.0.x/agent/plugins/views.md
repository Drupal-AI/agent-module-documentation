<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views SDC plugins: style + exposed form

Source: `src/Plugin/views/style/ComponentsViewsStyle.php`,
`src/Plugin/views/exposed_form/ComponentsExposedForm.php`,
`config/schema/varbase_components.schema.yml`. Both inject `@plugin.manager.sdc`
(`ComponentPluginManager`) via `create()`. These are Views **plugins**, not new plugin types.

## Style plugin: `components_views_style`
`#[ViewsStyle(id: "components_views_style", title: "Component", theme: "views_view_unformatted",
display_types: ["normal"])]`, extends `StylePluginBase`. `usesRowPlugin = TRUE`,
`usesGrouping = FALSE`, `usesOptions = TRUE`. Renders a view's rows inside a chosen SDC slot.

Options (`defineOptions()`): `component_id` (''), `rows_slot` (''), `prop_mappings` ([]). Matching schema
`views.style.components_views_style` = `component_id` (string), `rows_slot` (string), `prop_mappings`
(sequence of strings).

Options form (`buildOptionsForm()`):
- `component_id` select — `getComponentOptions()` lists SDC components that BOTH declare
  `use_in_views: true` in their definition AND have a `rows` slot (`asort`ed). Required. `#ajax` refreshes
  the slot/prop section on change (`ajaxRefreshSlots()`).
- `rows_slot` select — slot titles from the chosen component's `metadata->slots`.
- `prop_mappings` fieldset — one element per prop from the component schema
  (`metadata->schema['properties']`). Enum props render a select (labels from `getEnumOptions()`, which
  humanizes values and applies `meta:enum` overrides); otherwise the widget type comes from
  `getFormTypeForProp()` (boolean→checkbox, number/integer→number, array/object→textarea,
  else textfield). Array/object props note "comma-separated values or JSON".

`render()`:
- Returns `[]` when no `component_id`.
- Calls `parent::render()`, merges the row plugin's `#rows`.
- Slot = configured `rows_slot`, or `getFirstSlotName()` (first slot in metadata). If the component has
  no slots, adds a warning message and returns the default render.
- Builds `['#type' => 'component', '#component' => $component_id, '#slots' => [$slot => $rows]]`.
- Non-empty `prop_mappings` (after filtering out '' / null) are passed as `#props` via
  `convertPropTypes()`, which casts each value to the prop's schema type (`boolean`→bool,
  `integer`→int, `number`→float, `array`→`stringToArray()` JSON/CSV, `object`→`stringToObject()` JSON),
  falling back to the prop `default` when empty.

## Exposed-form plugin: `components_exposed_form`
`#[ViewsExposedForm(id: 'components_exposed_form', title: "Component")]`, extends
`ExposedFormPluginBase`. Renders the view's exposed filter form inside an SDC's `filters` slot
(`FILTERS_SLOT = 'filters'`).

Options: `component_id` ('') and `reset_button_always_show` (FALSE). Schema
`views.exposed_form.components_exposed_form` = `component_id` (string).

- `buildOptionsForm()` — required `component_id` select from `getComponentOptions()` (here: any component
  whose definition has `use_in_views` truthy, grouped by `provider`; no slot requirement), plus a
  `reset_button_always_show` checkbox (visible only when the view's reset button is enabled).
- `exposedFormAlter()` — when `reset_button_always_show` is set, forces `#access = TRUE` on the reset
  action (BEF-style parity: core otherwise hides reset with no input).
- `renderExposedForm($block)` — returns the plain form unchanged if there is no `component_id`, the form
  is empty, or the plugin manager has no definition for the ID (so the view keeps working while a theme
  is being wired up); otherwise wraps it as
  `['#type' => 'component', '#component' => $component_id, '#slots' => ['filters' => $form]]`.

## Notes for a site builder
- Only components declaring `use_in_views: true` appear in either selector (and the style additionally
  requires a `rows` slot). Add that flag to an SDC's `*.component.yml` to expose it here.
- Props/slots are read live from the SDC metadata via `ComponentPluginManager::find()`/
  `getDefinitions()`; missing/broken components are skipped rather than fatal.
