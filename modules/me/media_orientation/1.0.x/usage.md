<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Orientation automatically classifies each image media item as landscape, portrait or square by comparing its pixel dimensions on save, and stores that as a number (1/2/3) in a List (integer) field you pick per media type — making orientation available to filter, theme and display.

---

Every image already implies an orientation, but nothing in Drupal exposes it as data you can list, filter or theme on. This module fills that gap for image-source media types. You add a List (integer) field (allowed values 1|Landscape, 2|Portrait, 3|Square) and select it on the media type's configuration; from then on a presave hook reads the image's real dimensions with getimagesize() and writes the matching value into that field. Detection is entirely dimension-based: wider than tall is landscape, equal is square, otherwise portrait.

Because the value lives in an ordinary List (integer) field, everything downstream is standard Drupal. An exposed Views filter on it renders as a clean select of the allowed values, so you can build "landscape only" heroes, portrait staff lists, masonry grids or a filterable media library without any extra module — the module declares no dependencies beyond core media. To show the stored number as a word, it ships an "Orientation label" display formatter and an "Orientation label (read only)" form widget. A drush command, mo:resave <bundle>, re-saves every media item of a bundle so existing content gets its orientation backfilled. It is a small building block: it provides the classification and the plumbing, not a finished gallery.

---

- Automatically classify image media as landscape, portrait or square.
- Store orientation as a number in a List (integer) field on save.
- Filter a media library view by orientation.
- Build a landscape-only hero image selection.
- List portrait-only staff photos.
- Drive a masonry layout by image orientation.
- Add an exposed select filter for orientation in Views.
- Show "Landscape/Portrait/Square" instead of a raw number using the label formatter.
- Present orientation read-only on the media edit form.
- Backfill orientation for existing media with `drush mo:resave image`.
- Separate portraits from landscapes in a listing.
- Detect square images specifically.
- Group media by shape in a gallery.
- Theme media differently based on orientation.
- Enable orientation only for image-source media types.
- Combine orientation with other exposed Views filters.
- Re-detect orientation whenever an image is replaced (on save).
- Keep orientation in sync via a periodic resave command.
- Support responsive galleries that treat tall and wide images differently.
- Expose aspect classification as filterable, themeable data.
