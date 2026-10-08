<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media orientation (media_orientation) — agent index

On every media save, detects an **image** media item's orientation from its pixel dimensions and
writes **1 = Landscape / 2 = Portrait / 3 = Square** into a List (integer) field you choose per
media type. Adds a label formatter and a read-only widget to render the number as text, plus a
Drush command to backfill existing media. Version **1.0.x**, core `^10 || ^11`.

No declared dependencies (uses core **media**; README states it requires nothing outside core).
No settings page — configuration is a **third-party setting on each media type** (only for
`image`-source bundles). No permissions.

- **Turn on orientation for a media type / set it via drush or PHP** → [configure/orientation.md](configure/orientation.md)
- **Backfill orientation on existing media** → [drush/commands.md](drush/commands.md)
- **Show the number as "Landscape/Portrait/Square" on form or display** → [fields/display.md](fields/display.md)
- **Reuse the orientation mapping / detection in your own code** → [api/orientation.md](api/orientation.md)

## Key facts
- Presave hook: `media_orientation_media_presave()` → `OrientationHelper::saveMediaEntityOrientation()`.
- Third-party setting: provider `media_orientation`, key `orientation` (stores the target field name), on `media.type.*` config entities.
- Target field must be type `list_integer` and a non-base field; only `image`-source bundles are processed.
- Orientation values: `Orientation::LANDSCAPE = 1`, `Orientation::PORTRAIT = 2`, `Orientation::SQUARE = 3`.
- Field formatter id: `media_orientation_label`. Field widget id: `media_orientation_readonly` (both for `list_integer`).
- Drush command: `mo:resave <bundle>` (`MediaOrientationCommands::migrate`).
- Config UI: injected into the media type edit form via `media_orientation_form_media_type_edit_form_alter()`.
