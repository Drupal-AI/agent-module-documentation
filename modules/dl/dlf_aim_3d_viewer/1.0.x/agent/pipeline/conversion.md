<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Model conversion pipeline

Turns an uploaded source model into a web-ready **GLB** plus preview thumbnails. Only runs when
**lightweight mode is off** (`dlf_aim_3d_viewer_lightweight = false`). Lightweight sites skip all of
this and serve the uploaded model directly to the viewer.

## Trigger: entity-save hooks (`.module`)

`hook_entity_presave`, `hook_entity_insert` and `hook_entity_update` each:

1. Bail if `$GLOBALS['dlf_aim_3d_viewer_worker_running']` is set (so the worker's own re-saves don't
   recurse) or if `$entity->bundle()` is not the configured `dlf_aim_3d_viewer_entitybundle`.
2. Resolve the source file id from the configured `viewer_file_upload` field, with fallbacks:
   `dlf_aim_3d_viewer_resolve_current_file_reference()` → configured field, then any
   `file`/`entity_reference(file)` field (`detect_file_field_fallback`), then a `state`-stored
   "last file id" (`dlf_aim_3d_viewer_load_last_file_id`). Helper
   `dlf_aim_3d_viewer_extract_file_id()` maps target_id/fid/uri values (and
   `location_to_public_uri()` maps `/sites/default/files/…` → `public://…`) to a file entity id.
3. Set `field_processing_progress=0`, `field_processing_status='queued'`,
   `field_processing_message` on the entity.
4. `createItem()` on queue **`dlf_aim_3d_viewer_convert`** with
   `{entity_type, entity_id, file_id, source_filename, source_uri}`, store the last file id in state,
   and call `dlf_aim_3d_viewer_kick_convert_worker()`.

A presave/insert dedupe key (`$GLOBALS['dlf_aim_3d_viewer_enqueued_in_presave']`) avoids
double-enqueue across the hook sequence.

## Background runner: `dlf_aim_3d_viewer_kick_convert_worker()`

Spawns a **detached** Drush queue runner so conversion outlives the request:

- Acquires lock `dlf_aim_3d_viewer_convert_runner_kick`; skips if a persistent worker is already
  live. Liveness is tracked by a PID file `/opt/drupal/dlf_aim_3dworker.pid`
  (`has_persistent_convert_worker()` uses `posix_kill($pid,0)` or `/proc/<pid>`).
- Finds the drush binary (`find_drush_binary()` checks `vendor/bin/drush`), assembles
  `drush [--uri=<safe site url>] queue:run dlf_aim_3d_viewer_convert --time-limit=30`, wraps it in a
  timestamping `awk` pipe to log `/opt/drupal/dlf_aim_3dworker.log`
  (`build_timestamped_queue_runner_command()`, args `escapeshellarg`-escaped), and runs it with
  `Process::fromShellCommandline(..., DRUPAL_ROOT, $env)` (HOME/COMPOSER_HOME/XDG_CONFIG_HOME set).
- The `--uri` is only added when the current request host or configured `main_url` is a real
  absolute URL (rejects `_`/`default` placeholder hosts).

## Worker: `ConvertWorker` (`src/Plugin/QueueWorker/ConvertWorker.php`, id `dlf_aim_3d_viewer_convert`)

`processItem($data)`:

- Loads the entity and resolves `file_id` (queue value → entity field → state fallback); skips if
  none. Takes a per-entity/file lock (`dlf_aim_3d_viewer_convert_<type>_<id>_<fid>`).
- Sets `$GLOBALS['dlf_aim_3d_viewer_worker_running']=TRUE` (suppresses the save hooks), then
  `convertFile()`:
  - If the upload extension is a **zip format** (`ModelFormatManager::getZipFormats()`: zip, rar,
    tar, xz, gz) it first calls `ConvertProcessService::uncompress($module_path, $type, $realpath,
    $extract_path, $filename)` (runs `scripts/uncompress.sh`).
  - Then `ConvertProcessService::run(...)` (runs `scripts/convert.sh`) to produce the GLB, with a
    progress callback writing `field_processing_*`. In full (non-lightweight) mode `run()` then
    invokes `render()` (`scripts/render.sh`, Blender) to generate `_side*.png` / `_top.png`
    thumbnails unless they already exist.
- `applyViewerFields()` / `ensureModelFieldsPersisted()` / `ensureImageFieldPersisted()` write the
  converted-model path back to the derivative field (`viewer_file_name`) and the rendered images to
  the `image_generation` field, then set final `field_processing_status`.

`ModelFormatManager` (`dlf_aim_3d_viewer.model_format_manager`) is the allow-list source:
`getAllowedModelFormats()` (abc, obj, fbx, ply, dae, ifc, stl, xyz, pcd, json, 3ds, blend, gml,
wrl, glb, gltf) + `getZipFormats()`; `getAllFormats()` merges them.

## `ConvertProcessService` (`dlf_aim_3d_viewer.convert_process`)

Thin wrapper over `Symfony\Component\Process\Process`. `run()`, `render()` and `uncompress()` each:

- build an **argument array** (script path + `-t/-c/-l/-b/-i/-o/-f/-a` flags and values) — never a
  shell string, so arguments are passed literally to the binary,
- `setWorkingDirectory($spath)` (the module dir), `setTimeout` (default 600s), `run()`, and return
  `{success, exit_code, output, error, command}`.

Output GLB path is derived from the input path (`<dir>/gltf/<name>.glb`); thumbnails at
`<dir>/views/<name>_side45.png` etc. (`resolveConvertedOutputPath`, `resolveThumbnailBasePath`).

## Bundled scripts (`scripts/`)

`convert.sh`, `render.sh`, `uncompress.sh`, `worker.sh`, plus Python/Blender helpers
(`render.py`, `2gltf2/`, `CityGML2OBJv2/`, `convert-blender-to-gltf.py`) and the `IfcConvert`
binary. These are the executables the services above call; they require Blender / the relevant CLI
tools to be present on the server. `scripts/progress.js` is a small front-end progress helper
(library `dlf_aim_3d_viewer.progress`).

## Operating it

- Ensure Blender + converters are installed and `/opt/drupal/scripts/worker.sh` is executable if you
  rely on `ModelController::create()`; otherwise conversion runs via the Drush queue runner kicked on
  entity save.
- Watch `/opt/drupal/dlf_aim_3dworker.log` and the `dlf_aim_3d_viewer` logger channel.
- Poll `GET /api/model/status/{id}` for `{progress,status,message}` while a conversion runs.
- You can also process the queue manually: `drush queue:run dlf_aim_3d_viewer_convert`.
