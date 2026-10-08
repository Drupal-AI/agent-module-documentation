# Status Messages — agent index

Renders Drupal's status/warning/error messages as a floating top-right popup ("toast") that
auto-fades after a configurable time. One setting, one form, no dependencies.

- **The `status_message_time` setting, the form, and the permission** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config route: `status_messages.status_messages` → `/admin/config/user-interface/status-messages`,
  permission `administer status messages configuration`.
- Config object `status_messages.status_messages`, single key **`status_message_time`** in
  **milliseconds**: 5000, 10000, 15000, 20000, or 3600000 ("Never").
- No config schema and no default config shipped — `status_message_time` is unset until saved.
- Value is exposed to JS as `drupalSettings.statusMessages`; the popup library
  `status_messages/status-messages` is attached on every page.
