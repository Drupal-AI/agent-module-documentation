# Configure Drupal Canvas

`configure` route (info.yml): **`entity.component.collection`** → **`/admin/appearance/component`**
(the Components collection, a local task under Appearance › Components; requires
`administer themes`). Verified against `canvas.routing.yml` + `canvas.links.task.yml`.

## Key UI paths
| Path | Route | What |
|---|---|---|
| `/admin/appearance/component` | `entity.component.collection` | Manage/enable Components (the `configure` target) |
| `/admin/appearance/component/status` | `canvas.component.status` | Enabled vs. disabled/incompatible components |
| `/admin/appearance/component/{component}/audit` | `entity.component.audit` | Where a component is used |
| `/admin/content/pages` | `entity.canvas_page.collection` | List Canvas Pages (also under Navigation › Pages) |
| `/admin/content/pages/add` | `entity.canvas_page.add_page` | Create a Canvas Page |
| `/canvas` | `canvas.boot.empty` | Boot the Canvas React app |
| `/canvas/editor/{entity_type}/{entity}` | `canvas.boot.entity` | Edit an entity's layout in Canvas |
| `/canvas/app/{extension_id}` | `canvas.boot.app` | Deep-link into a Canvas extension's UI |

The `canvas.api.*` routes (dozens, under `/canvas/api/v0/...`) are the SPA's **internal**
HTTP API — `@internal`, not for external use.

## Config entity types (all provided by canvas)
Managed as config (exportable via Configuration sync), edited mostly through the Canvas UI /
internal API rather than dedicated settings forms:

- **`component`** — a discovered/registered component (from an SDC, block, or code component) with enable/version status.
- **`js_component`** — a JavaScript "code component" (JSX + CSS) authored in the UI.
- **`pattern`** — a saved, reusable group of pre-arranged component instances.
- **`folder`** — organizes components/patterns in the library.
- **`content_template`** — a visual display template for an entity type/bundle/view-mode (replaces Manage Display).
- **`page_region`** — a "page template" region (header/footer/etc.) rendered around content.
- **`asset_library`** — global CSS/JS asset library for components (ships `canvas.asset_library.global`).
- **`brand_kit`** — brand tokens: colors, fonts, logo (ships `canvas.brand_kit.global`).

Content entity: **`canvas_page`** — a standalone page whose body is a component tree.

## Bundled config installed on enable
- Text formats + editors: `canvas_html_block`, `canvas_html_inline` (CKEditor 5, for HTML prop editing).
- Image styles: `canvas_avatar`, `canvas_parametrized_width`.
- Defaults: `canvas.asset_library.global`, `canvas.brand_kit.global`.

Config schema lives in `config/schema/canvas*.yml`. No `settings` form / simple config
object with tunable keys is exposed — configuration is the set of config entities above.

## Setup notes
- Requires core **Media** + **Media Library** for image support (see README).
- You must supply a component system: build SDCs/code components, or start from an existing
  set (e.g. Mercury theme, or scaffold code components with `@drupal-canvas/create` / Nebula).
- No Drush commands are provided by this module.
