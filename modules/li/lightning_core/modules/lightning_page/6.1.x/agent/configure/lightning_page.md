# Configure — Basic Page (lightning_page)

No settings form (`configure: null`). Everything is shipped config plus conditional
install logic. Manage the resulting type at `/admin/structure/types/manage/page`.

## Installed unconditionally (`config/install`)
- `node.type.page` — "Basic page", `new_revision: true`, `preview_mode: 1`,
  `display_submitted: false`, not promoted.
- `field.field.node.page.body` — Body field.
- Default + teaser view displays, and the default form display.

## Installed only when the dependency is present (`config/optional`)
- **Pathauto** → `pathauto.pattern.page` = `[node:title]` for the `page` bundle.
- **Metatag** → `field.field.node.page.field_meta_tags`; `hook_field_config_insert`
  then wires that field into the page view display (`metatag_empty_formatter`) and form
  display (`metatag_firehose`).
- **Layout Library** → `layout_library.layout.page_two_column` (a two-column layout).

## Conditional install logic (`.install` / `hook_modules_installed`)
Runs on install and whenever a relevant module is later enabled:
- **layout_library** enabled → enable Layout Builder on the `node.page` view display and
  set the `layout_library.enable` third-party flag.
- **menu_ui** enabled → allow the `main` menu on the page type (`available_menus: [main]`,
  `parent: 'main:'`).
- **lightning_workflow** enabled → add `node:page` to the `editorial` content-moderation
  workflow (`hook_workflow_presave`).

## Compatibility
Do **not** enable on a site built from the Standard install profile — it already defines a
`page` node type and the two collide.
