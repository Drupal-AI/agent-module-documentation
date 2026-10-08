Required API replaces a field's simple "Required field" checkbox with a pluggable "required strategy", letting other modules decide dynamically (per entity, per context, per role, …) whether a field is required, and cleans up core's required-field validation errors accordingly.

---

The module defines a **Required plugin type** (manager `plugin.manager.required_api.required`,
plugins in `Plugin/Required`, attribute `#[Required]`). Each configurable field
(`field_config`) can pick a strategy on its *field settings* form: `required_api` alters
`field_config_edit_form`, hides the core `required` checkbox, and shows a radios list of
strategies plus the selected plugin's own options (AJAX-refreshed); the choice is stored as the
field's third-party setting `required_plugin` (+ `required_plugin_options`). At entity-form
render time `hook_form_alter` adds an `#after_build` that calls the plugin's
`isRequired($field, $entity)` and toggles the widget's `#required` flag live. A decorator on
core's `form_error_handler` service (`RequiredApiFormErrorHandler`) rebuilds the entity from
submitted values and strips "@name field is required." errors for fields a strategy says are
**not** required, so making a field optional via a strategy also removes the spurious core
error. Ships two strategies: `default` ("Core" — defers to the field's own required flag, the
system default set at `/admin/config/user-interface/required`) and `broken` (fallback that
treats the field as always required when a configured plugin is missing). A field with any
non-default strategy is forced `required = TRUE` on save (`hook_field_config_presave`) so core
still shows the marker; the strategy then relaxes it contextually. Contributed/custom modules
add their own strategies (e.g. "required for role X") by implementing a Required plugin.

---

- Make a field required only for users in a specific role (via a custom strategy plugin).
- Make a field required only on certain bundles or workflow states.
- Provide a unified API so several modules agree on whether a field is required.
- Swap a field between "core required" and a dynamic strategy from the field settings form.
- Set a site-wide default required strategy for all fields.
- Toggle a widget's required marker live as the edit form is built.
- Strip core's "field is required" error when a strategy has made the field optional.
- Keep the core required marker visible while relaxing enforcement contextually.
- Fall back gracefully (always-required) when a strategy's providing module is uninstalled.
- Warn admins (log + "Broken/missing strategy") when a field references a missing plugin.
- Implement conditional-required logic without hand-editing every widget's `#required`.
- Centralise required logic behind `RequiredManager::getInstance()` for reuse in code.
- Let a strategy add its own configuration UI to the field settings form.
- Support entity-reference and nested (`subform`) field paths when clearing errors.
- Build "required if another field is filled" behaviour as a plugin.
- Make default-value widgets never required (handled automatically).
- Query the effective plugin/strategy for a given field definition programmatically.
- Offer editors a choice of required strategies per field via radios.
- Enforce required-ness that depends on the entity being edited, not just static config.
- Migrate legacy per-field required rules into first-class plugins.
