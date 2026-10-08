# Islandora Mirador — agent index

Embeds the [Mirador](https://projectmirador.org) IIIF viewer as a Drupal block (`mirador_block`) and
field formatter (`mirador_image`). Both render the `mirador` theme hook against a IIIF manifest URL
(a node-token pattern). Config UI at `/admin/config/media/mirador` (perm `administer site configuration`,
route `islandora_mirador.miradorconfig`). Depends on `islandora`, `islandora_iiif`, `block`, `token`.
No permissions of its own, no Drush. Provides a config schema and one plugin type.

- **Settings form: all config keys, library remote-vs-local, theme/palette, manifest token URL** →
  [configure/settings.md](configure/settings.md)
- **The `IslandoraMiradorPlugin` plugin type (`windowConfigAlter`), the two shipped plugins** →
  [plugins/mirador-plugin.md](plugins/mirador-plugin.md)
- **The block, `mirador_image` formatter, the `mirador` theme hook & `hook_preprocess_mirador` overrides,
  drupalSettings shape** → [theming/block-and-template.md](theming/block-and-template.md)

Key facts:
- Config object `islandora_mirador.settings`; default `iiif_manifest_url` = `[node:url:unaliased:absolute]/manifest`.
- Library `islandora_mirador/mirador` loads `islandora/mirador-integration-islandora@0.2.3/main.js` from jsDelivr
  CDN by default; `hook_library_info_alter` swaps to `/libraries/mirador/dist/main.js` when installation type = `local`.
- Enabled plugins are compiled INTO the Mirador build; the checkboxes only toggle their window config, they do
  not add code.
- Viewer config reaches the browser as `drupalSettings.mirador.viewers['#<id>']`; `js/mirador_viewer.js` calls
  `Mirador.viewer()`.
