<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulma block plugins

Three block plugins in `src/Plugin/Block/`. All appear under a *Bulma* block category on
**Structure → Block layout** and are configured per-placement (no global settings). Config-schema
mappings are in `config/schema/drulma_companion.schema.yml`.

## Tabs — `drulma_companion_local_tasks_block`

`Tabs` extends core `Drupal\Core\Menu\Plugin\Block\LocalTasksBlock`; renders Drupal's
primary/secondary local tasks as Bulma tabs. Category *Bulma*, admin label *Bulma Tabs*.

`defaultConfiguration()` adds to the parent: `horizontally_centered` (TRUE), `fullwidth` (FALSE),
`alignment` (`''`). The parent already provides `primary`/`secondary` booleans (in schema
`block.settings.drulma_companion_local_tasks_block`). `blockForm()` adds a "center in a
`.container`" checkbox, a "fullwidth" checkbox, and an alignment select (`centered` / `''`=left /
`right`). Meant to sit in a hero footer. Actual markup comes from the theme's tab templates.

## MenuAsTabs — `drulma_companion_menu_tabs`

`MenuAsTabs` extends `Drupal\system\Plugin\Block\SystemMenuBlock` with the `SystemMenuBlock`
deriver (one derivative per menu). Renders a chosen Drupal menu as Bulma tabs. Category
*Bulma tabs*, admin label *Menu as bulma tabs*.

`defaultConfiguration()` adds: `horizontally_centered` (TRUE), `boxed`, `toggle`,
`toggle_rounded`, `fullwidth` (all FALSE), `size` (`''`), `alignment` (`''`), `label_display`
(FALSE), and forces `depth => 1` ("multilevel tabs look weird"). `blockForm()` exposes those as
checkboxes/selects (`size`: small/''/medium/large; `alignment`: centered/left/right). `build()`
calls the parent then rewrites `#theme` via `addSuggestion()`, turning `menu__…` into
`menu__bulma_tabs__…` so themes can override the markup. Schema:
`block.settings.drulma_companion_menu_tabs`.

## BulmaNavbarWithBrandingBlock — `drulma_companion_bulma_navbar_with_branding`

`BulmaNavbarWithBrandingBlock` extends `SystemMenuBlock` (with the `SystemMenuBlock` deriver) and
merges a **branding** block with **two menus** into a single Bulma navbar. Category *Bulma navbar*,
admin label *Bulma navbar with branding*. Injects `menu.link_tree`, `menu.active_trail`,
`config.factory`, and the `menu` entity storage (`create()`).

Config keys (`defaultConfiguration()`, schema
`block.settings.drulma_companion_bulma_navbar_with_branding`):

| Key | Default | Meaning |
|---|---|---|
| `navbar_color` | `''` | Bulma navbar color (`primary`,`link`,`info`,`success`,`warning`,`danger`,`black`,`dark`,`light`,`white`, or default). |
| `navbar_title_tag` | `span` | Tag wrapping the site title (`span`,`div`,`h1`–`h5`). |
| `horizontally_centered` | TRUE | Wrap navbar in a `.container`. |
| `navbar_start_display` | TRUE | Show the start (left) menu after the branding. |
| `end_menu` | `''` | Machine name of a second menu shown at the navbar end (right). |
| `end_menu_level` / `end_menu_depth` | 1 / 0 | Start level / depth for the end menu (0 = no depth limit). |
| `use_site_logo` / `use_site_name` / `use_site_slogan` | TRUE | Toggle branding elements. |
| `site_name_size` / `site_slogan_size` | `4` / `6` | Bulma typography size (1–7). |

`build()` composes render children: `navbar_start` (the parent menu, `#access` gated by
`navbar_start_display`, `.navbar-start` class, `#theme` rewritten to `menu__bulma_navbar__…`);
`navbar_end` (built by `buildMenu()` — a copy of `SystemMenuBlock::build()` menu-tree logic — only
when `end_menu` is set, `.navbar-end` class); `site_logo` (`#theme => image`, uri
`theme_get_setting('logo.url')`); `site_name` and `site_slogan` (`#markup` from `system.site`
config `name`/`slogan`, each `#access`-gated on the toggle and a non-empty value). The branding
sub-form and its permission-aware descriptions are copied from core `SystemBrandingBlock::blockForm()`.

`getCacheTags()`/`getCacheContexts()` add the end menu's `config:system.menu.<id>` tag, the active
trail context `route.menu_active_trails:<end_menu>`, and `system.site` cache tags.
`calculateDependencies()` adds the end menu's config dependency.

## Placement

Place from *Structure → Block layout*. Navbar goes at the page top or a hero header; the two tab
blocks are designed for a hero footer. Add extra Bulma layout classes (e.g. `section`, `container`)
to any block via the **Block Class** module dependency.
