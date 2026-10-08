<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field formatter conditions (fico) — agent index

Attaches a "hide when…" condition to a field on *Manage display*. Conditions are
`FieldFormatterCondition` plugins whose `access()` sets `$build[$field]['#access'] = FALSE`.
Depends on **ds** (Display Suite). No config page (`configure` null), no permissions, no Drush,
no config schema. Display-only hiding — not a data-access mechanism.

- **Applying a condition on Manage display / DS fields, where settings are stored** →
  [configure/apply.md](configure/apply.md)
- **The `field_formatter_condition` plugin type, the built-in conditions, and writing your own** →
  [plugins/conditions.md](plugins/conditions.md)

Key facts:
- Storage: field component third-party settings `fico.fico` → `{condition: <id>, settings: {...}}`
  on `core.entity_view_display.*` (and DS field config).
- Render hook: `fico_entity_view_alter()` runs the plugin's `access()`.
- Plugin manager service: `plugin.manager.field_formatter_condition`; base
  `\Drupal\fico\Plugin\FieldFormatterConditionBase`; annotation `@FieldFormatterCondition`.
- Built-in condition ids: `hide_if_empty`, `hide_not_empty`, `hide_if_string`, `hide_no_string`,
  `hide_if_bool_check`, `hide_if_author`, `hide_not_author`, `hide_on_role`,
  `hide_link_when_title_is_empty`, `hide_on_pages`, and a datetime condition.
