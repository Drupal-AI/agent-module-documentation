# Media Download All — manual setup guide

**Media Download All** (`media_download_all`) adds a *download all* capability for
the media and files attached to an entity: a single click bundles them into one
`.zip` archive and downloads it. A page with several attachments — an image
gallery, a set of documents — becomes much friendlier when visitors can grab
everything at once instead of saving each file in turn. It depends only on core's
**Media** module and works with any fieldable entity, not just nodes.

It ships in two forms so you can place the *download all* control where it makes
sense:

- a **field formatter** for a media entity reference field, so the download link
  appears in the field's output on the entity, and
- a **block plugin**, so you can position the download link anywhere the block
  layout allows.

The module is built with security in mind: it stores the temporary `.zip` files in
Drupal's **private file system** rather than the public one, so the temporary
archives are not left exposed. There is an important consideration to keep in view
all the same: the archive is generated from the referenced files, so it must honour
those files' access — a *download all* should never bundle files a user could not
otherwise reach. Confirm the generated archive respects file access on your site,
and remember that bundling many or large files is a server-resource operation, so
be mindful on entities with big attachment sets.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

This module has **no dedicated settings page** (`configure` is null). You set it up
by choosing its field formatter on a media reference field's *Manage display*, or
by placing its block — both described below.

## Where it lives in the admin menu

Media Download All adds no standalone settings page. You configure it in two
places:

- **Structure → … → Manage display** — set a media entity reference field's format
  to the *download all* formatter.
- **Structure → Block layout** (`/admin/structure/block`) — place the *download
  all* block in a region.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. To show the link inline with a field, go to the entity's **Manage display** and
   set your media reference field's formatter to the *download all* formatter.
3. Or, to place the link independently, add the *download all* block from **Block
   layout** to a suitable region.
4. When a visitor uses the control, the module gathers the referenced files,
   compresses them into a `.zip` in the private file system, and serves the
   download. Verify that the files being bundled are ones the visitor is allowed to
   access.
