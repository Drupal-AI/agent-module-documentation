Nice Menus provides CSS/jQuery drop-down, drop-right and drop-left menus rendered as configurable blocks, using the Superfish jQuery plugin (with hoverIntent) and falling back to CSS-only behaviour when JavaScript is off.

---

The module exposes a `nice_menus_block` Block plugin that renders any site menu (or a sub-tree of one) as a Superfish-style expanding menu, plus a small global settings form at `admin/config/user-interface/nice_menus` (route `nice_menus.admin`, permission `manage nice menu settings`). Global settings (`nice_menus.settings`) control whether the Superfish JavaScript loads (`nice_menus_js`), whether the module's default CSS loads (`nice_menus_default_css`), and the Superfish hover `delay`/animation `speed`. Each block instance chooses a menu parent (`menu_name:mlid`), a depth (number of child levels, -1 = all), a style (`right`/`left`/`down`), and whether to respect the core "Show as expanded" flag. At build time `nice_menus_build_tree()` loads the menu tree via core's `menu.link_tree` service with the standard access-check and sort manipulators, adds `nice-menu*` CSS classes, and themes it through the `nice_menus` theme hook / `nice_menus.html.twig` template (which just prints the access-checked menu render array). Libraries are declared in `nice_menus.libraries.yml` (superfish, hoverIntent, base + default CSS); Superfish/hoverIntent JS ship with the module. Depends on core `menu_link_content`.

---

- Add a horizontal drop-down navigation bar (style *down*) built from the Main navigation menu.
- Add a vertical sidebar menu that flies out to the right (style *right*).
- Add a vertical sidebar menu that flies out to the left (style *left*) for right-hand regions.
- Render the Administration menu as a drop-down for site editors.
- Place a menu block that shows only a sub-tree of a menu by selecting a non-root parent.
- Limit how many child levels appear by setting the menu depth (e.g. 1 for a single flyout level).
- Show all descendant levels by leaving depth at -1.
- Respect each link's core "Show as expanded" setting to control which branches open.
- Provide CSS-only fallback menus for visitors with JavaScript disabled.
- Tune the hover close delay (milliseconds) so submenus don't collapse too eagerly.
- Set the open/close animation speed to slow, normal, or fast.
- Disable the module's default CSS to style the menus entirely from your theme.
- Disable the Superfish JavaScript to run pure-CSS menus only.
- Build multiple independent menu blocks from different source menus on one page.
- Reuse a single custom menu as both a drop-down header and a flyout sidebar via two blocks.
- Give menus consistent `nice-menu`, `nice-menu-<menu>`, and `nice-menu-<style>` classes for theming.
- Keep menu access-checking intact (unpublished/permission-restricted links are filtered by core manipulators).
- Expose menu hover options to the front end via `drupalSettings.nice_menus_options`.
- Replace jQuery-UI-heavy mega-menus with a lightweight Superfish-based alternative.
- Self-host the Superfish/hoverIntent libraries shipped with the module rather than a CDN.
