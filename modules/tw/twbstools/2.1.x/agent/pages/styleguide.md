<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Styleguide page (`/styleguide`)

The module's entire runtime surface. One route renders a bundled Bootstrap 5 "cheatsheet"
(every component on one page) using the site's own Bootstrap assets.

## Install / enable

- `composer require drupal/twbstools` then enable **Bootstrap tools** (`twbstools`) at
  *Extend*, or `drush en twbstools -y`.
- No config, no schema, no install step. `.info.yml` declares **no module dependencies**.
- **Soft requirement:** the [Bootstrap 5 theme](https://www.drupal.org/project/bootstrap5).
  The attached asset library depends on `bootstrap5/bootstrap5-js-latest`; with no theme
  supplying that library the page still loads but renders unstyled and the JS demos do nothing.

## Route & access

- Defined in `twbstools.routing.yml`:
  - `twbstools.styleguide.render` → path **`/styleguide`**
  - `_controller: \Drupal\twbstools\Controller\StyleguideController::render`
  - `requirements: _permission: 'access content'`
- Read-only GET that renders a static bundled page; no forms and no state change.
- **Menu link + local task** (`twbstools.links.menu.yml`, `twbstools.links.task.yml`), both
  keyed `twbstools.styleguide.render`, parent `system.admin_config_development` → appears under
  *Configuration → Development → Styleguide* (task tab labelled "Settings").

## Controller mechanism

`src/Controller/StyleguideController.php`, `StyleguideController` extends `ControllerBase`.
- `create()` injects the `extension.list.module` service
  (`\Drupal\Core\Extension\ModuleExtensionList`) — used only to resolve the module's own path.
- `render()`:
  1. `file_get_contents(getPath('twbstools') . '/resources/cheatsheet/index.html')` — reads the
     bundled static file (a saved copy of getbootstrap.com's Bootstrap 5.1 cheatsheet example,
     ~2,100 lines). The path is fixed and module-relative; nothing request-derived.
  2. one hardcoded `str_replace('https://getbootstrap.com/docs/5.1/examples/cheatsheet/', '', …)`
     to make the example's absolute asset URLs relative.
  3. `Html::load()` + `\DOMXPath` to extract two nodes: the first `<aside>` (side nav) and the
     first element with class `bd-cheatsheet` (the component gallery); re-serializes each with
     `saveXML()`.
  4. returns `['#markup' => Markup::create($html_aside . $html_cheatsheet), '#attached' =>
     ['library' => ['twbstools/twbstools.cheatsheet']]]`.
- The `Markup::create()` output is trusted/unescaped, but it is built **only from the
  module-bundled static file** — no request input, config, database, or editor value is in the
  data flow.

## Asset library

`twbstools.libraries.yml` defines `twbstools.cheatsheet`:
- CSS `resources/cheatsheet/index_files/cheatsheet.css` (component category)
- JS `resources/cheatsheet/index_files/cheatsheet.js` — Bootstrap's own demo init (tooltips,
  popovers, toasts); references the global `bootstrap` object.
- `dependencies: [bootstrap5/bootstrap5-js-latest]` — supplied by the Bootstrap 5 theme.

## Operating notes

- Grant nothing extra: `access content` is held by anonymous by default, so the page is public
  unless you restrict it. It exposes no site or user data — only the static component gallery.
- If the page looks unstyled, the Bootstrap 5 theme (or its `bootstrap5-js-latest` library) is
  not installed/active.
- Nothing here is configurable despite the "Settings" tab label; the tab simply points back at
  the same page. The README's "Bootstrap 5 elements in CKEditor" is a roadmap item — no CKEditor
  plugin, filter, or button ships in this version.
