<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Asymmetric Translation — agent index

Makes the Layout Builder override field (`layout_builder__layout`) **translatable**, so each
translation gets its own sections/blocks, and adds a *"Copy blocks into translation"* widget.
No settings form (`configure: null`), no permissions, no Drush, no plugin types.

- **Set it up: enable overrides, place the `layout_builder_at_copy` widget, `settings.php`
  flag, translatability checks** → [configure/setup.md](configure/setup.md)
- **What it overrides under the hood (hooks, section storage, service provider, cloning)** →
  [api/behavior.md](api/behavior.md)

Key facts:
- Depends on `layout_builder` **and** `content_translation`. Conflicts with
  `layout_builder_st` (symmetric translations) — never enable both.
- Only config it owns: the widget setting schema
  `field.widget.settings.layout_builder_at_copy` → `appearance`
  (`unchecked` | `checked` | `checked_hidden`).
- Widget plugin id: **`layout_builder_at_copy`**, for field type `layout_section`.
  It replaces core's `layout_builder_widget`, which the module actively rejects on the
  *Manage form display* form once the field is translatable.
- `settings.php` flag: `$settings['layout_builder_at_set_content_block_language_to_entity'] = FALSE;`
  disables auto-assigning the entity's langcode to new inline blocks (default TRUE).
