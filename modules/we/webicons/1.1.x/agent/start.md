<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Icons (webicons) — agent index

Bundles three icon libraries (**Boxicons 2.1.4**, **Font Awesome Free 6.5.2**, **Material Icons
1.13.12**) and exposes them two ways: a **field type** (`webicons_field`) with an AJAX icon-picker
widget you add to any fieldable entity, and a **Twig function** (`webicon()`) that emits an icon
straight from a template. Icons render as icon-font markup (an `<i>`/`<span>` with CSS classes),
never inline SVG. Core-only; no external dependencies. `core_version_requirement: ^9 || ^10 || ^11`.

No settings page (`configure` is null). No permissions of its own — the picker route uses core
`access content`. No drush, no config schema, no custom plugin types.

- **Add an icon field to a content type / entity** → [fields/webicons_field.md](fields/webicons_field.md)
- **Emit an icon from a Twig template** → [theme/twig.md](theme/twig.md)
- **Call the icon service / add a new icon library** → [api/services.md](api/services.md)

Key facts:
- Field type `webicons_field`; widget `webicons_field`; formatter `webicons_field_default`; field-type
  category `Webicons` (`webicons.field_type_categories.yml`). Stored columns: `icon_class`, `icon_code`
  (both varchar 255).
- Twig function `webicon(libraryId, keyValues, classes=[])` from `Drupal\webicons\WebiconsTwigExtension`.
- Service `webicons.service` (`IconService`) resolves a per-library factory service
  `webicons.<libraryId>` (`webicons.boxicons`, `webicons.fortawesome`, `webicons.materialicons`).
  Library ids and labels live in `IconServiceInterface::ICONS`.
- Route `webicons.open_selector` at `/webicon-selector` (`_permission: 'access content'`,
  controller `IconSelectorController::iconSelectorDialog`) returns the picker modal; params `lid`
  (library id) and `wid` (target wrapper id).
- Asset libraries: `webicons/boxicons`, `webicons/fortawesome`, `webicons/materialicons`,
  `webicons/icon-selector`, `webicons/icon-dialog`. Theme hooks: `icon_selector`,
  `webicon_field__value`.
- Icon lists are extracted from the bundled asset files and cached permanently in `cache.default`
  (cid = library id).
