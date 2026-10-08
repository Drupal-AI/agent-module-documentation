Sector blocks provides five custom block plugins for the Sector distribution themes: responsive menu controls, a Search API-styled search box (desktop and mobile), a desktop search fly-out control, and a release-notes banner.

---

Sector blocks (`sector_blocks`) is a submodule of Sector Legacy that supplies the small, theme-oriented blocks the Sector distribution front end expects. It registers five block plugins under `src/Plugin/Block/`: `ResponsiveMenuControls` (hamburger/close menu and search toggle controls), `SearchApiBox` and `SearchApiBoxMobile` (search boxes styled to replicate the default core search block, desktop and mobile variants), `SearchDesktopFlyOutControl` (a desktop search fly-out toggle linking to `/search`), and `SectorReleaseNotes` (an announcement banner about the Sector 9 → Sector 10 upgrade path). Two of the blocks render through registered Twig templates (`responsive-menu-control-block.html.twig`, `search-desktop-fly-out-control-block.html.twig`) declared by `sector_blocks_theme()`; the `search_api_box` / `search_api_box_mobile` themes are referenced by the plugins but expected to be provided by the Sector theme layer. The module has no dependencies, routes, permissions, config, or JavaScript of its own — the interactive behavior (menu/search toggles) is driven by the theme's `js-toggle-*` hooks. It is meant to be enabled and its blocks placed within a Sector/Radix-based theme that supplies the matching CSS/JS and icon markup.

---

- Enable `sector_blocks` to get the Sector distribution's custom front-end blocks for placement.
- Place "Responsive menu controls" to render the mobile hamburger/close menu toggle and search toggle icons.
- Place "Search API block" for a desktop search box styled like the default core search block.
- Place "Search API block (mobile)" for the mobile variant of the Search API-styled search box.
- Place "Search desktop fly-out control" to add a desktop search icon that links to `/search` and toggles a fly-out.
- Place "Sector Release Notes block" to show administrators the Sector 9 → 10 upgrade-path announcement banner.
- Provide the `js-toggle-navigation` / `js-toggle-search` / `js-toggle-flyout-search` DOM hooks the Sector theme's JavaScript binds to.
- Wire responsive navigation controls in a Radix/Sector sub-theme without hand-coding block markup.
- Supply accessible menu/search toggle markup with screen-reader-only labels ("Open main menu", "Close search").
- Pair the search blocks with the Search API module and a Sector theme that styles `search_api_box` templates.
- Reuse the block plugins as examples of theme-driven blocks that delegate rendering to Twig templates.
- Give editors a placeable release-notes/announcement banner during a distribution upgrade window.
- Enable independently of `admin_ui_toggle` and `sector_utils` when only the custom blocks are needed.
- Provide desktop and mobile search entry points that match the distribution's icon system.
- Serve as the block layer for legacy Sector sites migrated to Drupal 10/11.
- Combine with the theme's icon fonts/SVGs (`icon--menu`, `icon--search`, `icon--close`) referenced in the templates.
