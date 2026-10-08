<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — admin UI & the four workflows

There is **no settings/config form** — the module has no `config/install` settings object
(the Manual form is a `ConfigFormBase` but only holds the last-submitted values, not real
configuration). Setup is just: enable the module and use the four workflows below. It ships
two Views (`config/install/views.view.fancy_file_delete.yml`,
`views.view.fancy_file_list_unmanaged.yml`).

Enable: `drush en fancy_file_delete -y` (pulls in `views_bulk_operations`).

## Landing page

- Route `fancy_file_delete.info` → `/admin/config/content/fancy_file_delete`
  (Admin → Config → Content → Fancy File Delete). Permission: `administer fancy file delete`.
  Just an info page listing the four options (LIST / MANUAL / ORPHANED / UNMANAGED).

## 1. LIST (managed files + VBO)

The `fancy_file_delete` view lists every row in `file_managed`. Each row is selectable and
two VBO actions are offered:

- **Delete Files** (`delete_files_action`) — normal delete (`File::delete()`); skips files
  still referenced in `file_usage`.
- **FORCE Delete Files (No Turning Back!)** (`delete_files_action_force`) — force delete:
  removes the `file_managed` + `file_usage` rows and deletes the entity outright.

## 2. ORPHANED

Not a separate page — it is a **Views filter** named **"Orphan File Delete"**
(`ffd_orphan_filter`, added to `file_managed` via `hook_views_data_alter`). Add it to the
LIST view (or a clone) to show only orphans. "Orphan" = a managed file whose only
`file_usage` reference is of type `node` where that node no longer exists:

```sql
SELECT fm.* FROM file_managed fm
  LEFT OUTER JOIN file_usage fu ON fm.fid = fu.fid
  LEFT OUTER JOIN node n ON fu.id = n.nid
  WHERE fu.type = 'node' AND n.nid IS NULL
```

Delete matched rows with the same VBO actions (force needed when a stale usage row blocks a
normal delete).

## 3. MANUAL (delete by FID)

- Route `fancy_file_delete.manual` → `/admin/config/content/fancy_file_delete/manual`
  (the "Manual" tab). Form `fancy_file_delete_manual`.
- Fields: a **FORCE file deletion?** checkbox and a **FID Numbers** textarea (one FID per
  line). Submit button reads "Engage". Blank textarea is rejected.
- Submitting hands the FID list + force flag to `fancy_file_delete.batch`.

## 4. UNMANAGED (files on disk not in file_managed)

The `fancy_file_list_unmanaged` view lists an `unmanaged_files` content entity table that
the `fancy_file_delete.unmanaged_files` service populates by scanning the public (and
private) files directories and diffing against `file_managed`. Opening the view / clicking
**Update View** re-runs the scan (`UnmanagedFilesService::updateView()`). By default the
first scan covers `public://` only; the directory filter lets you choose directories (stored
in State key `fancy_file_delete_unmanaged_chosen_dirs`). Delete rows with the VBO actions;
for unmanaged rows the batch deletes the file from disk and its `unmanaged_files` row.

## Force vs normal delete (important)

A **normal** delete calls `$file->delete()`, which **returns without deleting** when the
file is still referenced in `file_usage` (you get a "still referenced" notice). A **force**
delete deletes the `file_managed` row, the `file_usage` row(s), and the file entity
directly — use it for orphaned/stuck files. See [../api/services.md](../api/services.md).
