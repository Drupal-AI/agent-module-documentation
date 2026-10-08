Burger Menu adds a single configurable block that turns any Drupal menu into a fullscreen, slide-in "hamburger" navigation overlay.

---

Burger Menu ports the Burger JS plugin by Matthew Blode into a Drupal block. It exposes one block plugin (`burger_menu_block`, category "Navigation") that loads a chosen menu's top-level (max-depth 1) enabled, access-checked links and renders them through the `burger_block` Twig template. Clicking the round burger icon toggles an `open` class on the body, the icon container and the nav list; CSS animates a full-viewport coloured overlay and slides the links in from the left. Each block instance is configured on the standard Block layout form with settings for the source menu, an optional brand label and link, and a primary/text colour pair that feed CSS custom properties (`--burger-primary`, `--burger-text`). On install the module auto-places one block in the default theme (first of header/primary_menu/navigation/page_top regions) bound to the `main` menu; uninstall removes it. There are no routes, permissions, services, config entities or Drush commands of its own — configuration lives entirely in the block instance settings.

---

- Add a fullscreen hamburger-menu overlay to a site by placing the "Burger Menu" block.
- Turn the site's Main navigation menu into a mobile-style slide-in overlay.
- Render a custom-built menu (e.g. a footer or utility menu) as fullscreen navigation.
- Provide a compact, always-visible round burger toggle in a header or navigation region.
- Show a brand name/logo text link next to the burger icon that links to the front page.
- Point the brand link at an internal path instead of the front page.
- Match the overlay to a site's palette by setting a primary (background) colour per block.
- Set the navigation link and icon colour independently of the background colour.
- Place multiple burger blocks (e.g. per theme or per section) each driving a different menu.
- Give an editor a fullscreen menu without writing any CSS/JS themselves.
- Auto-provision a working burger block on install for the default theme's main menu.
- Restrict which menu links appear using the menu system's own enabled/access checks.
- Highlight the active menu item automatically via the `b-link--active` class on the current route.
- Add an animated open/close icon (bun lines rotate into an X) with no extra configuration.
- Prevent body scrolling while the overlay is open (body gets `overflow: hidden`).
- Reuse an existing menu's structure for mobile navigation instead of duplicating links.
- Attach the burger library only where the block is placed (per-block render, cache-tagged to the menu).
- Provide a lightweight alternative to heavier mega-menu/off-canvas modules for simple sites.
- Theme the overlay further by overriding `burger-block.html.twig` or the `burger/burger` library CSS.
- Swap the source menu on the fly by editing the block's "Menu" setting.
- Rebuild the overlay automatically when the chosen menu changes (block is tagged `config:system.menu.<name>`).
- Serve the same menu differently per theme by placing the block per theme with distinct colours.
- Offer a distraction-free navigation mode where selecting the burger hides page content behind the overlay.
