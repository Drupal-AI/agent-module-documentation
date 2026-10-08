# Media entity download — manual setup guide

**Media entity download** (`media_entity_download`) gives every media item a
permanent download URL of the form `/media/{media}/download`. Visit that URL and the
media entity's underlying file streams to the browser as a forced "Save as…"
download. Because the URL is keyed by the media entity's ID rather than the physical
file path, it stays the same even when you replace the file behind the media item —
which is exactly what you want for press kits, resource libraries, and marketing
links that must not break.

Out of the box, the download is served with a `Content-Disposition: attachment`
header, so browsers pop the "Save as…" dialog instead of trying to render the file.
If you would rather let the browser decide (say, to preview a PDF inline), you can
add `?inline` to the URL. For a file field that holds several values, `?delta=N`
picks a specific file from the list.

The module gives you several ways to produce these links without writing code: a
**"Download link" field formatter** you can put on a media type's file or image
field, a **Views field** so listings of media can include a download column, and two
**Linkit substitutions** so authors can insert download links into rich‑text
content. Access is controlled by a dedicated `download media` permission combined
with normal view access to the media item. The module depends only on core's Media
module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no central settings page, so setting it up (the permission, the field
formatter, Views, and Linkit) is covered in *How to use it* below.

## Where it lives in the admin menu

There is **no global settings form** for this module. You work with it in a few
familiar places:

- The **`download media` permission** at **People → Permissions**
  (`/admin/people/permissions`).
- The **"Download link" formatter**, which you assign on a media type's
  **Manage display** page (**Structure → Media types → (your type) → Manage
  display**).
- The **"Link to download media file"** field in any View of media entities.

## How to use it

**1. Grant the download permission.** The download route is protected by the
`download media` permission *and* by view access to the media item — a user needs
both. Go to **People → Permissions**, find **Download media**, and tick it for the
roles that should be allowed to download. (You can also do this from the command
line, e.g. `drush role:perm:add anonymous 'download media'` to allow anyone.)

**2. Add download links where you want them.** Pick whichever fits:

- **Field formatter** — on a media type's file or image field, go to **Manage
  display**, and set the field's format to **Download link**. Each file then renders
  as a link to the download route. The formatter has one setting, **Download
  behavior** (see below).
- **Views field** — when building a View of media, add the field **Link to download
  media file** (default label "Download") to get a download link or column in the
  listing.
- **Linkit** *(optional, requires the [Linkit](https://www.drupal.org/project/linkit)
  module)* — two substitutions let content authors insert media download links into
  CKEditor: **`media_download`** for a forced "Save as…" download, and
  **`media_download_inline`** for browser‑default handling.

**3. Choose the download behavior.** The "Download link" formatter has a single
radio setting, **Download behavior**:

- **Force "Save as…" dialog** *(default)* — the browser downloads the file rather
  than opening it (`Content-Disposition: attachment`).
- **Browser default** — the browser decides how to handle the file, e.g. rendering a
  PDF or image inline. In this mode the link's `target` and `rel` attributes apply.

Because this is a formatter setting, it travels with your view‑display configuration
when you export config (`drush config:export`).

### Building a download URL directly

You don't have to use a formatter — the route works on its own. Link anyone to
`/media/{media}/download` (replacing `{media}` with the media entity's ID) to force a
download. Append `?inline` for browser‑default handling, or `?delta=N` to grab a
specific file from a multi‑value field. If the media item has no file, or the file
is missing from disk, the route returns a proper 404.
