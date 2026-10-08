<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Read More Extra Field (readmore_extrafield) — agent index

Exposes the "Read more" link as a configurable **extra field**, positionable in Manage Display.
Core requirement `^9 || ^10 || ^11`.

Key facts:
- **3.x is a rewrite.** The link is now an `@ExtraFieldDisplay` plugin
  (`src/Plugin/ExtraField/Display/ReadmoreExtrafield.php`) extending
  `extra_field_plus`'s `ExtraFieldPlusDisplayFormattedBase`, not a `hook_entity_view` in
  the `.module` file.
- **Hard dependencies:** core `field`, plus contrib `extra_field` (`^2`) and
  `extra_field_plus` (`^3`). Both must be installed/enabled or updates fail
  (`hook_requirements`); `readmore_extrafield_update_8301` installs them on upgrade.
- Plugin targets **all node bundles** (`bundles = {"node.*"}`); link points at
  `entity.node.canonical` with class `readmore-extrafield-link`.
- **Configurable per view mode** (new in 3.x): Label, Link classes, `title`/`rel`/`target`
  attributes. Optional `token` module lets label/classes/title use tokens. See
  [configure](configure/settings.md).
- **Theming** via `templates/readmore-extrafield.html.twig`; variables changed in 3.x and
  there are new theme suggestions. See [theming](theming/template.md).
- Settings live in the **view display config** (schema
  `field.formatter.settings.extra_field_readmore_extrafield`), export with `drush cex`,
  differ per view mode.
- **Display-only.** Changes where/how the link renders, never the node, its access, or
  core's node links (which remain available — both can appear).
- No routes, permissions, or Drush commands. `.info.yml` reports `version: '3.1.1'`.
