# File Download — manual setup guide

**File Download** (`file_download`) gives you field formatters that turn a file or
image field into a link that **forces the browser to download** the file (saving it
to disk as an attachment) instead of opening it inline in a browser tab. It is the
answer to "I want a proper *Download* button on my documents, not a preview."

You configure it per field on an entity's *Manage display* page — there is no
global settings screen. Pick the **File Download** formatter on a file or image
field and you get a download link whose text you control (the filename, the parent
entity's title, the field description, an icon only, or your own token-aware text),
with an option to append the file size. A second formatter, **File Download URI**,
outputs just the download URL as a string for use in custom templates or Views.

Behind the scenes the links point at a small module-provided route that streams the
file with the correct headers (`Content-Disposition: attachment`, MIME type,
length) so downloads are reliable across browsers — including files stored in
Drupal's **private** file system. Access to that route is gated by an *access file
download* permission and still respects core's private-file access rules. An
optional submodule, **File Download Counter**, tallies how many times each file is
downloaded and adds a Views field plus a "Popular content" block.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it (and optionally the download-counter submodule), and grant the permission.
2. [Configuration](configuration/index.md) — the two formatters and their settings,
   the download permission, and where the settings are stored.

## Where it lives in the admin menu

File Download has **no dedicated settings page**. You work with it in three places:

- **Manage display** for any content type / entity bundle, e.g.
  *Structure → Content types → Article → Manage display*
  (`/admin/structure/types/manage/article/display`) — this is where you choose the
  File Download formatter on a file or image field.
- **People → Permissions** (`/admin/people/permissions`) — grant *access file
  download* to the roles that should be allowed to download files.
- The **download links themselves** live at
  `/file-download/download/{scheme}/{fid}`, generated automatically by the
  formatter.
