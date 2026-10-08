<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Authoring a Vue component block

A Vue block is a folder shipped by any module or theme (typically under a module's `examples/` or
a theme subdir) containing an info file and JS. No PHP is written. Discovery is automatic once the
info file declares `type: pdb`.

## info.yml contract

```yaml
name: My Widget                 # admin label of the derived block
machine_name: my-widget         # kebab-case; used as the DOM class/id and SPA custom-element tag
type: pdb                       # REQUIRED — marks this dir as a PDB component
presentation: vue               # REQUIRED — routes it to pdb_vue's deriver
core_version_requirement: ^9 || ^10 || ^11
category: Vue                   # optional block category
add_js:                         # component assets → become a per-component asset library
  footer:
    'my-widget.js': {}
add_css:
  header:
    component:
      'my-widget.css': {}
template: template.html         # optional; raw markup injected into the wrapper div (non-SPA mode)
component: true                 # optional; opt into SPA custom-element rendering (needs use_spa on)
configuration:                  # optional; each key becomes a block-config field AND a Vue prop
  textField:
    type: textfield
    default_value: 'I am a default value'
libraries:                      # optional; extra registered libraries to attach (e.g. state mgmt)
  - pdb_vue/vue3.pinia
```

Keys consumed by the code:

| Key | Read by | Purpose |
|---|---|---|
| `type: pdb` | `ComponentDiscovery::scan()` | Makes the directory discoverable as a component. |
| `presentation: vue` | `VueBlockDeriver` / `pdb_vue_library_info_alter` | Claims the component for pdb_vue; enables path + library handling. |
| `machine_name` | `VueBlock::build()` | Wrapper `class`/`id` (per-block mode) and custom-element tag (SPA mode). |
| `add_js` / `add_css` | parent PDB library builder | Turned into `pdb/<machine_name>/header` + `/footer` libraries and attached. |
| `template` | `VueBlock::build()` | File whose contents fill the wrapper `<div>` in per-block mode. |
| `component: true` | `VueBlock::build()` / `attachLibraries` | Renders as a registered component under the global SPA app (with `use_spa`). |
| `configuration` | `PdbBlock::buildComponentSettingsForm()` | Auto-builds Form-API fields on the block config form; values become props + `drupalSettings.pdb.configuration`. |
| `libraries` | `pdb_vue_library_info_alter` | Merged into the component library's dependencies. |

## JS patterns

Per-block instance (one app per placement; only the first placement of a non-component block
renders — use a component or SPA mode for multiples):
```js
Vue.createApp({
  data: () => ({ message: 'Hello Vue!' }),
  template: `<div class="test">{{ message }}</div>`,
}).mount('.my-widget');   // matches the wrapper div's class
```

SPA component (`component: true`, `use_spa` on) — register on the pre-created `vueApp`:
```js
vueApp.component('my-widget', {
  props: { textField: { type: String }, instanceId: { type: String } },
  template: '<div>{{ message }}</div>',
  data() { return { message: 'Hi' }; },
  mounted() { if (this.textField) this.message = this.textField; },
});
```
- Each `configuration:` key arrives as a camelCase prop (`textField`). An `instance-id` attribute
  is always supplied → declare `instanceId` to receive it.
- Raw settings for a placement are available at `drupalSettings.pdb.configuration[this.instanceId]`
  (SPA) or `drupalSettings.pdb.configuration[this.$el.parentElement.getAttribute('id')]` (per-block).

## State sharing across blocks

- **Pinia** (recommended, Vue 3): add `libraries: [pdb_vue/vue3.pinia]`, ship a store file, load it
  before the component JS. See the `vue3_pinia_a` + `vue3_pinia_b` example pair (two separately
  placed blocks sharing one store).
- **Vuex** (`pdb_vue/vue.vuex`, `pdb_vue/vue3.vuex`) for legacy/Vue 2.
- A global event bus (Reactivity API / mitt) for simple cases.

## Build toolchains

- **Vite** (`vue3_vite` example): set `base` to the component's deployed path, disable file hashing,
  externalize Vue, and add the bundle as `type: module` (`add_js.footer.'dist/index.js': { attributes: { type: 'module' } }`).
- **Vue CLI / webpack** (`vue_example_webpack`, Vue 2): externalize Vue (`externals: { vue: 'Vue' }`)
  so a second copy is not bundled.

## Shipped example components (submodules)

`vue3_example_1`, `vue3_example_2` (template + multi-render), `vue3_pinia_a`, `vue3_pinia_b`,
`vue3_spa_component`, `vue3_vite`, and the Vue 2 set `vue_example_1`, `vue_example_2`,
`vue_example_webpack`, `vue_spa_component`, `vue_todo`. They are hidden from the block list unless
`development_mode` is enabled. Vue 2 reached end of life at the end of 2023 — start from the
`vue3_*` examples.
