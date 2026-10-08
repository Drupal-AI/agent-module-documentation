<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registers the Bootstrap Icons SVG library (2000+ icons) as a Drupal core Icon API pack so its icons can be rendered anywhere the `icon()` Twig function or `#type => icon` render element is used.

---

Bootstrap Icons is a thin, data-only integration for Drupal 11.1+ core's Icon API. It ships one icon-pack definition (`bootstrap_icons.icons.yml`) that registers a pack with id `bootstrap`, points core's built-in `svg` extractor at the SVG files installed under `/libraries/bootstrap-icons/icons/*.svg`, and supplies a Twig `template` that inlines each icon's `<svg>` markup with the canonical `class="bi bi-<icon_id>"` and a configurable pixel `size` (default 24). The upstream `twbs/bootstrap-icons` 1.11.3 library is not bundled; you install it separately with the module's Drush command `drush bootstrap_icons:download` (curls the npm tarball and unpacks it into `libraries/bootstrap-icons/`) or via the `composer.libraries.json` fragment. There are no routes, permissions, config forms, config entities, services beyond the Drush command, hooks, or JavaScript — icons are discovered and rendered entirely server-side through core. The one PHP class is `BootstrapIconsCommands` (the Drush download helper).

---

- Add Bootstrap's 2000+ open-source SVG icons to a Drupal 11.1+ site as an Icon API pack.
- Render an icon in a Twig template: `{{ icon('bootstrap', 'arrow-right', {size: 24}) }}`.
- Render an icon in a render array with `#type => icon`, `#pack_id => 'bootstrap'`, `#icon_id => 'house'`.
- Give editors a consistent icon set to pick from wherever an Icon API icon picker is exposed.
- Use icons in SDC (Single Directory Components) or theme templates without adding an icon font.
- Serve icons without any client-side JavaScript — each SVG is inlined server-side at render time.
- Size icons per usage by passing the `size` setting (pixels) in the icon settings array.
- Install the SVG library with one command: `drush bootstrap_icons:download`.
- Install the SVG library into a non-default path: `drush bootstrap_icons:download web/libraries`.
- Install the SVG library through Composer using the shipped `composer.libraries.json` repository/require fragment.
- Query all Bootstrap icons programmatically via the `plugin.manager.icon_pack` service (`getIcons()`).
- Fetch a single icon definition with `$manager->getIcon('bootstrap:house')`.
- Match Bootstrap-themed front-end designs by reusing the same `bi bi-*` class names Bootstrap uses.
- Provide crisp, currentColor-inheriting icons that follow surrounding text color automatically.
- Add icons to menus, blocks, or fields anywhere the core Icon API icon widget is available.
- Update the icon library later by bumping the version in `composer.libraries.json` / `icons.yml` and re-running the download.
- Keep icons out of the module repo (the library is vendored separately) to stay license-clean and lean.
- Use as a lightweight alternative to icon-font modules that require web-font loading.
- Preview and browse the full icon set at icons.getbootstrap.com before choosing icon ids.
- Combine with other Icon API packs (e.g. a Lucide pack) on the same site for a broader icon selection.
