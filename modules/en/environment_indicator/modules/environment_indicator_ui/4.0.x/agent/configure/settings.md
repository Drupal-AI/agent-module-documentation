# Edit the current environment (UI)

Form at `/admin/config/development/environment-indicator/current`
(route `environment_indicator_ui.settings`, permission
`administer environment indicator settings`).

`EnvironmentIndicatorUISettingsForm` edits the `environment_indicator.indicator` config with
three fields:
- `name` — the current environment label.
- `fg_color` — foreground/text color.
- `bg_color` — background color.

This writes the same config that `settings.php` overrides target
(`$config['environment_indicator.indicator']`). Note: if that config is overridden in
`settings.php`, the override wins at runtime and UI edits to those keys won't take effect —
use this form only when the current indicator is managed in config rather than code. For the
cross-environment switcher entities and global settings, see the parent module's
`configure/settings.md`.
