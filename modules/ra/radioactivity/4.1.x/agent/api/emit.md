# Radioactivity — emitting & recording energy (incidents)

## Incident (`src/Incident.php`)

A single "this field was viewed, add this energy" event. Fields: `fn` (field name), `et` (entity
type), `id` (entity id), `ti` (target id of the referenced radioactivity entity, `0` for the inline
field), `e` (energy), `h` (hash).

- `Incident::createFromFieldItemsAndFormatter($items, $item, $formatter)` builds one at render time
  (energy = the emitter formatter's `energy` setting).
- `toJson()` serializes it including a freshly computed hash.
- `isValid()` recomputes the hash and compares:
  `sha1(fn ## et ## id ## ti ## e ## Settings::getHashSalt())`. **The site hash salt is the shared
  secret** — a client cannot forge an incident with arbitrary energy/target without it, so tampered or
  invented incidents are discarded at processing time.
- `createFromPostData($data)` rebuilds an incident from a received associative array (missing keys
  default; the hash still has to verify).

## Client side

The emitter formatter attaches library `radioactivity/triggers` and puts each incident JSON in
`drupalSettings` under a unique `ra_emit_<n>` key. `StorageFactory::injectSettings()` also adds
`drupalSettings.radioactivity.{type,endpoint}`. `js/triggers.js` collects the incidents on the page and
POSTs them (as a JSON array) to that endpoint.

## Server side — two record paths

### 1. Drupal route `/radioactivity/emit` (storage `default`)
`radioactivity.routing.yml` → `EmitController::emit()`, requirement `_permission: 'access content'`.
Decodes the POSTed array, calls `Incident::createFromPostData()` + `isValid()` on each, and on success
`DefaultIncidentStorage::addIncident()` inserts a row into the `radioactivity_incident` table. Invalid
incidents abort with a JSON error. (The `access content` permission is broad — commonly held by
anonymous — but forging energy still requires a valid salt-based hash.)

### 2. Standalone `endpoints/file/rest.php` (storage `rest_local` / `rest_remote`)
A raw PHP file executed **outside Drupal's bootstrap** (`include '../../src/RestProcessor.php'`). It:
- POST body → `RestProcessor::processData()` → appends the JSON to
  `sys_get_temp_dir()/radioactivity-payload.json` after a shallow key check (does **not** verify the
  hash here — hash verification happens later when Drupal reads the file).
- `?get` → returns all stored incident JSON.
- `?clear` → deletes the payload file.

## Processing (cron / programmatic)

`RadioactivityProcessor` (`radioactivity.processor`):
- `processIncidents()` — reads incidents from the configured storage
  (`StorageFactory::getConfiguredStorage()`), clears them, and queues `radioactivity_incidents`
  workers that add energy to entities (no timestamp bump, no new revision). `RestIncidentStorage`
  fetches via `file_get_contents("<endpoint>?get")` and only keeps incidents whose hash verifies.
- `processDecay()` — queues `radioactivity_decay` workers; see [../configure/storage.md](../configure/storage.md).

Both run automatically on cron; call `\Drupal::service('radioactivity.processor')->processIncidents()`
to force it.
