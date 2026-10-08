<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views highlight past events (views_highlight_past_events) — agent index

**Client-side highlights Views rows/fields whose date is in the past.**

- **Version:** 1.0.x (release 1.0.1)
- **Core:** >=9  ·  **Depends:** `drupal:views`
- **No routes / permissions / config entities.** Configured per date field inside the Views UI.
- **Hooks:** `hook_form_views_ui_config_item_form_alter` (adds the "Highlight past events" fieldset to date fields), `hook_views_pre_render` (passes timestamps + colour/class/selector to `drupalSettings` and attaches the JS library), `hook_help`.
- **Storage:** Views third-party settings under `views_highlight_past_events` (highlight_type, highlight_enabled, highlight_color, custom_class, recalculation_interval, display_id, field_id).
- **Library:** `views_highlight_past_events/views_highlight_past_events` (core/drupal, drupalSettings, once).

**Security:** No server endpoints; admin-only Views UI configuration. User-entered colour/class/interval are `Xss::filter()`-ed before reaching drupalSettings, and the CSS-class field is regex-validated.
