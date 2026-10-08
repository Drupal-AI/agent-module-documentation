# Canvas permissions

From `canvas.permissions.yml`:

| Permission | Gates | Notes |
|---|---|---|
| `administer components` | Manage the Component library / registered components | |
| `administer code components` | Create/edit JavaScript code components (`js_component`) | **`restrict access: true`** — code components run JavaScript, treat as trusted |
| `administer folders` | Manage component/pattern Folders | |
| `administer patterns` | Manage reusable Patterns | |
| `administer page template` | Manage PageRegion "page template" regions | |
| `administer content templates` | Manage ContentTemplate display templates | |
| `administer brand kit` | Manage BrandKit (colors/fonts/logo) | |
| `create canvas_page` | Create a Canvas Page | |
| `edit canvas_page` | Edit a Canvas Page | |
| `delete canvas_page` | Delete a Canvas Page | |
| `publish auto-saves` | Publish auto-saved (draft) changes onto entities | Also requires `update` access to the target entities |

Note: reaching the Components admin collection (`/admin/appearance/component`) additionally
requires core's `administer themes` (the routes are local tasks under Appearance).
