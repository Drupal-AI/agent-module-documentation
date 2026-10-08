<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Override Inspector (COI) flags configuration form fields whose value is overridden (for example by `settings.php` or an environment) — adding a message, CSS classes, and optionally disabling or hiding the field so admins don't edit a value that won't take effect.

---

COI builds on `config_override_core_fields`, which tags core config-form elements with a
`#config['key']` hint (`config.object:key`). On every form, COI's `hook_form_alter`
(`CoiFormAlterations::hookFormAlter` → `alterTree`) walks the render array; for any element
carrying `#config['key']` (or the core WIP `#config_data_store['key']`) it splits the key,
loads that config, and calls `Config::hasOverrides($configKey)`. When an override exists it
acts according to `coi.settings`:
`override_behavior` = `disable` (disables the element and, if enabled, sets its default value
to the overridden value), `noaccess` (hides the element via `#access = FALSE`), or empty/none
(indicator only); `message.enabled`/`message.template` add a description built with the
`coi:active-value` and `coi:overridden-value` tokens; `overridden_value` controls whether the
real value is shown (and whether "secret" fields are exposed); `styling.selectors` adds
`config`, `config--overridden`, and `config--<bin>`/`config--<bin>--<key>` CSS classes
regardless of override state (with `styling.default` adding default CSS). COI also implements
`hook_module_implements_alter` to ensure its `form_alter` runs *after*
`config_override_core_fields`, defines the `coi:active-value`/`coi:overridden-value` tokens,
and provides the `coi_container` theme (`coi-container.html.twig`) that renders the override
message under the field. Settings live at `/admin/config/user-interface/coi` (route
`coi.settings`), gated by the `administer config override inspector` permission. Token module
is suggested to expose the token UI on the settings form.

---

- Warn admins that a field (e.g. site name, cache max-age) is pinned by a `settings.php` override.
- Disable overridden config fields so an edit that would be silently ignored can't be made.
- Hide overridden fields entirely from the settings form (`noaccess` behavior).
- Show the actual overridden value next to a field so admins know what is really in effect.
- Add a custom override message like "This field is overridden by environment specific configuration."
- Distinguish per-environment overrides (dev/stage/prod) visually in the admin UI.
- Add CSS hooks (`config--overridden`) to style overridden fields site-wide.
- Mark all config-bound fields with `config--<object>--<key>` classes for theming or testing.
- Keep secret overridden values masked while still flagging the field (secrets off).
- Optionally reveal secret overridden values to trusted admins (secrets on).
- Use the `coi:active-value` and `coi:overridden-value` tokens in the override message.
- Prevent confusion where changing a setting in the UI has no effect due to a code override.
- Audit which core settings are controlled by configuration overrides vs the database.
- Provide a clear signal during deployments that certain config is environment-managed.
- Configure indicator-only mode (no disabling) to inform without blocking edits.
- Toggle whether the overridden value is injected as the element's default value.
- Restrict who can change COI behavior via the `administer config override inspector` permission.
- Theme the override notice by overriding `coi-container.html.twig`.
- Pair with `config_override_core_fields` to cover the standard core system settings forms.
- Extend coverage to custom forms by adding `#config['key']` hints your module sets.
- Help onboarding admins understand why a production setting appears "locked".
- Reduce support tickets caused by overridden settings appearing editable.
- Surface overrides for performance, cron, logging, user, search, and views settings forms.
- Give config-management workflows a UI-level view of active overrides.
