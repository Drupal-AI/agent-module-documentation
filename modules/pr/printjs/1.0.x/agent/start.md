<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Printjs (printjs) — agent index

Wraps the third-party **Print.js** JS library (crabbly/Print.js) so a **Print** button prints one
region of the page — a `#print` div, a view's results, a node's body — instead of the whole browser
window. The button is produced by the `print.js` service (`Printjs::getBtnPrintjs()`), which returns
a `#theme => 'printjs'` render array carrying `data-*` attributes and attaching the library plus a
thin wrapper (`js/printjs.js`). The wrapper reads the button's `data` attributes, collects the
page's stylesheet `href`s, resolves the target selector, and calls `printJS(config)`. Three surfaces
put that button on a page: a **block** (`printjs_block`), a **Views area** handler
(`printjs_views_btn`, usable in a view header/footer), and a global **settings form** at
`/admin/config/printjs/settings` that supplies site-wide defaults.

The Print.js library is **not bundled**. The default library variant (`printjs/printjs`) loads
`print.min.js`/`print.min.css` from a third-party **CDN** (`//printjs-4de6.kxcdn.com`); the
alternative variant (`printjs/printjs.local`) loads them from `/libraries/Print.js/` on the site,
which you must download and place there yourself. A per-instance/global `local` checkbox chooses
between them. The module itself ships only the wrapper `js/printjs.js`, a print `@media` stylesheet
`css/printjs.css`, and the `printjs.html.twig` button template.

- Depends on: nothing beyond core (no `dependencies:` in info.yml). The rendered button's library
  pulls `core/drupal`, `core/jquery`, `core/once`.
- Core: `^8.8 || ^9 || ^10 || ^11 || ^12`. Package: `Views`. Version `1.0.10`.
- Settings page / `configure` route: **yes** — `printjs.settings` (`administer site configuration`).
- Permissions: defines **none** of its own. Block visibility is gated by core `access content`.
- Drush: none. Plugin types defined: **none** (ships a Block and a Views-area plugin, both core types).
- Config schema: block settings only (`block.settings.printjs_block`); the `printjs.settings` object
  itself has no schema.

## What you'd do → where

- **Set site-wide defaults (print selector, extra button selector, local vs CDN library)** →
  [configure/settings.md](configure/settings.md)
- **Place / configure a Print button block** → [plugins/block.md](plugins/block.md)
- **Add a Print button to a view's header or footer** → [views/area.md](views/area.md)
- **Render a print button from code, or understand the render array / theme hook / wrapper JS /
  library variants** → [api/service.md](api/service.md)

## Key facts (real machine names)

- Route: `printjs.settings` → `/admin/config/printjs/settings`, form
  `Drupal\printjs\Form\PrintjsSettingsForm` (id `printjs_admin_settings`), permission
  `administer site configuration`.
- Service: `print.js` → `Drupal\printjs\Printjs`, public method
  `getBtnPrintjs($printText = "Print", $config = [])`; args `@config.factory`, `@string_translation`.
- Block plugin: `printjs_block` (`Plugin\Block\PrintJsBlock`), admin_label "Print button", category
  "Print", `blockAccess()` = `access content`.
- Views area handler: `printjs_views_btn` (`Plugin\views\area\PrintjsViewsBtn`, extends
  `TokenizeAreaPluginBase`); wired by `hook_views_data()` as `views.area_printjs_views`.
- Theme hook: `printjs` (`templates/printjs.html.twig`), variables `printText`, `attributes`.
- Libraries: `printjs/printjs` (CDN print.min.js/css + `js/printjs.js` + `css/printjs.css`),
  `printjs/printjs.local` (`/libraries/Print.js/print.min.{js,css}` + same wrapper/css).
- Config object `printjs.settings` keys: `printjs_id`, `btn_selector_print`,
  `print_parent_selector`, `local`. (Form omits `auto_print`/`printText`.)
- Block/area config keys (`block.settings.printjs_block` schema): `printjs_id`, `printText`,
  `print_parent_selector`, `auto_print`, `local`.
- Button markup: `<button>` with classes `btn-print btn btn-success` and
  `data-type="html"`, `data-printable=<printjs_id|print>`, `data-autoprint=<auto_print>`; full config
  echoed to `drupalSettings.printjs`.
- Hooks implemented: `hook_help`, `hook_theme`, `hook_views_data`. Extension point mentioned by the
  module: `hook_preprocess_printjs` (alter the button's `printText`/`attributes` before render).
