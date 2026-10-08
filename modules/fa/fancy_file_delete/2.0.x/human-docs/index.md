# Fancy File Delete — manual setup guide

**Fancy File Delete** (`fancy_file_delete`) is an administrative housekeeping tool
for removing files that Drupal's normal UI cannot easily clear. It handles three
awkward cases: **managed** files by their file ID (FID), **orphaned** managed
files that are still referenced only by nodes that no longer exist, and
**unmanaged** files sitting on disk that were never recorded in Drupal's
`file_managed` table. It is the tool you reach for to reclaim disk space after a
content migration, clear QA/test uploads, or fix "file still referenced" errors
during content deletion.

A key concept is **normal vs. force delete**. A normal delete refuses to remove a
file that is still referenced (you get a "still referenced" notice). A **force**
delete bypasses that — it deletes the `file_managed` and `file_usage` rows and the
file entity directly — so it is the way to clear orphaned or stuck files. Force
delete is irreversible, so use it deliberately.

The module adds an admin section, bulk actions on file listings (via Views Bulk
Operations), and a Drush command. Note it has **no settings form** — the admin
landing page just points you at the four workflows below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Views Bulk
   Operations dependency) with Composer and enable it.

## Where it lives in the admin menu

The tool is at **Configuration → Content authoring → Fancy File Delete**
(`/admin/config/content/fancy_file_delete`) — an info page listing the four
options. Access to the main pages is gated by the **Administer fancy file delete**
permission.

## How to use it

There is nothing to configure — enable the module and use whichever of the four
workflows fits:

1. **LIST** — a view of every managed file with checkboxes and two bulk actions:
   **Delete Files** (a normal delete, which skips files still in use) and **FORCE
   Delete Files (No Turning Back!)** (a force delete). Good for clearing a large
   set of files without clicking each one.
2. **MANUAL** — a form (the *Manual* tab) where you paste a list of FIDs, one per
   line, tick **FORCE file deletion?** if needed, and submit. Good for deleting a
   few specific problem files.
3. **ORPHANED** — a Views filter named **Orphan File Delete** you add to the LIST
   view (or a clone) to show only orphaned files — managed files whose only usage
   is a node that no longer exists. Delete the matches with the same bulk actions
   (force is usually needed since the stale usage row blocks a normal delete).
4. **UNMANAGED** — a view that scans your public (and private) file directories for
   files that are not in `file_managed`. Clicking **Update View** re‑runs the scan;
   the first scan covers `public://` by default, and a directory filter lets you
   narrow it. Delete rows with the bulk actions to remove the files from disk.

## Permissions

Grant these at **People → Permissions** (`/admin/people/permissions`):

| Permission | What it allows |
|-----------|----------------|
| **Administer fancy file delete** | Use the tool — the LIST, MANUAL, and ORPHANED workflows all sit behind this. This is the main "can use it" permission. |
| **View / Add / Edit / Delete unmanaged files entities** | Standard CRUD for the unmanaged‑files listing (the UNMANAGED workflow). You can delegate just these to a non‑admin role. |
| **Administer unmanaged files entities** | The admin form for the unmanaged‑files entity type — access‑restricted, so treat it as admin‑only. |

> On multi‑user sites where files are owned by different accounts, deleting other
> users' files may require a core patch — see the project's README / issue
> #3169116.

## Drush

The module ships one command for deleting files by FID from the command line —
handy in deploy or cron scripts:

```bash
# Delete one managed file by FID (interactive confirm)
drush fancy:file-delete 12

# Alias, several FIDs, non-interactive
drush ffd 12,15,20 -y

# Force-delete a stuck/orphaned file
drush ffd 12 --force -y
```

Pass numeric FIDs; add `--force` for the force‑delete behavior, and Drush's global
`-y` to skip the confirmation prompt in scripts.
