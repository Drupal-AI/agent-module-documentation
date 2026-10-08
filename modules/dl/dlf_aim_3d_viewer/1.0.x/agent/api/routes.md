<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, controllers & permissions

All routes are in `dlf_aim_3d_viewer.routing.yml`; controllers in `src/Controller/`.
Permissions (`dlf_aim_3d_viewer.permissions.yml`): `administer dlf_aim_3d_viewer`
(restricted), `access dlf_aim_3d_viewer editor`, `access dlf_aim_3dmodels`.

## Admin / config

| Route | Path | Controller / form | Access |
|---|---|---|---|
| `dlf_aim_3d_viewer.config_menu` | `/admin/config/dlf_aim_3d_viewer` | `DlfAim3dViewerConfigForm` | `administer dlf_aim_3d_viewer` |
| `dlf_aim_3d_viewer.menu` | `/admin/config/dlf_aim_3d_viewer` | `SystemController::systemAdminMenuBlockPage` | `administer dlf_aim_3d_viewer` |

See [../config/settings.md](../config/settings.md).

## Editor API (permission `access dlf_aim_3d_viewer editor`)

These back the in-browser viewer/editor; each controller also rejects anonymous callers
explicitly (`AccessDeniedHttpException` when `currentUser()->isAnonymous()`), and the JS receives a
REST CSRF token via `dlf_aim_3d_viewer_attach_settings()`.

- **`dlf_aim_3d_viewer.save_metadata`** — `POST /api/editor/save-metadata` →
  `SaveMetadataController::save()`. Body JSON `{path, filename, content}`. `path` and `filename`
  are validated with strict allow-list regexes (`[a-zA-Z0-9._-]` segments); writes
  `public://<path>/metadata/<filename>_viewer.json` via `file_system->saveData()` (dir prepared
  with `prepareDirectory`).
- **`dlf_aim_3d_viewer.thumbnail_upload`** — `POST /api/editor/upload-thumbnail` →
  `ThumbnailUploadController::upload()`. Multipart `data` file + `filename`, `wisski_individual`,
  `path` fields (each regex-validated; `..` rejected; MIME limited to png/jpeg and re-checked with
  `getimagesize`). Saves `<name>_side45.<ext>` under `public://<relative>/views/`, then POSTs the
  saved real path to `<main_url>/wisski/dlf_aim_3d_viewer/<wisskiId>/savePreview`
  (`\Drupal::httpClient()`, 5s timeout).
- **`dlf_aim_3d_viewer.xml_export`** — `GET|POST /api/editor/xml-export/{id}` →
  `XmlExportController::export()`. Builds a METS/MODS XML document for the record: from a posted XML
  body, or by fetching the source over HTTP from the request `domain` (paths
  `/wisski/navigate/{id}/view`, `/export_xml_single/{id}`), or by fetching a JSON record
  (`/api/digital_reconstruction/record/{id}`) and enriching it from the local entity's model field.
  Transforms via an XSLT fetched from a fixed GitHub raw URL (`fetchXsl()`), reads any
  `<name>_viewer.json` sidecar for IIIF annotations, and caches the result to
  `public://xml_structure/<id>.xml`. Uses the injected `http_client` and `file_system`.

## Model API (permission `access content`)

- **`dlf_aim_3d_viewer.status`** — `GET /api/model/status/{id}` → `ModelController::status()`.
  Loads a `wisski_individual`/`node` by id and returns `{progress, status, message}` from the
  `field_processing_*` fields (`Cache-Control: no-store`).
- **`dlf_aim_3d_viewer.create`** — `POST /api/model/create` → `ModelController::create()`.
  Creates a `model` node with `field_processing_*` initialized, then launches
  `/opt/drupal/scripts/worker.sh <nid>` in the background and returns `{entity_id, status}`.

## WissKI manifest / savePreview

- **`entity.wisski_individual.manifest`** — `/wisski/dlf_aim_3d_viewer/{wisski_individual}/savePreview`
  → `DlfAim3dController::editEntity()`. This is the endpoint the thumbnail-upload flow forwards to on
  a WissKI host: it records the generated preview image as the `wisski_individual`'s configured
  `image_generation` field and returns `{id, path}` JSON.

## Notes

- `DlfAim3dController` constructs constants via `dlf_aim_3d_viewer_init_constants()`; `view()`
  simply returns the main URL as markup.
- `ModelController::create()` passes only the freshly generated integer node id to the background
  script (no request string reaches the shell); `ConvertProcessService` likewise runs the bundled
  scripts through Symfony `Process` with an **argument array** (no shell string), see
  [../pipeline/conversion.md](../pipeline/conversion.md).
