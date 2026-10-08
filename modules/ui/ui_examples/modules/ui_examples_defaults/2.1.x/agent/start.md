# UI Examples Defaults — agent index

Submodule of **ui_examples**. Ships baseline example pages for standard Drupal elements so the
Examples library has content out of the box. Pure YAML examples; no PHP logic, routes,
permissions, config, or Drush.

Parent module docs: [../../../../2.1.x/agent/start.md](../../../../2.1.x/agent/start.md)

Key facts:
- Depends on `ui_examples`.
- Provides two examples (category "Core") via `ui_examples/*.ui_examples.yml`:
  - `normalize` — standard HTML elements (headings, lists, links, tables, text formatting, alignment).
  - `status_messages` — Drupal `status_messages` theme with error/warning/status samples.
- Both surface at `/admin/appearance/ui/examples` (behind `access_ui_examples_library`).
- For the example YAML format and rendering, see the parent's [plugins/examples.md](../../../../2.1.x/agent/plugins/examples.md).
