<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — storage types (bundles)

Storage types are **config entities** (`storage_type`, config prefix
`storage.storage_type.<id>`, class `Entity\StorageType extends ConfigEntityBundleBase`).
Manage them at **`/admin/structure/storage_types`** (add form `/admin/structure/storage_types/add`).
The bundle admin permission is `administer site configuration`.

## Config properties (`config_export`)

| Property | Type | Default | Meaning |
|---|---|---|---|
| `id` | string | — | Machine name (bundle id). |
| `label` | string | — | Human label (shown on `/storage/add`). |
| `description` | string | `''` | Shown on the add page. |
| `help` | string | `''` | Guidance shown atop the create/edit form. |
| `new_revision` | bool | `TRUE` | Create a new revision by default. |
| `revision_expose` | bool | `FALSE` | Show the "Create new revision" checkbox on the form. |
| `revision_log` | bool | `FALSE` | Show a revision-log text field (only when revision_expose). |
| `name_pattern` | string | `''` | Token pattern to auto-generate the entity `name` on save. |
| `status` | bool | `TRUE` | Whether new items of this type are published by default. |
| `has_canonical` | bool | `FALSE` | Give items a canonical view URL (`/storage/{id}`); else that redirects to edit. |

The `StorageTypeForm` also exposes a **"Form label for name field"** (edits the `name` field
label) — that is stored on the field config, not on the storage type.

## Name pattern (tokens)

`name_pattern` is applied on every save (`StorageInterface::applyNamePattern()`), replacing
tokens like `[storage:string-representation]`. Use it to auto-name entities and then hide the
`name` widget in *Manage form display*. Requires the Token module for the token-browser link
(patterns still work without it).

## Create a storage type via drush / code

```bash
drush php:eval '
  \Drupal\storage\Entity\StorageType::create([
    "id" => "api_log",
    "label" => "API Log",
    "description" => "Stored API responses",
    "new_revision" => TRUE,
    "status" => TRUE,
    "has_canonical" => FALSE,
    "name_pattern" => "[storage:string-representation]",
  ])->save();
'
```

Read one back: `drush config:get storage.storage_type.api_log`.
Add fields with Field UI at `/admin/structure/storage_types/api_log/fields` (or the usual
`FieldStorageConfig`/`FieldConfig` on entity type `storage`, bundle `api_log`).
