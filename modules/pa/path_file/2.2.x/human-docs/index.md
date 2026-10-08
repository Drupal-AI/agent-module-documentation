# Path File — manual setup guide

**Path File** (`path_file`) gives you a downloadable file at a **stable, permanent
URL** that survives replacing the file. It solves a familiar Drupal annoyance:
when you upload a new version of a document, Drupal keeps the old file and names
the new one `report_0.pdf`, `report_1.pdf`, and so on — which quietly breaks the
link you already printed on marketing material or shared with a partner.

The module adds a small content entity called a **Path File**. Each Path File
holds an uploaded file plus an editable URL alias (for example
`/downloads/brochure`). Visiting that alias streams the current file. Because you
can edit the Path File and swap in a new upload *without changing the alias*, the
public download URL stays constant forever — links from content, menus, emails,
QR codes, or external systems keep working. Editors manage these as ordinary
content with add/edit/delete forms, no developer required, and the entity is
available to Views if you want to build custom listings of your downloads.

Path File has one small settings form controlling which file extensions may be
uploaded, and a full set of permissions so you can decide who may add, edit,
delete, and download files. Out of the box it grants everyone (anonymous and
logged‑in users) permission to view published Path Files, so downloads work
immediately — you can tighten that if you want private downloads. It has no
plugins, hooks, or Drush commands; it's a compact, self‑contained content‑entity
feature.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Everything sits under **Content → Path files** (`/admin/content/path_file`):

- The **list** of all Path Files is at `/admin/content/path_file`.
- **Add path file** is at `/admin/content/path_file/add`.
- The **settings** form (allowed file extensions) is at
  `/admin/content/path_file/settings`.
- Each file is served from its alias, which points at the canonical route
  `/path-file/{id}`.

> In earlier releases (2.1.x) these pages lived under *Structure*
> (`/admin/structure/path_file_entity`); as of 2.2.x they moved under *Content*.

## How to use it

### Create a download

1. Go to **Content → Path files → Add path file**.
2. Give it a **name**, **upload** the file, and set the **URL alias** — the
   stable public path, e.g. `/downloads/report`.
3. Save (published). Visiting `/downloads/report` now streams the file.

To publish a new version later, edit the same Path File, upload the replacement,
and save. The alias doesn't change, so every existing link keeps working.

### Choose which file types are allowed

Open **Content → Path files → Settings**
(`/admin/content/path_file/settings`). The single **Allowed extensions**
field is a space‑separated list, just like a normal file field. The shipped
default allows common document and image types
(`pdf jpg jpeg gif png txt doc xls ppt pps odt ods odp`). Narrow it for security
or widen it as needed and save — the upload field updates to match. (You can also
set it from the command line with
`drush cset path_file.settings allowed_extensions 'pdf svg webp' -y`.)

### Control who can do what

The module ships a full permission set on the **People → Permissions** page:

- **Administer path file entity entities** — full admin (gates the settings form
  and unlocks the extra publish / save‑as‑unpublished buttons on the edit form).
- **Add / Edit / Delete path file entity entities** — the individual create,
  update, and delete operations, so you can give a "downloads editor" role just
  these without full site admin.
- **Access the path files overview page** — see the admin list.
- **View published path file entity entities** — download a published file.
- **View unpublished path file entity entities** — download an unpublished file.

At install, *view published* is granted to both the **anonymous** and
**authenticated** roles so downloads work out of the box (a deliberate,
node‑like default). To make downloads **private**, revoke *view published* from
anonymous/authenticated and grant it only to trusted roles — or unpublish the
Path File and rely on *view unpublished*.
