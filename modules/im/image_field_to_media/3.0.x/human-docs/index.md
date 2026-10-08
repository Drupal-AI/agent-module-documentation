# Image field to media — manual setup guide

**Image field to media** (`image_field_to_media`) helps you modernise a site that still uses
plain core **Image** fields by converting them into **Media** (image) reference fields —
without re-uploading anything. It adds a **"Clone to media"** action to every Image field on
the *Manage fields* screen. Choose it, and the module creates a Media field alongside your
Image field and then, in a batch, backfills every existing entity: for each image it
finds-or-creates an Image media entity that wraps the very same file, and attaches it to the
new Media field.

The conversion is **non-destructive** — your original Image field and its data are left
completely intact. The new Media field is populated in parallel, so you can verify the
result before deciding to switch your displays over. It is also smart about duplicates: it
matches images by a content hash, so the same physical file used across many entities maps to
a single shared Media entity rather than creating copies.

You can either create a brand-new Media reference field during the conversion, or reuse an
existing Media field that already targets the Image media type. When creating a new field, it
even copies the source field's weight, label, and image formatter settings across so your
displays line up. Because the operation creates fields and Media entities — a
site-structure-changing capability — it is gated behind a single, restricted permission meant
only for trusted administrators. The module requires core's **Media** module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent — including the batch API for use in update
hooks — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — the prerequisite Media type, the permission, and
   how to run a conversion field by field.

## Where it lives in the admin menu

There is no settings page. The feature appears as a **"Clone to media"** operation on Image
fields, under **Structure → (content type / entity bundle) → Manage fields**, visible only to
users who hold the module's permission.
