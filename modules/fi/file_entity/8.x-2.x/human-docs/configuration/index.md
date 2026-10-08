# Configuration

File entity is configured in three places: the **file types** UI (where you define
bundles and attach fields), the **file settings** form, and the **permissions**
page. This page walks through each.

## File types (bundles)

Go to **Structure → File types** (`/admin/structure/file-types`) — this requires
the **Administer file types** permission. Here you create, edit, enable, disable,
and delete file types. Types are typically organised by MIME: *Image*,
*Document*, *Video*, *Audio*, and so on.

Because each type is an entity bundle, you can:

- **Attach fields** to it — captions, credits, rights statements, alt-text and
  other metadata — through the type's *Manage fields* tab.
- **Configure displays** — set how each field renders on the type's
  *Manage display* tab, and configure form displays for editing.

## File pages and management routes

Once file types exist, files gain their own routes:

| What | Path |
|------|------|
| View a file | `/file/{file}` |
| Download a file | `/file/{file}/download` |
| Edit a file | `/file/{file}/edit` |
| Inline edit | `/file/{file}/inline-edit` |
| Delete a file | `/file/{file}/delete` |
| Add a file | `/file/add` |
| File admin listing | `/admin/content/files` |
| Bulk delete / archive | `/admin/content/files/delete`, `/admin/content/files/archive` |

Each of these is gated by the appropriate entity access or permission (see
below).

## File settings

Go to **Configuration → Media → File settings**
(`/admin/config/media/file-settings`), which requires the **Administer files**
permission. This is the module's general settings form for file handling.

## Permissions

Grant these on **People → Permissions** to the appropriate roles. Several are
marked "restrict access" because they are powerful:

| Permission | What it allows |
|------------|----------------|
| `bypass file access` | View, edit, and delete all files regardless of restrictions (restrict access) |
| `administer files` | File administration, settings, and bulk operations (restrict access) |
| `administer file types` | Manage file types (restrict access) |
| `create files` | Add and upload new files |
| `view files` / `view own files` | View any / own files |
| `view private files` / `view own private files` | View private files (viewing any is restrict access) |

In addition, **per-file-type permissions** are generated automatically, so you can
grant creation and management rights type by type.

## Integrations

- **Views** — files and their fields are exposed to Views, so you can build file
  listings and searchable file repositories.
- **Token** — file fields are available as tokens for use in templates and other
  modules.
- **Display modes** — files render with field formatters via the view modes you
  configure on each type's *Manage display*.
