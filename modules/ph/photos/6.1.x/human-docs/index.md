# Photos — manual setup guide

**Photos** (`photos`) is a full photo-album and picture-management suite for Drupal.
Enabling it gives you a ready-made **Photo album** content type: each album is a node,
and the pictures inside it are stored as dedicated `photos_image` entities. Editors can
upload many images at once, set a cover image, reorder photos, and let visitors comment
on them — the kind of gallery experience that would otherwise take a lot of assembly.

Uploading is flexible: single images, multi-image upload via Plupload, a whole ZIP
archive that gets extracted into the album, or a bulk import from a server directory.
Every image can be offered in several named sizes generated from core image styles, and
you choose which style is used in each context — the cover, list view, full view,
teaser, and pager thumbnails. Albums and users can show photo counts, photos are
searchable through core Search, and there is a media source so galleries can slot into
the Media Library.

Because the photos are real content entities, they plug into the rest of Drupal: Views
integration (a cover field and a "set cover" link), tokens, per-user galleries,
revisions, and translation all work. A companion submodule, **Photos access**, adds
per-album privacy — you can leave an album open, lock it, restrict it to a list of
users, or protect it with a password.

Photos is a larger module than most, so it has a genuine settings page for global
behaviour (image sizes, ordering, pager and per-page counts, cover/teaser display,
clean titles, ZIP and Plupload toggles, per-role upload limits) and a structure page
where you manage the fields and displays of the photo entity. It also defines seven
permissions for viewing, creating, editing, and deleting photos.

This guide is written for a **human**. For a terse, token-cheap reference aimed at an
AI coding agent — including the data model, the full settings keys, and every plugin it
provides — read the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it and its
   dependencies, and optionally the Photos access submodule.
2. [Configuration](configuration/index.md) — the global settings page, the structure
   page for managing photo fields/displays, and the permissions.

## Where it lives in the admin menu

The main settings form is at **Configuration → Media → Photos**
(`/admin/config/media/photos`). A structure page at **Structure → Photos**
(`/admin/structure/photos`) is where you manage the photo entity's fields and displays,
and all your photos are listed at **Content → Photos** (`/admin/content/photos`). Most
of these admin pages require the core **Administer nodes** permission.

## How to use it

Create a **Photo album** node (Content → Add content → Photo album), then upload images
into it — one by one, several at once with Plupload, or as a ZIP archive. Set a cover
image, drag photos to reorder them, and the album renders as a gallery with your chosen
image styles. Manage individual pictures (title, description, weight) as `photos_image`
entities. For privacy, enable the **Photos access** submodule and choose an album's
access mode (open, locked, user list, or password).
