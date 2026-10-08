# File View Access — manual setup guide

**File View Access** (`file_view_access`) adds a **`file view access` permission**
that is *intended* to let uploaders decide, per file, whether a file may be viewed
only by users who hold that permission. The idea is that instead of moving *all*
uploads into the private file system, you could mark individual files as restricted.

Its access check applies to file entities in the **public** scheme. For gating file
downloads, Drupal's built-in mechanism is the **private** file system (`private://`)
with download access logic (a `hook_file_download` implementation, or a module built
around private-file access).

The module depends on core **File**, provides its own permission, and supports
**Drupal 8 through 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and assign the permission.

There is **no settings form** for this module. Setup is limited to assigning the
permission and enabling the option on file fields, described in "How to use it"
below.

## Where it lives in the admin menu

File View Access adds no configuration page. Its permission appears at **People →
Permissions** (`/admin/people/permissions#module-file_view_access`), and the
per-field option appears in file field settings.

## How to use it

The module's own documented steps are:

1. Enable the module.
2. Grant the **file view access** permission to the roles that should hold it, at
   `/admin/people/permissions#module-file_view_access`.
3. Enable file view access on the file fields where you want the option.
4. When creating content, mark the individual files that should be subject to file
   view access.
