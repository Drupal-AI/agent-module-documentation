<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks

Documented in `js_component.api.php` plus the manager's alter hook. All are procedural
`hook_*` implementations placed in a `MODULE.module` file.

## `hook_js_component_form_alter(array &$form, array $configuration, FormStateInterface $form_state)`
Alter the JS component settings subform on a component block, for **all** components. `$form` is the
`js_component` subform, `$configuration` the current stored component values. Add/modify elements as
usual Form API.

## `hook_js_component_<PLUGIN_ID>_form_alter(&$form, $configuration, $form_state)`
Same as above but scoped to one component. `<PLUGIN_ID>` is the component plugin id with dashes
converted to underscores. The block invokes both alter names together
(`js_component_form`, `js_component_<id>_form`).

## `hook_js_component_form_submit(array &$values, FormStateInterface $form_state)`
React to a component settings-form submission. Mutate `$values` (the values persisted into block
config) — e.g. copy an extra `$form_state` value into the stored configuration. Invoked via
`invokeAll` for every component block submit.

## `hook_js_component_info_alter(array &$definitions)`
Standard plugin-manager alter (registered via `alterInfo(['js_component_info'])`). Alter the
discovered component definitions after YAML discovery — change labels, settings, libraries, etc.

## Related (not a `js_component` hook, but relevant)
- The module implements `hook_library_info_build()` and `hook_theme()` itself to turn component
  `libraries`/`template` into real libraries and theme hooks — you do not implement these for a
  component; just declare `libraries:`/`template:` in the YAML.
