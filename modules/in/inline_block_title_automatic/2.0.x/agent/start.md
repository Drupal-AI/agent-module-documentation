<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inline Block Title Automatic — agent index

Removes the **placement label ("title")** and **"Display title"** controls from `block_content`
blocks in Layout Builder, so authors never set a placement title. Zero-config: enabling the
module (with Layout Builder) is the whole setup. No route, config, permission, Drush, or plugin.

- **Which forms it alters, exactly what it changes, and how to observe/verify it** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Alters `layout_builder_add_block` and `layout_builder_update_block` forms via
  `hook_form_FORM_ID_alter()` → `\Drupal\inline_block_title_automatic\FormAlter::blockAddConfigureAlter()`.
- Applies to reusable block_content (`settings.provider['#value'] === 'block_content'`) and
  inline blocks (`settings.block_form['#block'] instanceof BlockContent`).
- Converts `settings.label` and `settings.label_display` to `#type => 'value'` (hidden);
  label defaults to `'Inline block'` if empty, `label_display` forced `FALSE`.
