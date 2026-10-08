# Block, formatter, theme hook

## `mirador` theme hook (`islandora_mirador_theme`)

Variables: `iiif_manifest_url`, `mirador_view_id`, `thumbnail_navigation_position` (default `far-bottom`),
`window_config` (array), `workspace_config` (array). Template `templates/mirador.html.twig`.

`template_preprocess_mirador()` (in `.module`):
- Runs every `IslandoraMiradorPlugin` plugin's `windowConfigAlter()` against `window_config`.
- Reads `islandora_mirador.settings` (theme, palette, language, enabled plugins) and builds the viewer config.
- Emits `drupalSettings.mirador.viewers['#'<mirador_view_id>]` = `{id, selectedTheme, language, manifests, window,
  windows:[{manifestId, thumbnailNavigationPosition}], workspace, themes?}`.
- Adds cache tag `config:islandora_mirador.settings` (and `languages:language_interface` when language support is on).
- Attaches library `islandora_mirador/viewer` (depends on `islandora_mirador/mirador`).
- `js/mirador_viewer.js` `Drupal.behaviors.Mirador` calls `Mirador.viewer(values, window.miradorPlugins || {})`
  once per viewer id and stores instances at `Drupal.IslandoraMirador.instances['#<id>']`; `system` theme is
  resolved to the OS `prefers-color-scheme` at attach time.

## Override viewer options from a theme

```php
function mytheme_preprocess_mirador(&$variables) {
  $variables['window_config']['allowClose'] = FALSE;
  $variables['workspace_config']['allowNewWindows'] = FALSE;
}
```

## `mirador_block` Block plugin

`src/Plugin/Block/MiradorBlock.php` (`id: mirador_block`). Block config field `iiif_manifest_url` (token pattern,
node tokens). `build()` resolves the pattern with the current route's `node` param via the `token` service, sets
`#mirador_view_id = 'mirador_' . $node->id()`, and renders `#theme => 'mirador'`. Also accepts `window_config` /
`workspace_config` / `thumbnail_navigation_position` in its plugin configuration (see README for a minimal-UI
example built with `plugin.manager.block->createInstance('mirador_block', [...])`). Cache: contexts `route`;
tags `node:<id>` + `media_list`.

## `mirador_image` field formatter

`src/Plugin/Field/FieldFormatter/MiradorImageFormatter.php` (`id: mirador_image`, field types `image`, `file`).
For each referenced file it finds the referencing media (`islandora.utils` `getReferencingMedia`), gets its
`field_media_of` node, resolves `islandora_mirador.settings:iiif_manifest_url` with that node, and renders
`#theme => 'mirador'`. Requires the Islandora media/node graph to resolve a node from the file.
