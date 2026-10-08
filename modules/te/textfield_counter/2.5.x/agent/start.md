<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Textfield Counter — agent index

Adds five **field widgets** (extending core text widgets) that show a live character counter
and optionally enforce a max length. No global settings form (`configure` = null); everything
is configured per field on **Manage form display**, and stored on the entity-form-display
component's widget settings.

- **The five widgets, their field types, all settings keys, validation & where stored** →
  [configure/widgets.md](configure/widgets.md)
- **Build your own counter widget with `TextFieldCounterWidgetTrait`** →
  [extend/trait.md](extend/trait.md)

Key facts:
- Widget ids → field types: `string_textfield_with_counter` (string),
  `string_textarea_with_counter` (string_long), `text_textfield_with_counter` (text),
  `text_textarea_with_counter` (text_long), `text_textarea_with_summary_and_counter`
  (text_with_summary).
- Core settings: `maxlength` (**0 = counter disabled**), `counter_position` (`before`/`after`,
  default `after`), `js_prevent_submit` (default TRUE), `count_only_mode` (default FALSE),
  `count_html_characters` (default TRUE), `textcount_status_message` (tokens `@maxlength`,
  `@current_length`, `@remaining_count`). Textfield widgets add `use_field_maxlength`.
- Stored at `core.entity_form_display.<entity>.<bundle>.<mode>` →
  `content.<field>.type` + `content.<field>.settings.*`.
- Enforcement: server-side form error when over `maxlength`, **unless** `count_only_mode`.
  No permissions, no Drush, no config object of its own.
