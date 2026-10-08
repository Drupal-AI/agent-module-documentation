# CKeditor Responsive Plugin — agent index

A CKEditor 5 plugin that adds a "Responsive Area" toolbar button inserting responsive
column/grid `<div>` blocks. No server config of its own (`configure` → core
`filter.admin_overview`), no permissions, no schema, no Drush. Requires core `ckeditor5`.

- **Enabling it on a text format, allowed-tags requirements, the CSS classes** →
  [configure/setup.md](configure/setup.md)

Key facts:
- CKEditor 5 plugin id `responsiveAreaPlugin.ResponsiveArea`, toolbar item `responsiveArea`,
  declared in `ckeditor_responsive_plugin.ckeditor5.yml`; built JS in
  `js/build/responsiveAreaPlugin.js`.
- Declared elements: `<h2>`, `<div>`. Inserts column classes (`onecol`, `twocol`, …) and grid
  classes (`grid-1`, `grid-2`, …).
- Libraries: `ckeditor_responsive_plugin/responsivearea` (editor JS + `css/responsivearea.css`),
  `admin.responsivearea` (toolbar-config styling). Depends on `core/ckeditor5`.
- Config is done in core's text-format editor UI, not in this module.
