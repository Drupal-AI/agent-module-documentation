<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Icon packages (the `micon` config entity)

## The entity
`micon` is a `ConfigEntityType` (`config_prefix: micon`), so each package is stored as
`micon.micon.<id>` (e.g. `micon.micon.fa`). `config_export` keys:

| key | meaning |
|---|---|
| `id` | machine id; becomes the CSS class prefix (`<id>-`) and the selector prefix |
| `label` | human label |
| `status` | boolean; only **active** (status=1) packages contribute icons/CSS |
| `type` | `font` or `image` (SVG) — set automatically at extract time |
| `archive` | the raw IcoMoon `.zip` bytes, stored **inside the config entity** |

Admin permission: **`administer micon`**. Config UI collection:
`/admin/structure/micon` (route `entity.micon.collection`, also the module's `configure`
route). Add/edit/delete routes: `/admin/structure/micon/{add,{id}/edit,{id}/delete}`.

## Adding a package (UI)
1. Download an icon package from <https://icomoon.io> (font or SVG image set) as a `.zip`.
2. `/admin/structure/micon` → **Add Micon Package**, give it a **Name**, upload the zip, **Save**.

On save (`Micon::preSave` → `archiveExtract`) the zip is extracted to `public://micon/<id>/`,
`demo*`/`Read Me.txt` are removed, `selection.json` and `style.css` are rewritten so the
IcoMoon prefix/name become `<id>-`/`<id>`, and if the export contains `symbol-defs.svg` the
type is switched to `image`. `drupal_flush_all_caches()` runs. Published (active) packages are
immediately usable site-wide because `hook_library_info_build()` registers
`micon.<id>` (the package `style.css`) and `hook_library_info_alter()` adds it as a dependency
of the `micon` library, which `hook_element_info_alter()` attaches to every page's `html`.

## Shipped package
The module ships one package in `config/install/micon.micon.fa.yml`: **Font Awesome**, id `fa`,
type `font` → icons `fa-user`, `fa-star`, `fa-trash`, … (`fa-` prefix). Confirm active ids:
`\Drupal\micon\Entity\Micon::loadActiveLabels()` (returns `[id => label]`).

## The icon field
Attach a `string_micon` field (label "Icon") to any entity/bundle to store one icon id.
- Field type / default widget / default formatter are all `string_micon`.
- Widget setting **`packages`** (schema `field.widget.settings.micon_string`): a list of `micon`
  ids to offer; empty = all active packages. Options come from `Micon::loadActiveLabels()`.
- The formatter resolves the stored id via `micon.icon.manager->getIconMatch()` and renders the
  `MiconIcon` (`toRenderable()` → `#theme => 'micon_icon'`). `isEmpty()` is true when the stored
  id no longer matches any active icon.

Drush config read: `drush config:get micon.micon.fa` (id/label/status/type; the `archive` blob
is large). List packages: `drush config:status` or `\Drupal::entityQuery('micon')->execute()`.
