Domain Alias Extras is a small utility add-on for Domain Alias that gives you an admin form to edit the list of named environments (e.g. local, staging, production) used when defining domain aliases.

---

Domain Alias Extras adds a single settings form, `DomainAliasExtrasSettingsForm` (a `ConfigFormBase` using `RedundantEditableConfigNamesTrait`), at `/admin/config/domain/domain_alias_extras` (route `domain_alias_extras.settings`, menu link under `domain.admin`). The form exposes one textarea, "Development environments", bound via `#config_target` to `domain_alias.settings:environments` — the config item owned by the base Domain Alias module — so the module does not define its own config or schema, it just edits Domain Alias's. A `#process` callback flattens the stored array into newline-separated text for display, and an `#element_validate` callback splits the textarea back into a trimmed, empty-filtered, re-indexed array, always prepending `default` if it is missing, before saving. The only other behavior is one hook implementation, `DomainAliasExtrasHooks::domainConfigUiDisallowedRoutesAlter()` (attribute `#[Hook('domain_config_ui_disallowed_routes_alter')]`, registered as a service in `domain_alias_extras.services.yml`, with a `#[LegacyHook]` shim in the `.module`), which adds `domain_alias_extras.settings` to Domain Config UI's disallowed-routes list so the environments setting stays a single global value rather than a per-domain override. Requires `domain:domain_alias`.

---

- Edit the list of environments available when defining domain aliases.
- Manage environment names like `local`, `staging`, and `production` from one textarea.
- Enter one environment per line in the "Development environments" field.
- Reach the form at `/admin/config/domain/domain_alias_extras` (route `domain_alias_extras.settings`).
- Open it from the Domain admin menu (link parented to `domain.admin`).
- Store the environment list in Domain Alias's own `domain_alias.settings:environments` config.
- Rely on the form to always keep `default` in the environment list.
- Have blank and whitespace-only lines trimmed and dropped automatically on save.
- Get the saved list re-indexed into a clean sequential YAML sequence.
- Keep the environments list a single global value, not a per-domain override.
- Prevent the settings route from being exposed by Domain Config UI's per-domain editor.
- Pair with Domain Alias to align alias definitions with your deployment environments.
- Use as a lightweight companion module with no permissions, plugins, or Drush commands of its own.
