# Configuration

Everything about Responsive Menus is configured on a single settings form. Until
you point it at a menu with a selector, nothing changes on your site.

## Open the settings form

1. Log in as a user with the **Administer responsive menus**
   (`administer responsive menus`) permission — an administrator by default.
2. Go to **Configuration → User interface → Responsive Menus**, or navigate
   directly to `/admin/config/user-interface/responsive_menus`.

## Choose a style

At the top you pick the **style** — the plugin that controls the mobile behavior.
Only one style is active site-wide. The two that work out of the box are:

- **Simple expanding** (`responsive_menus_simple`) *(default)* — a lightweight,
  dependency-free mobile menu that expands in place.
- **Mean Menu** (`mean_menu`) — supports multi-level menus with expand/collapse
  controls and a positioned overlay.

The other listed styles (Sidr, codrops Multi-level, Google Nexus, Multi-level
Push Menu) only work once you have downloaded their external JavaScript libraries.

When you change the style, the form shows that style's own settings below.

## Ignore admin pages

A checkbox — **ignore admin pages** — is on by default. Leave it on so the
responsive behavior does not interfere with Drupal's admin screens.

## Settings for the Simple expanding style

- **CSS selectors** — the CSS or jQuery selector(s) for the menu(s) to transform,
  for example `#block-mainnavigation`. You can list several, separated by commas
  or new lines. This is the most important field: without it nothing happens.
- **Toggle text** — the text or HTML shown on the toggle button. Default is
  `☰ Menu`.
- **Media size** — the breakpoint width below which the menu switches to mobile
  mode. Default is `768`.
- **Media unit** — whether the breakpoint is measured in **px** (default) or
  **em**.
- **Absolute positioning** — when on (default), the open menu is positioned as an
  overlay; when off it pushes the page content down.
- **Disable mouse events** — turns off hover drop-downs in mobile mode to avoid
  double-tap problems on touch devices.
- **Remove attributes** — temporarily strips other classes and IDs from the menu
  so the mobile styling applies cleanly. On by default.

## Settings for the Mean Menu style

- **CSS selectors** — the selector(s) for the menu(s) to transform (default
  `#main-menu`).
- **Container** — the element the mobile menu is injected into (default `body`).
- **Trigger text** — the HTML for the toggle button (default is three `<span />`
  elements, which theme into a bar icon).
- **Close text** — the text for the close control (default `X`).
- **Position** — where the open/close controls sit: **left**, **right**
  (default), or **center**.
- **Media size** — the breakpoint width (default `480`).
- **Show children / Expand children** — whether sub-menu items are shown and
  whether they can be expanded (both on by default), plus the expand/contract
  text.
- **Remove attributes** — strips other classes/IDs so styling applies cleanly.

## Save

Click **Save configuration**. To test, load a front-end page and shrink the
browser below your chosen breakpoint — the targeted menu should collapse into a
toggle button. If nothing happens, double-check that your CSS selector actually
matches the menu markup your theme renders (inspect the page to confirm the
element's ID or class).

## Deployment note

All of these choices are stored in the `responsive_menus.configuration` config
object, so you can export them with the rest of your site configuration and deploy
them like any other setting.
