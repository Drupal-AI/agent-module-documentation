# The IndentBlock CKEditor 5 plugin

The module does **not define a new Drupal plugin type**; it provides one CKEditor 5 plugin
(consuming core's `ckeditor5` plugin type). Definition lives in
`ckeditor_indentblock.ckeditor5.yml`, class in
`src/Plugin/CKEditor5Plugin/IndentBlock.php`.

## Identity

| Thing | Value |
|---|---|
| CKEditor 5 plugin id (Drupal) | `ckeditor_indentblock_indent` |
| CKEditor 5 JS plugin used | `indent.IndentBlock` |
| Toolbar item(s) | **none of its own** — reuses core `indent` / `outdent` (from `ckeditor5_indent`) |
| Drupal label | `Indent block` |
| Enabling condition | `plugins: [ckeditor5_indent]` (i.e. Indent/Outdent must be in the toolbar) |
| Provided elements | `<p class="Indent*">` (only while enabled) |
| Settings key | `settings.plugins.ckeditor_indentblock_indent` on `editor.editor.<format>` |
| Setting | `enable` (boolean, default `TRUE`) |
| CSS classes applied | `Indent1` … `Indent10` |

## How it works

- The YAML statically configures CKEditor 5's `indentBlock` feature to use ten CSS classes
  (`Indent1`–`Indent10`) instead of the default inline `margin` offset.
- The PHP class implements `CKEditor5PluginConfigurableInterface` (the Enable checkbox) and
  `CKEditor5PluginElementsSubsetInterface`.
  - `getDynamicPluginConfig()` — when `enable` is FALSE it sets `indentBlock.classes = []`
    and `indentBlock.offset = 0`, disabling paragraph indentation without reverting to inline
    styles.
  - `getElementsSubset()` — returns `['<p class="Indent*">']` when enabled, else `['false']`.
- Because the plugin has no button and its `conditions.plugins` require `ckeditor5_indent`,
  it silently activates once Indent/Outdent are present; it shares those buttons for both
  list and block indentation.
- `ckeditor_indentblock.module` attaches the `ckeditor_indentblock/indentblock` CSS library
  to every page (`hook_page_attachments`) so the `Indent*` classes render on the front end.

There are no services, hooks-for-others, Drush commands, or permissions. To change indent
depth or width, override the `.Indent1`…`.Indent10` rules from
`css/plugins/indentblock/ckeditor.indentblock.css` in your theme.
