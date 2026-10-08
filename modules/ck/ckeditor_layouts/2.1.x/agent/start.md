# CKEditor Layouts — agent index

One CKEditor 5 plugin that inserts core **Layout API** layouts (multi-region `<div>` structures)
into WYSIWYG content. Depends on core `ckeditor5` + `layout_discovery`. No permissions, services,
Drush, hooks, or entities. Config = the plugin's `enabled_layouts` list, stored on the text
editor. `configure` route is the Text formats overview (`filter.admin_overview`).

- **Enable the toolbar button, the `enabled_layouts` setting, allowed-HTML / GHS requirements,
  using custom Layout API layouts, editor CSS** → [configure/editor.md](configure/editor.md)

Key facts:
- Plugin id `ckeditor_layouts_drupal_layouts`; JS plugin `drupalLayouts.InsertDrupalLayout`;
  toolbar item `insertDrupalLayout`; declared elements `<div>`, `<div class>`.
- Reads all `plugin.manager.core.layout` definitions (excludes `layout_builder_blank`), renders
  each layout template with all regions present + its icon, ships them as `drupalLayouts.layouts`.
- Auto-derives allowed tags from each layout's markup into CKEditor 5 General HTML Support
  (`htmlSupport.allow` / `allowEmpty`) so `<div class>` wrappers survive filtering.
- Config schema key `ckeditor5.plugin.ckeditor_layouts_drupal_layouts.enabled_layouts`
  (sequence of layout ids; must be non-empty; each validated against installed layout ids).
