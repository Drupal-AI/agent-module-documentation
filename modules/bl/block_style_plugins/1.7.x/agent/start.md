# Block Style Plugins — agent index

API module: add style config (extra fields → CSS classes / template suggestions) to the block config form via
a `BlockStyle` plugin. No admin UI (`configure` null), no permissions, no Drush. Depends on core `block`,
`block_content`. Values are stored as block third-party settings under `block_style_plugins`.

- **Define a BlockStyle plugin (YAML file or PHP class), include/exclude, classes, templates** → [plugins/block-style.md](plugins/block-style.md)

Key facts:
- Plugin type `block_style`: manager service `plugin.manager.block_style.processor` (`BlockStyleManager`,
  discovers `Plugin/BlockStyle` classes + `*.blockstyle.yml` files in modules AND themes), annotation
  `@BlockStyle` (id, label, include[], exclude[]), base class `BlockStyleBase`, interface `BlockStyleInterface`.
- Hooks used: `hook_form_block_form_alter` (inject fields), `hook_preprocess_block` (apply classes),
  `hook_theme_suggestions_block_alter` (template suggestions), `hook_themes_uninstalled` (cache clear).
- Storage: `$block->getThirdPartySetting('block_style_plugins', <plugin_id>)`; schema
  `block.settings.block_style_plugins` (sequence of type `ignore`).
- No config entities, no settings form. Styling per block instance is done on the normal block placement form.
