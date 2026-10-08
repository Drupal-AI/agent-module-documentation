# Delete form, route & bulk actions

The module has **no settings form** — nothing to configure in `data.json.configure` (it is
`null`). "Configuration" here means how deletion is wired up and how to enable it in the UI.

## How the delete form is installed

`FileDeleteHooks::entityTypeBuild()` (`#[Hook('entity_type_build')]`) runs:

```php
$entity_types['file']->setFormClass('delete', FileDeleteForm::class);
```

This overrides the form used at core's file delete route (`entity.file.delete_form`, path
`/file/{file}/delete`) with `Drupal\file_delete\Form\FileDeleteForm`, a
`ContentEntityConfirmFormBase`. No `*.routing.yml` is added — the module reuses the core route.

The confirm form asks *"Are you sure you want to delete the file %file_name (%file_uri)?"*,
confirm button "Delete File", and both cancel and post-delete redirect go to the Files view
(`view.files.page_1`).

## Delete behavior (`FileDeleteForm::submitForm()`)

1. Reads `file.usage` via `FileUsageInterface::listUsage($file)`.
2. If the file **is in use** and force/override is not chosen → aborts with an error that lists
   the using modules and links to the file's usages (`view.files.page_2`, arg = file id).
3. If overriding usage, it **deletes the `file` usage records** (`fileUsage->delete(...)`) so
   the file is no longer marked in use (it does not delete the referencing entity — that broken
   reference is the documented trade-off).
4. Then either:
   - **Immediate** (checkbox on, permission held): `$file->delete()` — file gone now.
   - **Default**: `$file->setTemporary(); $file->save();` — status flips `Permanent → Temporary`;
     Drupal's `file_cron()` deletes temporary files on a later cron run (core default keeps them
     ~6 hours, tunable at **Config → Media → File system**).

Two extra checkboxes appear only if the user has the matching permission (see
[permissions](../permissions/file_delete.md)):

| Checkbox | Field | Permission | Effect |
|---|---|---|---|
| Delete immediately | `instant_delete` | `delete files immediately` | Skip temporary/cron, delete now |
| Force delete | `force_delete` | `delete files override usage` | Delete despite usage records |

Their default checked state is read from a `file_delete.settings` config object
(`instant_delete`, `force_delete` keys). That config object ships **no default install file and
no schema entry**, so unless a site sets it (e.g. `drush cset file_delete.settings instant_delete 1`)
the defaults are effectively off.

## Adding the delete link in the UI (README steps)

1. Set permissions at **People → Permissions**.
2. Edit **Structure → Views → Files** and add the **"Link to delete File"** field.
3. A Delete link then shows for each file at **Content → Files**.

## Bulk action plugins (`type: file`)

Shipped as config in `config/install/` and usable as Views bulk operations / VBO on file lists:

| Action config id | Plugin id | Class | Effect |
|---|---|---|---|
| `mark_file_for_deletion` | `file_delete_mark_temporary` | `MarkFileForDeletion` | Usage check, then `setTemporary()` + `save()` |
| `immediate_delete` | `file_delete_immediately` | `ImmediateDeleteWithUsageChecks` | Usage check, then `FileSystem::delete($uri)` + delete the `file_managed` row |

Both call `listUsage()` first and refuse (with an error + usages link) if the file is in use;
both gate `access()` on the file entity's `delete` access. Config schema for the two actions is
in `config/schema/file_delete.schema.yml`. These action ids were renamed in update
`file_delete_update_400005()` (old ids `mark_file_for_deletion` / `immediate_delete`).
