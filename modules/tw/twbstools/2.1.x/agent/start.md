<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap tools (twbstools) — agent index

Companion to the **Bootstrap 5 theme** (`bootstrap5`). Adds exactly one thing: a Bootstrap 5
**style guide / cheatsheet** page at `/styleguide` that renders every Bootstrap 5 component on a
single page, styled with the site's own Bootstrap assets, so editors and developers can preview the
theme's markup and classes. There is nothing to configure.

- **The `/styleguide` page — route, controller, asset library, how it renders, operating notes** →
  [pages/styleguide.md](pages/styleguide.md)

The single route `twbstools.styleguide.render` (`/styleguide`) is handled by
`StyleguideController::render()` (`src/Controller/StyleguideController.php`). The controller
`file_get_contents()`s the bundled static file `resources/cheatsheet/index.html` (a saved copy of
getbootstrap.com's cheatsheet example), rewrites the absolute example URL to a relative one with
`str_replace()`, parses it via `Html::load()` + `\DOMXPath`, extracts the `<aside>` navigation and
the `.bd-cheatsheet` node, and returns them as `#markup` (`Markup::create()`) with the asset library
`twbstools/twbstools.cheatsheet` attached. The rendered HTML is module-bundled and static — no user
input flows into it.

- **Depends on:** nothing — `.info.yml` declares no module dependencies.
- **Soft requirement:** the **Bootstrap 5 theme**. The attached library depends on
  `bootstrap5/bootstrap5-js-latest`; without that theme installed the page renders unstyled.
- **Core:** `^10.2 || ^11.0`. **Package:** none declared. **License:** GPL-2.0-or-later.
- **Config / settings page:** none (`configure` null). **Permissions:** none of its own — the route
  uses core **`access content`**. **Drush:** none. **Plugin types:** none. **Services / hooks /
  config schema / entities / fields:** none.

## Key facts (real machine names)
- **Route:** `twbstools.styleguide.render` → path `/styleguide`,
  `_controller: \Drupal\twbstools\Controller\StyleguideController::render`,
  `_permission: 'access content'`.
- **Controller:** `Drupal\twbstools\Controller\StyleguideController::render()` — injects
  `extension.list.module` (`\Drupal\Core\Extension\ModuleExtensionList`) to resolve the module path.
- **Asset library:** `twbstools/twbstools.cheatsheet` →
  `resources/cheatsheet/index_files/cheatsheet.css` + `cheatsheet.js`;
  `dependencies: [bootstrap5/bootstrap5-js-latest]`.
- **Menu link + local task:** both named `twbstools.styleguide.render`, parent
  `system.admin_config_development` (*Configuration → Development → Styleguide*).
- **Bundled asset:** `resources/cheatsheet/index.html` — the static Bootstrap 5 cheatsheet the page
  renders.
