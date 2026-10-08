# Configure a Superfish block

Place a block of type **Superfish** (admin_label "Superfish", one derivative per menu — the
deriver is core's `SystemMenuBlock`) at **Admin → Structure → Block layout** and pick the menu.
Settings are stored per instance under `block.settings.superfish:{menu}` (config schema
`block.settings.superfish:*`), so they export like any block config.

Key settings (from `config/schema/superfish.schema.yml`):

| Key | Meaning |
|---|---|
| `level` | Starting menu level to render. |
| `depth` | Max number of levels shown. |
| `expand_all_items` | Show all items regardless of active trail. |
| `menu_type` | `horizontal`, `vertical`, or `navbar`. |
| `style` | Built-in visual style preset. |
| `arrow` | Add arrows to items with children. |
| `shadow` | Drop shadows on sub-menus. |
| `speed` / `delay` | Animation speed and hover (mouse) delay. |
| `slide` | Slide-in effect for sub-menus. |
| `supposition` | Enable jQuery Supposition (keep sub-menus on screen). |
| `hoverintent` | Enable hoverIntent for smarter hover. |
| `touch`, `touchbh`, `touchdh`, `touchbp`, `touchua`, `touchual`, `touchuam` | Touchscreen mode: enable, behavior, disable-hover, breakpoint, and user-agent detection settings. |
| `small*` | Small-screen / responsive handling options. |

There is no site-wide settings page — everything is per block. The JS/CSS is attached from
the `superfish` library (declared in `superfish.module` via `hook_library_info_build()`),
backed by the `lobsterr/drupal-superfish` Composer package.
