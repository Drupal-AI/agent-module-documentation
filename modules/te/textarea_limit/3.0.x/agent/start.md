<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Textarea Limit (textarea_limit) — agent index

Adds a live character counter ("You have N of M characters remaining.") to the
`string_textarea` and `text_textarea` field widgets. You enable it per widget on the
entity's **Manage form display** page (third-party settings), choosing either a fixed
per-widget limit or a shared global limit. Enforcement is CLIENT-SIDE ONLY (a jQuery
counter); nothing validates length server-side. Core-only, `^9 || ^10 || ^11`.

- **Set the shared global character limit** → [configure/global-limit.md](configure/global-limit.md)
- **Turn on the counter for a specific textarea widget** → [configure/widget.md](configure/widget.md)
- **Grant access to the settings form** → [permissions/permissions.md](permissions/permissions.md)
- **Override the counter markup / understand the library** → [theme/counter.md](theme/counter.md)

Key facts:
- Config object: `textarea_limit.settings`, single key `global_limit` (string, default `'1000'`). No config schema ships.
- Settings route: `textarea_limit.settings` → `/admin/config/content/textarea-limit` (form `\Drupal\textarea_limit\Form\LimitTextSettingsForm`).
- Permission: `administer textarea_limit`.
- Third-party settings namespace `textarea_limit`, keys `textarea_limit_char_limit` and `textarea_limit_use_global_limit` (constants in `\Drupal\textarea_limit\TextareaLimitConstants`).
- Applies only to widget plugin ids `string_textarea` and `text_textarea`.
- Hooks: `hook_element_info_alter`, `hook_field_widget_third_party_settings_form`, `hook_field_widget_settings_summary_alter`, `hook_field_widget_form_alter`, `hook_theme`.
- Pre-render callback: `\Drupal\textarea_limit\TextareaLimitCallbacks::limitPreRender` (TrustedCallbackInterface).
- Theme hook: `textarea_limit_remaining` (template `templates/textarea-limit-remaining.html.twig`).
- Library `textarea_limit/textarea_limit` (js + css); depends on `core/jquery` and `textarea_limit/jquery.limit` (an EXTERNAL remote script from googleapis storage).
- No drush, no services, no plugin types, no entities.
