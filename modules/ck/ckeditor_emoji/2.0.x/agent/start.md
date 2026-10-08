<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor(5) Emoji — agent index

Adds an **Emoji** button to the **CKEditor 5** toolbar. Pure JS plugin — **no** PHP, settings
form, configure route (`configure: null`), permissions, config schema, Drush, or Drupal plugin
types. Depends on core `ckeditor5`. Its only footprint is the toolbar button you add to a text
format's editor config.

- **Turn the Emoji button on for a text format / where that is stored** →
  [configure/toolbar.md](configure/toolbar.md)
- **What the button does at runtime (picker, categories, search, how emoji is inserted)** →
  [api/behavior.md](api/behavior.md)

Key facts:
- CKEditor5 plugin id (Drupal side): **`ckeditor_emoji_Emoji`**; CKEditor plugin: `emojiPlugin.Emoji`.
- Toolbar item name to add: **`Emoji`**.
- State lives in `editor.editor.<format>` → `settings.toolbar.items` (add `Emoji`).
- `elements: false` → inserts a plain Unicode emoji; **no** new HTML tags, so no filter/allowed-tag changes needed.
- CKEditor **5** only (successor to the CKEditor 4 "Emoji" module).
