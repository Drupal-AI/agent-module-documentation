<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Micon — agent index

IcoMoon icon manager. Icon **packages** are `micon` config entities (`micon.micon.<id>`);
the shipped Font Awesome package has id `fa`, so icons are addressed by selector `fa-<name>`
(e.g. `fa-user`). Config UI: `/admin/structure/micon` (route `entity.micon.collection`,
permission `administer micon`). Icons resolve through `micon.icon.manager`.

- **Icon packages: the `micon` config entity, admin UI, uploading IcoMoon zips, the `fa` package, permission** →
  [configure/packages.md](configure/packages.md)
- **Render / use an icon: Twig `micon()`, `#theme` hooks, `#type => 'micon'` element, the `string_micon` field, and the `micon()` / `MiconIconize` PHP API** →
  [api/render-and-iconize.md](api/render-and-iconize.md)
- **Map strings to icons: the `micon_icons` YAML plugin type and `hook_micon_icons_alter()`** →
  [plugins/micon-icons.md](plugins/micon-icons.md)
- **`drush micon <path>` — export active icons as an SCSS mixin file** →
  [drush/micon.md](drush/micon.md)

Key facts:
- Selector = package prefix + icon name. `MiconIcon::getSelector()`; resolve with
  `\Drupal::service('micon.icon.manager')->getIconMatch('fa-user')` (returns a `MiconIcon` or NULL).
- Field: type/widget/formatter all id `string_micon` (label "Icon"); widget setting `packages`
  (a list of `micon` ids; empty = all packages offered).
- Two theme hooks: `micon_icon` (icon only) and `micon` (icon + `#title`, `#position`
  `before`/`after`, `#icon_only`).
- Submodules each have their own doc dir under `modules/<sub>/2.1.x/`.
