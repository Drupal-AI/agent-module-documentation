# Configuration

Image field to media has no settings page. Its "configuration" is really a per-field
conversion you run from *Manage fields*. This page covers the prerequisite, the permission,
and the steps.

## Prerequisite: an Image media type

Before you convert anything, your site must have an **`image` Media type that contains a
field named `field_media_image`**. This is the standard Image media type Drupal provides when
you enable and set up Media. When you start a conversion, the module checks for it first; if
the media type or that field is missing, it shows an error and sends you back to *Manage
fields*. Set up the Image media type before continuing.

## Permission

All parts of the feature — the "Clone to media" operation and the forms behind it — require
the single permission **Create media fields based on existing image fields** (*restricted*).
Grant it only to trusted administrators; it is capable of creating fields and Media entities,
which changes site structure.

## Convert an Image field, step by step

1. Go to **Structure → (your content type or entity bundle) → Manage fields**.
2. Find the **Image** field you want to convert. In its operations drop-down, click **Clone
   to media**.
3. The module verifies the Image media type prerequisite, then shows the conversion form with
   two paths:
   - **Create a new Media Image field** — enter a **Label** and machine name for the new
     Media reference field. The module creates it (matching the original field's
     cardinality), applies the standard media widget and formatter, and copies the source
     Image field's weight, label, and image formatter settings onto the new field across your
     form and view modes.
   - **Reuse an existing Media field** — pick an existing entity-reference field that already
     targets the Image media type, and the backfill goes into it.
4. Click **Proceed**. A **batch** runs, walking every entity of the affected bundles that has
   the Image field and, for each image, finding-or-creating an Image media entity and
   appending it to the Media field. When it finishes you are returned to the bundle's
   *Manage fields* page.

## What to expect

- **Nothing is destroyed.** The original Image field and its data remain untouched; the new
  Media field is populated alongside it.
- **Duplicates are consolidated.** Identical image files (matched by a content hash) are
  mapped to a single shared Media entity rather than duplicated. This hash tracking is cleaned
  up automatically when Media entities are deleted and when the module is uninstalled.
- **It scales.** Because the backfill runs as a batch, large content sets are processed
  without timing out.

After the conversion you can update your form and view displays to use the new Media field
(and eventually remove the old Image field if you no longer need it — that step is up to you).
