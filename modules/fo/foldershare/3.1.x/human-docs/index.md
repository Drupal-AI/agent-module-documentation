# FolderShare — manual setup guide

**FolderShare** (`foldershare`) turns a Drupal site into a **file-and-folder
manager** — a private-cloud-drive experience built entirely in Drupal. Users get
their own folders, upload files with drag-and-drop, organise them into a hierarchy,
and share individual folder trees with other users or make them public. It
provides a graphical file browser that works much like Windows Explorer or macOS
Finder. Files are stored on the web server and tracked in the site database, and
access is governed by FolderShare's own permission set.

By default everything is private: users have exclusive access to their own files
and folders. They can then choose to share a folder tree with specific users (with
View or Edit rights) or make it public. Sharing always happens from the **top-most
level** of a folder tree — everything inside a top-level folder inherits the same
access privileges. FolderShare is a substantial subsystem: its
[permissions](configuration/index.md) are its real control surface, so grant them
deliberately (especially the separate "share publicly" permission).

FolderShare sits at the helm of the SeedMeLab project and pairs with companion
modules — **FolderShare REST** (for managing data via a REST client and its
command-line tool), and **Chart Suite** / **Formatter Suite** for richer
displays.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, meet the
   PHP/database requirements, and enable the module.
2. [Configuration](configuration/index.md) — the permission set, the minimal
   settings form, the usage report, and cron.

## Where it lives in the admin menu

FolderShare spreads across a few admin locations:

- **People → Permissions** (`/admin/people/permissions#foldershare`) — the
  role-based permissions that grant the module's capabilities.
- **Structure → FolderShare** (`/admin/structure/foldershare`) — the minimal
  settings (storage filesystem, allowed file extensions, usage-report rebuild
  interval).
- **Reports → FolderShare** (`/admin/reports/foldershare`) — a usage summary for
  all site users.
- **Help → FolderShare** (`/admin/help/foldershare`) — the module's own detailed
  help page, worth reading carefully.

## How to use it

Users work with their files through FolderShare's routes:

- **`/foldershare`** — the current user's own files and folders.
- **`/foldershare/shared`** — items shared with the user.
- **`/foldershare/public`** — publicly shared items.
- **`/foldershare/all`** — an administrator-only view of everything.

Within the browser, users can create folders, upload files (drag-and-drop),
move, copy, duplicate, rename, describe, search, download, and delete items — as
far as their permissions allow. To share, a user opens a top-level folder's share
settings and grants View or Edit access to specific users, or makes it public
(if they hold that permission).
