# ckeditor5_plugin_pack — agent start

Umbrella/base module for a pack of free CKEditor 5 plugins. Base provides shared plumbing +
one "Drupal powered by" plugin; each feature is a separate submodule you enable and add to a
text format's toolbar. Depends on core `editor` + `ckeditor5`. Config UI: **Admin → Config →
CKEditor 5 Plugin Pack** (`/admin/config/ckeditor5-plugin-pack`, route
`ckeditor5_plugin_pack.settings`).

- Base settings (DLL location, block CDN) → [configure/settings.md](configure/settings.md)
- What each submodule adds + how to enable a plugin → [plugins/overview.md](plugins/overview.md)
