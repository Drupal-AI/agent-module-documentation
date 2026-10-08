# The `path_file_entity` content entity

A `ContentEntityType` (`Drupal\path_file\Entity\PathFileEntity`) — the module's entire feature.

## Base fields (`baseFieldDefinitions()`)

| Field | Type | Notes |
|---|---|---|
| `name` | string (max 50) | Label field (`entity_keys.label`). |
| `path` | `path` | **URL alias** for the file. `setCustomStorage(TRUE)` — stored in the core `path_alias` table, not a column. Widget type `path`. |
| `fid` | `file` | The uploaded file. `file_extensions` setting is read from `path_file.settings.allowed_extensions` at definition time. |
| `status` | boolean | Publishing status, default TRUE. |
| `created` / `changed` | created / changed | Timestamps (`EntityChangedTrait`). |
| `user_id` | (owner) | Set in `preCreate()` to the current user. |

`entity_keys`: `id`, `label` = name, `uuid`, `langcode`, `status`. `base_table = path_file_entity`.
`admin_permission = administer path file entity entities`.

## How the alias serves the file

- Links: `canonical = /path-file/{path_file_entity}`, plus `add-form`, `edit-form`, `delete-form`,
  `collection` under `/admin/structure/path_file_entity`.
- Route `entity.path_file_entity.canonical` → `PathFileController::file()`:

```php
$fid  = $path_file_entity->getFid();               // target_id of the file field
$file = $this->entityTypeManager->getStorage('file')->load($fid);
$path = $this->fileSystem->realpath($file->getFileUri());
return new BinaryFileResponse($path);              // streams the file
```

- The entity's `path` field creates a **path alias** (e.g. `/downloads/report`) that points at the
  canonical `/path-file/{id}`. So the alias is the stable public URL; editing the Path File to
  upload a new file keeps the same alias and canonical route → the link never changes.
- Access on the canonical route is `_entity_access: path_file_entity.view`, evaluated by
  `PathFileEntityAccessControlHandler` (published → needs *view published*, unpublished → *view
  unpublished*).

## Create one programmatically

```php
// A managed file must already exist (fid).
$pf = \Drupal::entityTypeManager()->getStorage('path_file_entity')->create([
  'name'   => 'Brochure',
  'fid'    => $fid,
  'status' => 1,
  'path'   => ['alias' => '/downloads/brochure'],  // path field accepts an alias
]);
$pf->save();
```

Read the alias back: `$pf->get('path')->alias`. Read the file id: `$pf->getFid()`.

## Handlers

- `list_builder` = `PathFileEntityListBuilder`; `views_data` = `PathFileEntityViewsData` (usable in Views).
- `route_provider.html` = `PathFileEntityHtmlRouteProvider`.
- Forms: default/add/edit = `PathFileEntityForm` (adds Save-and-publish / Save-as-unpublished
  dropbuttons for users with the admin permission); delete = core `ContentEntityDeleteForm`.

No plugin types, no hooks (`path_file.module` is empty), no Drush commands.
