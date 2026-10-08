<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Hotspots (image_hotspots) — agent index

Overlays labelled, clickable regions ("hotspots") on an image field. It adds an image field
**formatter** (`image_with_hotspots`, extending core's `ImageFormatter`) that renders the image plus
a JS layer; editors holding `edit image hotspots` then draw regions **on the rendered image** (a
Jcrop selection) and fill a small form (title, description, link, open-in-new-window). Each saved
region is an `image_hotspot` **content entity** tied to a specific field + file + image style, and is
shown either as a hover tooltip or a click modal. Hotspot data is not entered on the node edit form —
it is created, updated and deleted from the display page through four AJAX controller routes under
`/image-hotspots/…`.

Hotspots are keyed to the `(field_name, fid, image_style, langcode)` tuple, so a hotspot only appears
under the exact image style it was drawn on. Deleting the source file or its image style enqueues the
orphaned hotspots for cleanup on the next cron run (`cron_image_hotspots_deletion` queue worker).
Titles/descriptions/links are translatable per hotspot.

- Depends on: `drupal:image` (core Image).
- Core: `^10.1 || ^11`. Package: none declared. Version **8.x-1.0-beta5** (beta).
- No settings page / `configure` route — the only configuration is the formatter's own setting on the
  field's **Manage display**. One permission (`edit image hotspots`), no drush, no config schema,
  no services, no `.install`.
- Defines one **content entity type** (`image_hotspot`), one **field formatter**
  (`image_with_hotspots`), one **queue worker** (`cron_image_hotspots_deletion`).

## What you'd do → where

- **Turn an image field into a hotspot image / choose tooltip vs modal** →
  [fields/formatters.md](fields/formatters.md)
- **Understand the `image_hotspot` entity, its base fields and the target key** →
  [fields/formatters.md](fields/formatters.md)
- **Call / understand the create-update-delete-translate AJAX routes, the flood limiter, cache
  invalidation and the cron cleanup** → [api/routes.md](api/routes.md)
- **Who can add or edit hotspots** → [permissions/permissions.md](permissions/permissions.md)

## Key facts (real machine names)

- Entity type: `image_hotspot` (`ContentEntityBase`; base_table `image_hotspot`, data_table
  `image_hotspot_field_data`, `translatable = TRUE`; keys id=`hid`, label=`title`, `uuid`,
  `langcode`). Class `Drupal\image_hotspots\Entity\ImageHotspot`, interface `ImageHotspotInterface`.
- Base fields: `hid`, `uuid`, `field_name` (ref field_config), `fid` (ref file), `image_style` (ref
  image_style), `uid` (ref user), `title`, `target`, `description` (string_long), `link`
  (string_long), `langcode`, `x`, `y`, `x2`, `y2` (float coords).
- Field formatter: `image_with_hotspots` (image fields), class `ImageHotspotsFormatter` extends
  `Drupal\image\Plugin\Field\FieldFormatter\ImageFormatter`. Setting: `image_hotspots_style`
  (values `tooltip` | `modal`; note the default in code is the misspelled `'tootip'`).
- Routes (controller `Drupal\image_hotspots\Controller\ImageHotspotsController`, all require
  `_permission: 'edit image hotspots'`):
  - `image_hotspots.create_hotspot` — `/image-hotspots/create` → `createAction`
  - `image_hotspots.update_hotspot` — `/image-hotspots/{hid}/update` → `updateAction`
  - `image_hotspots.delete_hotspot` — `/image-hotspots/{hid}/delete` → `deleteAction`
  - `image_hotspots.translate_hotspot` — `/image-hotspots/{hid}/{langcode}/translate` →
    `translateAction`
- Permission: `edit image hotspots`.
- Theme hook: `image_formatter_with_hotspots` (template `image-formatter-with-hotspots.html.twig`,
  preprocess `template_preprocess_image_formatter_with_hotspots`).
- Queue worker: `cron_image_hotspots_deletion` (`CronHotspotsWorker`, cron time 10); filled by
  `image_hotspots_file_delete()` and `image_hotspots_image_style_delete()` hooks.
- Libraries: `image_hotspots/view`, `image_hotspots/edit`, `image_hotspots/translate`,
  `image_hotspots/tipTip`, `image_hotspots/jquery.jcrop`; the formatter also attaches
  `core/drupal.dialog.ajax`.
- Cache tag per rendered image: `hotspots:{field_name}:{fid}:{image_style}`.
- `drupalSettings` path: `image_hotspots[field_name][fid][image_style][hotspots_style][langcode].hotspots`.
