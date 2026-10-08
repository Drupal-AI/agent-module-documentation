# File Delete — manual setup guide

**File Delete** (`file_delete`) lets administrators delete managed file entities —
both public and private — straight from the Drupal admin UI. It replaces core's
plain file delete form with a smarter one that checks whether the file is still in
use, offers an optional immediate delete, and (for trusted roles) a force delete.

By default, deleting a file with this module does not remove it from disk right
away. Instead the file's status changes from *Permanent* to *Temporary*, and
Drupal's normal cron cleanup (`file_cron()`) removes temporary files on a later run
— after about six hours by default, which you can adjust on core's File System
settings. Before it does anything, the form checks the file usage records: if the
file is still registered as in use, it refuses to delete and links you straight to
the file's usages so you can see which modules or entities depend on it.

Two permission-gated checkboxes extend that safe default. **Delete files
immediately** skips the temporary step and removes the file at once, and **Delete
files override usage** deletes even a file that has usage records — which can leave
broken links or media, so the form warns you first. The module also ships two bulk
actions for a Files view — *Mark file for deletion* and *Immediately delete* — both
of which run the same usage check. It depends only on core's **File** module and
adds no settings form of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the delete permissions.

## Where it lives in the admin menu

There is no configuration page. File Delete works by taking over the file entity's
delete form, so its behavior appears wherever you delete a file — most commonly
from an administrative **Files** listing view. The permissions that unlock
immediate and force deletion are granted at **People → Permissions**
(`/admin/people/permissions`).

## How to use it

1. From an admin Files view, add a **Link to delete File** field (or use the
   built-in delete link) so each file row has a delete action.
2. Clicking delete opens an "Are you sure?" confirm form showing the filename and
   URI. Confirming marks the file temporary for cron to clean up later — unless
   the file is still in use, in which case the delete is blocked and you get a
   link to its usages.
3. For users who hold the extra permissions, the confirm form also offers
   **delete immediately** (skip cron) and **override usage** (delete anyway,
   removing the usage records). Use override with care — it can break links or
   media that still point at the file.
4. To clean up many files at once, use the **Mark file for deletion** or
   **Immediately delete** bulk actions in a Files view.
