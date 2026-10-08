# Configuration

Canvas is configured less through a traditional settings form and more through a
set of **config entities** you manage in the Canvas UI, plus the component system
you supply. There is **no simple settings form with tunable keys** — configuration
*is* the collection of components, templates, pages, and brand tokens described
below.

## Key admin locations

| What | Path | Notes |
|------|------|-------|
| **Components** | `/admin/appearance/component` | Manage and enable discovered/registered components. This is the module's `configure` link (under Appearance › Components; requires **Administer themes**). |
| **Component status** | `/admin/appearance/component/status` | See which components are enabled vs. disabled/incompatible. |
| **Component audit** | `/admin/appearance/component/{component}/audit` | See where a component is used. |
| **Pages** | `/admin/content/pages` | List standalone Canvas Pages (also under Navigation › Pages). |
| **Add page** | `/admin/content/pages/add` | Create a Canvas Page. |
| **Canvas editor** | `/canvas`, `/canvas/editor/{entity_type}/{entity}` | Boot the React builder, optionally against a specific entity's layout. |

The many `/canvas/api/v0/...` routes are the editor's **internal** HTTP API — they
are marked internal, guarded by custom access checks, and not meant for external
use.

## What you configure (the config entities)

Canvas stores its configuration as config entities, exportable via Configuration
sync and edited mostly through the Canvas UI rather than dedicated forms:

- **Component** — a discovered/registered component (from an SDC, block, or code
  component), with enable/version status.
- **JS component** — a JavaScript "code component" (JSX + CSS) authored in the UI.
- **Pattern** — a saved, reusable group of pre-arranged component instances.
- **Folder** — organizes components and patterns in the library.
- **Content template** — a visual display template for an entity type/bundle/view
  mode (a replacement for Manage Display).
- **Page region** — a header/footer/etc. region rendered around content.
- **Asset library** — a global CSS/JS asset library for components (ships
  `canvas.asset_library.global`).
- **Brand kit** — brand tokens: colors, fonts, and logo (ships
  `canvas.brand_kit.global`).

There is also a **Canvas Page** content entity, a standalone page whose body is a
component tree.

## What gets installed automatically

Enabling Canvas installs some supporting configuration: two CKEditor 5 text formats
for HTML prop editing (`canvas_html_block`, `canvas_html_inline`), two image styles
(`canvas_avatar`, `canvas_parametrized_width`), and the default global asset library
and brand kit.

## Setup checklist

1. **Provide a component system.** Canvas is only useful once components exist —
   build your own SDCs / code components, or start from an existing set (e.g. the
   Mercury theme, or scaffold code components with `@drupal-canvas/create` /
   Nebula).
2. **Ensure Media and Media Library are enabled** for image support (Canvas depends
   on them).
3. **Curate components** under **Appearance → Components**, enabling the ones you
   want available in the editor.
4. **Build pages** — as standalone Canvas Pages, or by opening an entity's layout
   in the Canvas editor.
5. **Enable optional submodules** only as needed (AI, OAuth, headless, etc.), and
   keep the `canvas_dev_*` feature-flag/dev submodules off in production —
   `canvas_dev_mode` in particular exposes private/internal APIs.

## A note on APIs

Canvas 1.x ships **no stable public PHP or HTTP API**; its controllers, services,
and endpoints are internal and may change between releases. Configure and use
Canvas through its UI and exported config entities rather than integrating code
against it for now.
