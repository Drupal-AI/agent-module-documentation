# Media Library Block — agent index

One derivative block plugin (`media_library_block`) that yields **one block per media bundle**. Editors
pick a single media entity via the core Media Library form element and choose a view mode; the block
renders that media. Depends on `media`, `media_library`, and contrib `media_library_form_element`. No
config page (`configure` null), no permissions, no Drush, no config schema of its own.

- **The block plugin, its derivatives, config keys, access & dependency handling** →
  [configure/block.md](configure/block.md)

Key facts:
- Plugin id `media_library_block:<bundle>` (deriver = `MediaLibraryBlockDeriver`), category *Media*.
- Config: `media` (selected media id, string) and `view_mode` (default `default`).
- `build()` enforces per-entity `view` access before rendering via the media view builder.
