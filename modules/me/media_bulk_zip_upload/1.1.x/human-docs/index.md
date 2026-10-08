# Media Bulk Zip Upload — manual setup guide

**Media Bulk Zip Upload** (`media_bulk_zip_upload`) lets an editor upload a single
ZIP archive and have every file inside it become its own media entity — instead
of adding hundreds of images or documents to the media library one at a time. It
adds a bulk upload form at `/media/add/{media_type}/bulk`, right alongside the
normal "add media" form, that accepts an archive and expands it into media items
of the media type you chose.

This is the tool you reach for when populating a library from an existing folder
of assets: a photo shoot, a set of PDFs, product imagery, or assets exported from
another CMS. The alternatives — a migration, a Drush script, or an afternoon of
clicking — are all disproportionate for what is really one action.

A couple of design details are worth knowing. Access to the bulk form is decided
by a **custom access check** rather than a single flat permission, so it respects
each media type's *create* access instead of granting one blanket right. The
per-media-type permissions themselves are **generated at runtime**, so you'll find
them on the Permissions page once the module is enabled. A settings form lets you
choose which media types offer the bulk upload form, and the module fires events
during expansion so developers can alter the media entities before they are saved.

One thing to keep tight: what an archive is *allowed* to contain is governed by
the target media type's allowed file extensions — ordinary Drupal field
validation. An archive is an easy way to deliver many files at once, so a
permissive media type is more exposed here than on the single-file form. Keep the
media type's allowed extensions restricted to what you actually expect.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which media types offer bulk
   ZIP upload, grant the generated permissions, and customise the bulk form.

## Where it lives in the admin menu

The settings form sits at **Configuration → Media → Media Bulk Zip Upload config**
(`/admin/config/media/media-bulk-zip-upload-config`), behind the **Administer
media** permission. The bulk upload form itself lives at
`/media/add/{media_type}/bulk` for each media type you enable.

## How to use it

1. Enable bulk upload for one or more media types on the settings form (see
   [Configuration](configuration/index.md)).
2. Grant the generated bulk-upload permission for those media types to the roles
   that should be allowed to use it.
3. Go to `/media/add/{media_type}/bulk` (for example `/media/add/image/bulk`),
   upload a ZIP archive, and submit. Each file inside becomes a separate media
   entity of that type.
