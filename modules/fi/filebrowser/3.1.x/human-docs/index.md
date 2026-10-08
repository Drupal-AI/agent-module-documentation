# Filebrowser — manual setup guide

**Filebrowser** (`filebrowser`) turns a folder on your server into an FTP‑like,
browsable file listing rendered inside your Drupal site. Instead of an Apache
autoindex page or a real FTP account, visitors see a themed, permission‑controlled
table of files — with columns for icon, name, date, size, and type — and,
depending on their permissions, can download, upload, rename, delete, create
sub‑folders, or grab the whole folder as a zip archive.

Each listing is a **node** of the `dir_listing` content type that the module adds.
You create one, point it at a folder (using a Drupal stream URI such as
`public://docs` or `private://reports`), and choose the per‑listing rights and
presentation options right on the node edit form. Because it is a node, a listing
gets a URL, a path alias, and the same access controls as any other content.

Downloads can be served two ways: **public** (the browser is redirected straight
to the file) or **private** (Drupal streams the file so it can enforce your
permissions on every download). Filebrowser also supports remote file systems such
as Amazon S3 or Dropbox when the Flysystem module and an adapter are configured,
and its listing columns can be extended by other modules — the bundled
**Filebrowser Extra** submodule demonstrates this by adding a "Modified" column.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and note the optional Extra submodule and Flysystem.
2. [Configuration](configuration/index.md) — the global defaults form, the
   per‑listing settings on the node form, and the permissions you must grant.

## Where it lives in the admin menu

The global defaults form is at **Configuration → System → Filebrowser**
(`/admin/config/system/filebrowser`). Individual listings are created like any
content, at **Content → Add content → Directory listing**
(`/node/add/dir_listing`). Permissions are granted at **People → Permissions**
(`/admin/people/permissions`).

## How to use it

1. Enable the module and grant the permissions each role needs (nothing is granted
   by default — see [Configuration](configuration/index.md)).
2. Optionally open the global settings form to set the defaults every new listing
   should inherit.
3. Create a **Directory listing** node, enter the folder URI it should expose, and
   choose its rights (uploads, zip download, sub‑folders) and presentation (list
   or grid view, visible columns, sort order).
4. Save and visit the node — the folder's contents appear as a browsable listing,
   with whatever actions you allowed.
