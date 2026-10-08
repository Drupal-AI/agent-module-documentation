# Configuration

Canvas does not have a single "settings" form with a list of tunable options.
Instead, "configuring" it means working with its admin surfaces — the component
library, Canvas Pages, and the visual editor — and granting the right permissions.
Most of the underlying configuration is created and edited *through the Canvas UI*
rather than through traditional Drupal settings forms, and it is stored as
exportable configuration entities.

## The admin surfaces

### Components library

**Appearance → Components** (`/admin/appearance/component`) is the module's main
configuration target. Here you manage and enable the components that Canvas has
discovered — from SDCs, blocks, or code components. Reaching this page requires
core's **Administer themes** permission in addition to Canvas's own permissions,
because it lives as a local task under Appearance.

Two related pages help you keep the library healthy:

- **Component status** (`/admin/appearance/component/status`) — see which components
  are enabled versus disabled or incompatible.
- **Component audit** (`/admin/appearance/component/{component}/audit`) — see where a
  given component is used across the site.

### Canvas Pages

**Content → Pages** (`/admin/content/pages`) lists standalone Canvas Pages, and
**Add** (`/admin/content/pages/add`) creates one. A Canvas Page is a content entity
whose body is a component tree — ideal for landing and marketing pages.

### The visual editor

The builder itself is a React app:

- `/canvas` boots the app.
- `/canvas/editor/{entity_type}/{entity}` opens a specific entity's layout for
  editing.

Inside the editor you drag components into slots, set static prop values, wire props
to the host entity's fields, save reusable **patterns**, organize them into
**folders**, and edit rich-text props inline with CKEditor 5. Work is auto-saved as a
draft; publishing pushes the auto-saved changes onto the entity.

> The `/canvas/api/v0/...` routes are the editor's internal HTTP API. They are marked
> internal and are not meant for external use.

## The configuration entities

Rather than one config object, Canvas ships several config entity types, all
exportable through Drupal's configuration sync and edited mostly via the UI:

- **Component** — a registered component (from an SDC, block, or code component), with
  its enable/version status.
- **JavaScript component** (`js_component`) — a code component (JSX + CSS) authored in
  the UI.
- **Pattern** — a saved, reusable group of pre-arranged component instances.
- **Folder** — organizes components and patterns in the library.
- **Content template** — a visual display template for an entity type/bundle/view
  mode (a replacement for Manage Display).
- **Page region** — a "page template" region (header, footer, and so on) rendered
  around content.
- **Asset library** — global CSS/JS for components (ships a global default).
- **Brand kit** — brand tokens such as colors, fonts, and logo (ships a global
  default).

## Permissions

Canvas splits access across several permissions, so you can let some people build
layouts while restricting who can author code:

| Permission | What it allows |
|---|---|
| **Administer components** | Manage the component library and registered components. |
| **Administer code components** | Create/edit JavaScript code components. **Restricted** — code components run JavaScript, so grant only to trusted users. |
| **Administer folders** | Manage component/pattern folders. |
| **Administer patterns** | Manage reusable patterns. |
| **Administer page template** | Manage page-region templates. |
| **Administer content templates** | Manage content-display templates. |
| **Administer brand kit** | Manage the brand kit (colors, fonts, logo). |
| **Create / Edit / Delete canvas_page** | Manage Canvas Pages. |
| **Publish auto-saves** | Publish auto-saved draft changes onto entities (also requires update access to the target entity). |

Set these at **People → Permissions** (`/admin/people/permissions`). Remember that
the Components admin collection additionally requires **Administer themes**.

## What you still need to supply

Canvas provides the builder and the config entity model, but not the components
themselves. To have anything to compose with, build your own SDCs or code
components, or adopt an existing component system (for example the Mercury theme or
the Nebula scaffold). There are no Drush commands and no simple settings form to
configure beyond the surfaces above.
