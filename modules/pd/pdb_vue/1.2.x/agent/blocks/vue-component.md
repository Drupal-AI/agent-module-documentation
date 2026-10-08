<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `vue_component` block plugin

`pdb_vue` does not require you to write PHP block plugins. It ships **one** derivative block plugin
and turns every discovered Vue component into a placeable block.

- Plugin id: `vue_component`
- Class: `\Drupal\pdb_vue\Plugin\Block\VueBlock` (extends `\Drupal\pdb\Plugin\Block\PdbBlock`)
- Deriver: `\Drupal\pdb_vue\Plugin\Derivative\VueBlockDeriver` (extends `PdbBlockDeriver`)

## Discovery → derivatives

1. The parent service `pdb.component_discovery` (`\Drupal\pdb\ComponentDiscovery`, extends core
   `ExtensionDiscovery`) scans the codebase for `*.info.yml` files whose `type: pdb`. Each such
   directory is a "component". Search paths are the whole install by default, or an explicit list
   from `Settings::get('pdb_search_dirs')` / a `PdbDiscoveryEvent` subscriber (both trusted config,
   not request input).
2. `pdb_vue_component_info_alter()` fills `$component->info['path']` with the component's own
   directory for every `presentation: vue` component that didn't hardcode a path.
3. `VueBlockDeriver::getDerivativeDefinitions()` creates one derivative per component, then
   `array_filter`s to keep only `info['presentation'] == 'vue'`. So a `vue_component:<machine_name>`
   block exists for each Vue component. Blocks are defined with `cache: ['max-age' => 0]`.
4. Demo gating: unless `development_mode` is on, the deriver removes a hardcoded demo list
   (`vue_example_1/2`, `vue_example_webpack`, `vue_spa_component`, `vue_todo`, `vue3_example_1/2`,
   `vue3_pinia_a/b`, `vue3_spa_component`, `vue3_vite`, plus the ng2/react demos). Turn on dev mode
   to place the shipped examples.

Place a Vue block like any block (Block Layout or Layout Builder). Its config form gains a
"Component Settings" fieldset auto-built from the component's `configuration:` info.yml keys
(handled by `PdbBlock::buildComponentSettingsForm()`); submitted values are stored as
`configuration['pdb_configuration']`.

## Two render modes (`VueBlock::build()`)

The behavior depends on `pdb_vue.settings:use_spa` **and** whether the component declares
`component: true`.

**Per-block instance (default, `use_spa` off, or component not `component: true`):**
```php
$build['#markup'] = VueMarkup::create(
  '<div class="' . $machine_name . '" id="' . $this->configuration['uuid'] . '">' . $template . '</div>'
);
```
- Emits a wrapper `<div class="machine-name" id="UUID">`. The component's JS (added via
  `add_js`) mounts a Vue app on that class/id.
- `$template` is the file contents of `info['path'] . '/' . info['template']` when the component's
  info.yml sets `template:` (e.g. `template.html`) — the developer-shipped markup for the app.
- `$this->configuration['uuid']` is a freshly generated UUID (set in `PdbBlock::build()`), giving
  each placed block a unique id so multiple placements don't collide.

**SPA component mode (`use_spa` on AND `component: true`):**
```php
$build['#allowed_tags'] = [$machine_name];
$build['#markup'] = '<' . $machine_name . $props_string . ' instance-id="' . $uuid . '"></' . $machine_name . '>';
```
- Emits the component's own custom-element tag (e.g. `<vue3-spa-component …></vue3-spa-component>`),
  which the single global Vue app (created by `vue3.spa-create`, mounted by `vue3.spa-init` on
  `spa_element`) resolves as a registered component. `#allowed_tags` restricts the markup to that
  one tag.
- `$props_string` comes from `buildPropertyString()`.

## How props/settings reach Vue

Two independent channels — see [../api/authoring-components.md](../api/authoring-components.md) for the authoring side:

- **HTML props (SPA mode only).** `buildPropertyString()` walks
  `configuration['pdb_configuration']` (the block instance's component-settings values). Each field
  name is converted camelCase→kebab-case (`convertKebabCase()`); each value is emitted as an
  attribute `field="value"`, or `:field="value"` (Vue `v-bind`) when the value `is_numeric`. Every
  value is passed through `\Drupal\Component\Utility\Html::escape()` before being placed in the
  attribute. Vue reads these as component `props`.
- **drupalSettings (both modes).** `PdbBlock::build()` writes the same per-instance settings to
  `drupalSettings.pdb.configuration[UUID]`, and any block context to `drupalSettings.pdb.contexts`.
  `VueBlock::attachSettings()` adds `drupalSettings.pdbVue.developmentMode` and (in SPA mode)
  `drupalSettings.pdbVue.spaElement`. All of drupalSettings is JSON-encoded by core. Component JS
  reads its own settings via `drupalSettings.pdb.configuration[this.instanceId]` (the block passes
  each SPA component an `instance-id` prop; per-block mode reads the wrapper's `id`).

`VueBlock::attachLibraries()` decides which Vue library to attach: `pdb_vue/vue3` or `pdb_vue/vue`
per the `version` setting (only if the component declared no inline `libraries`), merges the
component's own libraries, and appends `pdb_vue/<version>.spa-init` in SPA mode.

`\Drupal\pdb_vue\Render\VueMarkup` is a plain `MarkupInterface`/`MarkupTrait` passthrough used to
render the developer-provided wrapper+template markup.
