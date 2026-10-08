# Folder Tree — manual setup guide

**Folder Tree** (`folder_tree`) adds an interactive, AJAX-driven browser for
exploring your **server's directory and file hierarchy** directly from the Drupal
admin UI — no SSH, FTP, or separate tooling required. It renders the filesystem as
an expandable tree, rooted at an admin-configured path, with lazy loading so even
large trees stay fast.

It fills the gap between the tools that can see server files (SSH, FTP, a hosting
control panel) and Drupal's own file/media browser (which only surfaces files
Drupal tracks — deployment artifacts, log files, and anything outside
`sites/default/files` are invisible to it). Folder Tree gives site builders,
developers, sysadmins, and multi-client agencies a permission-controlled,
**read-only** filesystem view inside Drupal. It offers lazy AJAX loading,
expand/collapse with keyboard navigation, a collapse-all button, file-type icons,
folder child-count badges, file-size tooltips, and a live search filter — and it
provides no way to upload, delete, move, or modify anything.

Security is built in: every AJAX request resolves the requested path with
`realpath()` and confirms it is a strict child of the configured root, so requests
cannot traverse outside it (symlinks pointing outside the root are blocked), and
the routes are gated by the module's permissions. That said, the tool still
**exposes filesystem structure and names** to anyone who holds the permission —
so grant it only to trusted administrators, and set the root path to the narrowest
directory you actually need (never `/`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the root path and grant the
   permission to the right people.

## Where it lives in the admin menu

Once enabled, Folder Tree provides a browser page and a settings form in the
admin area. Set the root path on the settings form, grant the `access folder
tree` permission at **People → Permissions**, and permitted users can then open
the tree browser to explore the configured directory.

## How to use it

Open the Folder Tree browser page as a permitted user. Click any folder to reveal
its contents (loaded on demand) and click again to collapse it; folders show a
badge with their child count before you expand them, and hovering a file shows its
human-readable size. Use the arrow keys to move around (↓/↑ between items, →
expands, ← collapses), the toolbar search box to filter loaded items by name, and
the collapse-all button to reset the view. Everything is read-only — it is a
viewer, not a file manager.
