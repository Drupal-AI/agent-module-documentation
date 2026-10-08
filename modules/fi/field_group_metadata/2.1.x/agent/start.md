<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Group Metadata (field_group_metadata) — agent index

Relocates a **Field Group named exactly `group_metadata`** into an entity edit form's right-hand
`advanced` sidebar (core's vertical-tabs column), so metadata fields sit beside authoring info and
the revision log instead of in the main content stack. Depends on `field_group ~3.0 || ~4.0`;
core `^8 || ^9 || ^10 || ^11`.

Key facts:
- **Whole module** = `field_group_metadata.module` + `src/FieldGroupMetadataPreRenderer.php`. No
  routes, permissions, config schema, plugins or services of its own.
- **Convention-driven, zero config.** The only trigger is a group whose machine name is
  `group_metadata`. Any other name is ignored. There is no settings form.
- **Presentational only** — a `#pre_render` callback moves the group (`#weight -1000`) and copies
  the form `actions` (`#weight 1000`) into `advanced`. Storage, validation and access are untouched,
  so it is free to install/remove.
- **Scope:** every entity form carrying a `group_metadata` group **except** forms whose id starts
  with `media_` (explicitly skipped).
- `hook_module_implements_alter()` pushes this module's `form_alter` after `field_group`'s.
- `composer.json` sets `"minimum-stability": "dev"` — relevant when resolving versions.

Capabilities:
- [Set up the metadata group](configure/setup.md) — the one setup step, exact mechanism, scope and caveats.
