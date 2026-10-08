# The `path_file_entity` content entity

A `ContentEntityType` (`Drupal\path_file\Entity\PathFileEntity`) — the module's entire feature.
Uses `EntityChangedTrait` + `EntityOwnerTrait`.

## Base fields (`baseFieldDefinitions()`)

| Field | Type | Notes |
|---|---|---|
| `name` | string (max 50) | Label field (`entity_keys.label`). **Required** (`setRequired(TRUE)`). |
| `path` | `path` | **URL alias** for the file. `setCustomStorage(TRUE)` — stored in the core `path_alias` table, not a column. Widget type `path`. Required, translatable. |
| `fid` | `file` | The uploaded file. **Required.** `file_extensions` setting is read from `path_file.settings.allowed_extensions` at definition time. |
| `user_id` | entity_reference (user) | Owner. Default value from `EntityOwnerTrait::getDefaultEntityOwner` (current user). |
| `status` | boolean | Publishing status, default TRUE. |
| `created` / `changed` | created / changed | Timestamps (`EntityChangedTrait`). |

`entity_keys`: `id`, `label` = name, `uuid`, `owner` = user_id, `langcode`, `status`.
`base_table = path_file_entity`. `admin_permission = administer path file entity entities`.

## How the alias serves the file

- Links: `canonical = /path-file/{path_file_entity}`, plus `add-form`, `edit-form`, `delete-form`,
  `collection` — all now under **`/admin/content/path_file`** (moved from `/admin/structure/…`).
- Route `entity.path_file_entity.canonical` → `PathFileController::file()`:

```php
$fid  = $path_file_entity->getFid();               // target_id of the file field
if (empty($fid)) { throw new NotFoundHttpException(); }
$file = $this->entityTypeManager->getStorage('file')->load($fid);
if (!$file instanceof FileInterface) { throw new NotFoundHttpException(); }
$server_path = $this->fileSystem->realpath($file->getFileUri());
if ($server_path === FALSE || !file_exists($server_path)) { throw new NotFoundHttpException(); }
$response = new BinaryFileResponse($server_path);   // streams the file
```

- The controller also advertises **cache tags** (`X-Drupal-Cache-Tags` = merged path_file entity +
  file entity tags) and sets **`Last-Modified`** from the entity's changed time, so reverse proxies
  invalidate correctly and HTTP conditional requests (`If-Modified-Since`) can short-circuit.
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
- `route_provider.html` = `PathFileEntityHtmlRouteProvider` (extends `AdminHtmlRouteProvider`; adds
  the collection + settings routes).
- Forms: default/add/edit = `PathFileEntityForm` (adds Save-and-publish / Save-as-unpublished
  dropbuttons for users with the admin permission); delete = core `ContentEntityDeleteForm`.

No plugin types, no hooks (`path_file.module` is empty), no Drush commands.
