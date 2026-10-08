# Gutenberg Content Embed — agent index

Adds Gutenberg editor blocks to embed existing Drupal nodes (rendered in a chosen view mode) into
Gutenberg pages. Depends on the `gutenberg` module. Config is per-content-type (no standalone page);
`configure` is null.

- **Per-bundle allowed content/view-mode config, the JSON routes, the block processor** →
  [configure/settings.md](configure/settings.md)
- **The editor endpoints and the block processor contract for custom code** →
  [api/endpoints.md](api/endpoints.md)

Key facts:
- Routes (both `_permission: use gutenberg`, `_format: json`):
  `/editor/search-content/{type}/{search}` (title CONTAINS, published, access-checked) and
  `/editor/content/load/{nid}/{viewmode}` (renders node HTML after `access('view')`).
- Front-end render: service `gutenberg_content_embed.block_processor_drupal_content`
  (`DrupalContentProcessor`, tag `gutenberg_block_processor` priority 50) renders `attrs.nodeId` in
  `attrs.viewMode` (default `default`) via the view builder, gated by `access('view')`.
- Config `gutenberg_content_embed.settings:allowed_content_embed` — per bundle: `allowed_view_modes`,
  `width_control`. Edited on the node type's **Gutenberg experience → Allowed Content** fieldset.
- Editor assets injected into Gutenberg's `edit-node` library via `hook_library_info_alter`.
- No permissions of its own; no Drush; no plugin types.
