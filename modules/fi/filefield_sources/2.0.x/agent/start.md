# File Field Sources — agent index

Adds extra "sources" (remote URL, reference existing, server attach, IMCE browser, clipboard) to
File/Image field widgets, beside core's Upload. Enabled **per widget** and stored as a third-party
setting on the `entity_form_display`. No settings page (`configure: null`), no Drush, no permissions.
Defines the `FilefieldSource` plugin type; routes are contributed dynamically by plugins.

- **Enable sources on a widget; the third-party-setting config structure; per-source settings** →
  [configure/sources.md](configure/sources.md)
- **The `FilefieldSource` plugin type, the 5 built-in sources, how to write your own** →
  [plugins/sources.md](plugins/sources.md)
- **`hook_filefield_sources_widgets()` and `hook_filefield_sources_sources_alter()`** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Supported widgets by default: `file_generic`, `image_image` (from `hook_filefield_sources_widgets()`).
- Setting path: `core.entity_form_display.<entity>.<bundle>.<mode>` →
  `content.<field>.third_party_settings.filefield_sources.filefield_sources` with `sources`
  (map of enabled source ids, e.g. `{remote: remote, upload: upload}`) plus per-source groups
  `source_attach` / `source_reference` / `source_remote` (and others).
- Built-in source ids: `upload` (core default), `remote`, `reference`, `attach`, `imce`, `clipboard`.
- `upload` is auto-enabled whenever any source is set (`_filefield_sources_enabled()`).
- `imce` only appears when the IMCE module is installed and `Imce::access()` passes.
