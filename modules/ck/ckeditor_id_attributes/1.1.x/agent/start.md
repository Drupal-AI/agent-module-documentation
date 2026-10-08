# CKEditor5 ID Attributes — agent index

Adds a CKEditor 5 toolbar button to set the HTML `id` attribute on elements (in-page anchors /
stable IDs). Depends on core `ckeditor5`. No global config page, no permissions, no Drush; a
single configurable CKEditor 5 plugin, configured per text format.

- **Enabling the button on a text format, the `show_id_labels` option, allowed-`id` filtering,
  and how config maps to the JS plugin** → [configure/plugin.md](configure/plugin.md)

Key facts:
- CKEditor 5 plugin def `ckeditor_id_attributes_idAttributes` (`*.ckeditor5.yml`): JS plugins
  `idAttributes.IdAttributes` + `idAttributesLabels.IdAttributesLabels`, toolbar item
  `idAttributes`, `elements: <$any-html5-element id>` (registers `id` on any allowed element).
- Drupal plugin class `IdAttributes` extends `CKEditor5PluginDefault` implements
  `CKEditor5PluginConfigurableInterface`; one setting `show_id_labels` (bool, default FALSE).
- `getDynamicPluginConfig()` sets `idAttributes.showLabels` → JS reads
  `editor.config.get('idAttributes.showLabels')`.
- Config schema: `ckeditor5.plugin.ckeditor_id_attributes_idAttributes` → `show_id_labels`.
  Settings live inside the editor config entity (`editor.editor.<format>`).
- Libraries: `ckeditor_id_attributes/editor` (built JS in `js/build/`) and `.../admin`.
