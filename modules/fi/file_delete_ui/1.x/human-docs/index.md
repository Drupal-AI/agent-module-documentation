# File delete — manual setup guide

**File delete** (`file_delete_ui`) adds a working **Delete** operation for file
entities to Drupal's admin Files listing. Out of the box Drupal core has no UI for
deleting a managed file — the Files view at `/admin/content/files` simply offers
no delete link. This module fills that gap, letting trusted administrators remove
managed files straight from the admin screen instead of resorting to Drush or
direct database edits.

It works the moment you enable it: there is **no settings form and nothing to
configure**. On install it adds an Operations column to the core Files view so a
**Delete** link appears, gives file entities a delete confirmation form at
`/file/{file}/delete`, and overrides file access so deletion becomes grantable.
The only thing you decide is *who* may delete files, via a single permission (see
below). It depends on core's **File** module and ships no submodules.

One deliberate behaviour worth understanding: the module trusts the admin. It will
delete a file **even when that file is still in use** (non‑zero usage count) — and
Drupal core then cleans up the now‑dangling references from other entities. That
makes it powerful for cleanup, but means the person with the permission should know
what they are removing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The Delete operation appears in the **Content → Files** listing
(`/admin/content/files`), in the Operations dropdown for each file. The delete
confirmation page for a single file is at `/file/{file}/delete`. The permission
that controls it lives on **People → Permissions** (`/admin/people/permissions`).

## How to use it

### Grant the permission

The module adds one permission, **Delete any file**, which is flagged as
security‑sensitive (restricted access) on the Permissions page. Go to **People →
Permissions** and grant it to the roles that should be allowed to delete files. A
user may delete a file if **either**:

- they hold the **Delete any file** permission (they can then delete *any* file on
  the site), **or**
- they are the file's **owner** (the file's uid matches theirs) — so you can let
  people clean up their own uploads without handing out the site‑wide permission.

All other file operations (view, download, update) are unchanged from core.

### Delete a file

1. Go to **Content → Files** (`/admin/content/files`).
2. Find the file and choose **Delete** from its Operations dropdown.
3. Confirm on the delete form (`/file/{file}/delete`).

The file's `file_managed` record and its physical copy are removed. If the file
was still referenced elsewhere, core strips those references as part of the
delete. Because the file entity now has a `delete-form` link template, you can also
add the Delete operation to your own file‑listing Views.
