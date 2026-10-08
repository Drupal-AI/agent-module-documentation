# Configure a Superfish block

Place a block of type **Superfish** (admin_label "Superfish", one derivative per menu — the
deriver is core's `SystemMenuBlock`) at **Admin → Structure → Block layout** and pick the menu.
Settings are stored per instance under `block.settings.superfish:{menu}` (config schema
`block.settings.superfish:*`), so they export like any block config. Placing/editing a Superfish
block is gated by core's `administer blocks` permission.

Key settings (from `config/schema/superfish.schema.yml` and the block form):

| Key | Meaning |
|---|---|
| `level` | Starting menu level to render. |
| `depth` | Max number of levels shown. |
| `expand_all_items` | Show all items regardless of active trail. |
| `menu_type` | `horizontal` (single row), `navbar` (double row), or `vertical` (stack). |
| `style` | Built-in visual style preset: `default`, `black`, `blue`, `coffee`, `white`, `none`. |
| `arrow` | Add arrows to items with children. |
| `shadow` | Drop shadows on sub-menus. |
| `speed` / `delay` | Animation speed (`slow`/`normal`/`fast`/ms) and hover (mouse) delay in ms (default 800). |
| `slide` | Slide-in effect for sub-menus (`vertical`/`horizontal`/`diagonal`, plus jQuery-Easing variants if that library is present). |
| `supposition` | Enable jQuery Supposition (keep sub-menus on screen). |
| `hoverintent` | Enable hoverIntent for smarter hover. |
| `touch`, `touchbh`, `touchdh`, `touchbp`, `touchua`, `touchual`, `touchuam` | Touchscreen mode: enable/mode, second-tap behavior, disable-hover, breakpoint, and user-agent detection settings. |
| `small`, `smallbp`, `smallua`, `smallual`, `smalluam`, `smallact` | Smallscreen mode: enable/mode, breakpoint, user-agent detection, and convert-to accordion vs `<select>`. |
| `smallset`, `smallasa`, `smallcmc`, `smallecm`, `smallchc`, `smallech`, `smallicm`, `smallich` | `<select>`-conversion options (title, class copying/exclusion/inclusion). |
| `smallamt`, `smallabt` | Accordion title and button type. |
| `supersubs`, `minwidth`, `maxwidth` | Supersubs custom sub-menu widths (em units). |
| `multicolumn`, `multicolumn_depth`, `multicolumn_levels` | Multi-column sub-menus. |
| `pathlevels` | Active-trail levels kept open. |
| `expanded` | Only show sub-menus of items with the core "Expanded" option. |
| `clone_parent` | Add cloned parent links to the top of sub-menus. |
| `hide_linkdescription` / `add_linkdescription` | Drop or inline the link `title` attribute. |
| `link_depth_class` | Add `sf-depth-N` classes to items and links. |
| `link_text_prefix` / `link_text_suffix` | Text (may include HTML) added around link text. |
| `custom_list_class` / `custom_item_class` / `custom_link_class` | Extra classes for the `<ul>`, `<li>`, and `<a>` (passed through `Html::cleanCssIdentifier()`). |

Validation (`blockValidate`): `speed` must be numeric or one of `slow`/`normal`/`fast`; `delay`,
`touchbp`, `smallbp`, `minwidth`, `maxwidth` must be numeric; custom user-agent lists are required
when the corresponding mode selects the custom list; `maxwidth` must exceed `minwidth`.

There is no site-wide settings page — everything is per block. The JS/CSS is attached from the
`superfish` libraries (declared in `hook_library_info_build()`, implemented in
`src/Hook/LibraryHooks.php` in 1.16.x), backed by the `lobsterr/drupal-superfish` Composer package;
optional add-on libraries (`superfish/superfish_hoverintent`, `superfish/superfish_easing`, etc.)
attach only when their setting is enabled.
