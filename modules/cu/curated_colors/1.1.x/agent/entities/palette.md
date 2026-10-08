<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `curated_color_palette` config entity, editor & routes

## Install & enable

```bash
composer require drupal/curated_colors
drush en curated_colors -y
```

No runtime module dependencies. Manage palettes at **`/admin/config/content/curated-colors`**
(menu: *Configuration → Content authoring → Color palettes*). `configure` route is
`entity.curated_color_palette.collection`.

## Entity: `ColorPalette` (`src/Entity/ColorPalette.php`)

A `ConfigEntityType` id **`curated_color_palette`**, config prefix `curated_color_palette`,
`admin_permission = "administer curated color palettes"`. `config_export`: `id`, `label`,
`description`, `groups`, `colors`. Handlers: list builder `ColorPaletteListBuilder`, add/edit form
`ColorPaletteForm`, delete form core `EntityDeleteForm`.

Stored shape (schema in `config/schema/curated_colors.schema.yml`):

```yaml
id: brand                 # machine_name
label: Brand              # required
description: '...'        # optional
groups:                   # ordered sequence of group names
  - Primary
  - Gradients
colors:                   # ordered sequence
  - key: brand-blue       # slug: [a-z0-9_-]+, stored in content
    label: 'Brand Blue'   # required
    hex: '#0678be'        # optional; admin-preview only
    style: ''             # optional custom CSS (gradients etc.); overrides hex when set
    enabled: true         # boolean
    groups: [Primary]     # subset of the palette's groups
```

### Helper methods

- `getColors(): array` — colors re-keyed by their `key`, skipping entries with an empty key; each
  normalized to `{key,label,hex:?,style:?,groups[],enabled:bool}` (missing `enabled` ⇒ `TRUE`).
- `getOptions(): array` — `key => label` map for select `#options`.
- `getGroups(): array` — ordered group names (empty values filtered out).

## Routes & permission (`curated_colors.routing.yml`)

| Route | Path | Requirement |
|---|---|---|
| `entity.curated_color_palette.collection` | `/admin/config/content/curated-colors` | perm `administer curated color palettes` |
| `entity.curated_color_palette.add_form` | `.../add` | same |
| `entity.curated_color_palette.edit_form` | `.../{curated_color_palette}` | same |
| `entity.curated_color_palette.delete_form` | `.../{curated_color_palette}/delete` | same |

The single permission **`administer curated color palettes`** (`curated_colors.permissions.yml`,
`restrict access: true`) governs create/edit/delete. An "Add palette" action link
(`curated_colors.links.action.yml`) appears on the collection.

## The palette editor form (`src/Form/ColorPaletteForm.php`)

`ColorPaletteForm extends EntityForm` (`@internal`). It attaches library `curated_colors/palette_form`
and renders three parts:

- **Header** — Label, machine `id` (`#machine_name`, source pointed at the nested label; disabled
  once saved), Description, and a JS live-preview canvas (`data-curated-colors-preview`).
- **Groups section** — a draggable `#type table` of group-name rows; *Add group* / *Remove*
  buttons are AJAX submit handlers (`::addGroup` / `::removeGroup`) rebuilding the whole builder
  via `::ajaxRefreshBuilder`. Group order (drag weight) is persisted.
- **Colors section** — one **card** per color (`buildColorCard()`), split into Enabled vs a
  "Disabled" area. Per card: `key`, `label`, `hex` (textfield; JS attaches a native color input),
  a `groups` checkboxes element, a custom-CSS `style` textarea (edited through a cloned dialog
  template), an **Enabled** toggle (mirrored into an authoritative hidden input so an unchecked box
  isn't lost on rebuild), a hidden drag `weight`, and *Remove*. *Add color* (`::addRow`) and
  *Remove* (`::removeRow`) are AJAX handlers rebuilding just the cards (`::ajaxRefreshCards`).

### Key rules & validation

- **Keys are immutable once saved.** `form()` records existing keys in
  `curated_colors_saved_keys`; a locked key renders read-only (an `item` + hidden input) because
  content stores the key and renaming would orphan values. Change a key only by removing and
  re-adding the color.
- **Disable, don't delete.** Turning off Enabled hides a color from the picker/preview but keeps
  existing content rendering; it can be re-enabled anytime.
- `validateForm()` enforces: non-empty unique `key` matching `/^[a-z0-9_-]+$/`; non-empty `label`;
  `hex` matching a 3/6/8-char hex pattern when set; and rejects custom CSS containing **at-rules**
  (`/@[a-zA-Z]/`, e.g. `@import`, `@font-face`). Custom CSS length is capped at 1024 chars by the
  textarea `#maxlength` (also enforced server-side).
- `submitForm()` orders groups and colors by drag weight, keeps only checked group names that still
  exist, normalizes `hex` with a leading `#`, and writes the `groups`/`colors` sequences.
- `save()` shows a status message and redirects to the collection.

## List builder (`src/ColorPaletteListBuilder.php`)

`ColorPaletteListBuilder extends ConfigEntityListBuilder` (`@internal`) — columns Palette (label),
Machine name (id), Colors (count of `getColors()`), plus default operations.

## Shipping a palette in config

Place `curated_colors.curated_color_palette.<id>.yml` in a module's `config/install/` (enforce the
dependency on the providing module) to ship it, or manage it in `config/sync/`. See the
`curated_colors_example` submodule's `drupal_brand` palette for a full example.

## Install hook

`curated_colors_update_10001` (`curated_colors.install`) backfills `enabled = TRUE` on every stored
palette color that predates the enabled flag.
