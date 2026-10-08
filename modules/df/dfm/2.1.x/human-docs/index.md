# Drupella File Manager — manual setup guide

**Drupella File Manager** (`dfm`) is a web-based file manager with a drag-and-drop
interface powered by AJAX. It gives permitted users a fast, familiar way to browse,
upload, move, rename, copy, delete and (for images) resize or crop files right
inside your Drupal site — without leaving to an external tool. This documentation
covers the **Lite** version, which offers file operations, multiple upload with
progress, sorting, and switching between icon and list views, with a small
JavaScript footprint that renders even large folders quickly.

The heart of DFM is its **configuration profiles**. A profile defines which
folders a user can see, what they can do in each folder (browse, upload, delete,
and so on), which file extensions and sizes are allowed, and per-user disk quotas.
You then map each profile to one or more user roles for a given file-storage
scheme (for example the public or private filesystem). Until you create a profile
and assign it to a role, only user 1 can reach the file manager — so DFM is
locked down by default. Once mapped, users open it at `/dfm/{scheme}` (for
example `/dfm/public`).

DFM also integrates with the editor and field layers of your site: it can add
image and file buttons to a **CKEditor 5** text format, act as the file browser
for **BUEditor**, and add a "select file" option to file and image field widgets.
It supports private file systems, token-based folder names, and custom stream
wrappers such as Amazon S3.

> **Note on the file library:** DFM Lite depends on a small JavaScript library
> (the "DFM Lite Library") that ships alongside the module. Follow the module's
> README for placing that library if your build does not include it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create profiles, set folder
   permissions and limits, and map profiles to roles per scheme.

## Where it lives in the admin menu

The settings form and profile list live at **Configuration → Media → Drupella
File Manager** (`/admin/config/media/dfm`), gated by the **administer dfm**
permission. Users then access the file manager itself at `/dfm/{scheme}` — for
example `/dfm/public`.
