# Menu Bootstrap Icon — agent index

Bootstrap 5 icon picker for menu links, Link fields, File fields, and CKEditor 5. Depends on
`menu_ui`. Settings page `admin/config/content/menu_bootstrap_icon`
(`configure` = `menu_bootstrap_icon.settings`, requires `administer site configuration`).
No own permissions, no Drush. Config schema present. Ships ~2000 icons under `icons/`.

- **Settings page: `use_cdn`, the "Generate" search-index build, YAML editor, CDN vs theme
  assets, theme `.info.yml` requirement for menus** → [configure/settings.md](configure/settings.md)
- **Menu-link icons, per-item role restriction, and the Link/File field widget & formatters** →
  [configure/icons-fields.md](configure/icons-fields.md)
- **CKEditor 5 Bootstrap Icons toolbar plugin** → [plugins/ckeditor.md](plugins/ckeditor.md)

Key facts:
- Config `menu_bootstrap_icon.settings`: `use_cdn` (bool), plus runtime keys `search_list`
  and `menu_link_icons` (per menu-link icon map, keyed by link id with dots→underscores).
- Field plugins: widget `bootstrap_icon_link` (link), formatters `bootstrap_icon_link` (link)
  and `file_bootstrap_icon` (file). CKEditor5 plugin `bootstrapIcons.BootstrapIcons`.
- Icon search index cached at `js/iconSearch.json`; rebuilt from `icons/*.md` by the settings
  form's Generate button (`BootstrapIconSearch::loadIcons()`).
