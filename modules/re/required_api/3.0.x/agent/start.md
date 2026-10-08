# Required API — agent index

Turns a field's "Required" checkbox into a pluggable **required strategy**. Other modules
supply strategies that decide `isRequired($field, $entity)` dynamically. No module
dependencies; PHP 8.1+. Config route `required_api.default_plugin`
(`/admin/config/user-interface/required`, perm `administer required settings`).

- **Choosing a strategy per field, the site default, config/third-party-setting keys, the
  form-error-handler decorator, and the `RequiredManager` service** →
  [configure/required.md](configure/required.md)
- **Implementing your own Required strategy plugin** → [plugins/required.md](plugins/required.md)

Key facts:
- Plugin type: manager `plugin.manager.required_api.required`, dir `Plugin/Required`,
  attribute `#[Required(id,label,description)]` (legacy annotation `Required` also supported),
  interface `RequiredPluginInterface`, base `RequiredBase`. Fallback plugin `Broken` (`broken`).
- Built-in strategy `default` (`RequiredDefault`, label "Core") defers to `$field->isRequired()`.
- Per-field storage: `field_config` third-party settings `required_api.required_plugin` +
  `required_api.required_plugin_options`. Site default: config `required_api.plugins:default_plugin`
  (install default `default`).
- `hook_field_config_presave` forces `required = TRUE` for any non-`default` strategy; the
  strategy then relaxes it at form build via an `#after_build` on the widget.
- Service `required_api.form_error_handler` **decorates** core `form_error_handler` to drop
  required-field errors for fields a strategy deems optional.
