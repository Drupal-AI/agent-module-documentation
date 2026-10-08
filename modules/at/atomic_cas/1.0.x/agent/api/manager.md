<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ingest lifecycle & the AtomicCasManager API

`Drupal\atomic_cas\AtomicCasManager` (service `atomic_cas.manager`, class alias to the FQCN) is the
single point for every blob write. Stream wrappers and the image-style override are read-only and
call it read-side only. Constructor deps: `@database`, `@lock`, `@logger.channel.atomic_cas`,
`@atomic_cas.settings`, `@entity_type.manager`, `@url_generator`, `@datetime.time`.

## How a file becomes a CAS blob

Hooks live in `src/Hook/AtomicCasHooks.php` (attribute `#[Hook(...)]`, with `#[LegacyHook]` procedural
shims in `atomic_cas.module`).

1. **Auto-ingest (UI uploads).** `filePresave()` — for a *new* `public://` or `private://` file it
   resolves the real path and registers a pending `ingest` action (mapping `public`→`cas-public`,
   `private`→`cas-private`).
2. **Explicit ingest (code).** Call `atomic_cas_queue_ingest($file, $sourcePath, $scheme)` (thin
   wrapper over `AtomicCasManager::queueIngest()`) on an **unsaved** file entity *before* `$file->save()`.
3. **`fileInsert()`** runs the pending action once the fid exists: `ingestFile()` hashes + copies the
   blob + writes `atomic_cas_blob`/`atomic_cas_map` + rewrites the URI to `{scheme}://{fid}/{filename}`,
   then re-saves. For auto-ingested UI uploads it also deletes the original `public://`/`private://`
   source file. The re-save fires `hook_file_update` (not insert) — no recursion.
4. **Duplicated CAS entity.** A *new* entity that already carries a CAS URI is treated as a duplicate:
   `filePresave()` registers a `copy_map` action; `fileInsert()` fixes the URI to the new fid and writes
   a map row pointing at the **same** blob (no byte copy).
5. **`fileDelete()`** removes the `atomic_cas_map` row for the fid. The blob is left as a GC candidate.

Pending actions are held in a per-request `pendingActions` array keyed by `spl_object_id($file)`
(the same service instance bridges presave→insert).

## Core write methods

- `ingestFile(FileInterface $file, string $sourcePath, string $scheme)` — requires an fid; hashes the
  source (`hashFile()` → lowercase SHA-256), acquires a **per-(scheme+hash) lock** (`atomic_cas:ingest:{scheme}:{hash}`,
  30s timeout), copies the blob only if absent, merges blob + map rows, sets the canonical URI.
  Copy uses `copyBlobAtomically()` (write to `{blob}.tmp.{pid}.{rand}` then `rename()` — crash-safe;
  a lost rename race is tolerated if the blob already exists). A DB failure after a successful copy
  leaves an **auditable orphan** blob (logged; reconcile with `drush atomic-cas:gc`).
- `replaceFile(FileInterface $file, string $sourcePath)` — swaps the bytes behind an existing CAS
  entity; keeps fid and filename (URI unchanged). No-op if the new hash equals the current one; else
  stores the new blob and repoints the map row (old blob becomes a GC candidate).
- `mapFile($file, $hash)` / `deleteMapping($fid)` / `saveBlobMetadata($data)` — low-level row writers
  (all use `merge()` / query builder; no raw SQL with user input).
- `deleteBlob($scheme, $hash)` — GC-only: unlinks the physical blob and deletes its `atomic_cas_blob`
  row (does not touch `atomic_cas_map`).

## Read / URL helpers

- `getExternalUrl($file)` — builds the versioned public URL from route `atomic_cas.serve` using
  `getShortHash($hash)` (first **12 hex chars**). Throws if the fid has no map row.
- `parseCasUri($uri)` / `isCasUri($uri)` — regex `^(cas-(?:public|private))://(\d+)/(.+)$`.
- `getBlobPath($scheme, $hash)` — `{root}/{scheme}/{aa}/{bb}/{hash}` (blob file is extension-less).
- `getMapping($fid)`, `getHashForFid($fid)`, `loadBlobMetadata($scheme,$hash)`, `blobExists(...)`.
- `validateServeRequest($fid,$shortHash,$filename)` — used by the serve controller (see storage doc);
  any mismatch throws `NotFoundHttpException`.

## Stats / GC query helpers

`getStats()`, `getLargestBlobs($limit)`, `findEligibleForMigration()` (public://|private:// rows),
`getAllMappings()`, `findOrphanedBlobs()` (LEFT JOIN of `atomic_cas_blob` against live
map↔file_managed pairs — a blob is live only while some `atomic_cas_map` row still has a real
`file_managed` fid).

## Developer example

```php
$file = File::create(['uri' => 'public://x.pdf', 'filename' => 'x.pdf', 'filemime' => 'application/pdf', 'status' => 1]);
atomic_cas_queue_ingest($file, '/tmp/upload_xyz', 'cas-public'); // BEFORE save
$file->save();                                  // hook_file_insert completes ingest
// $file->getFileUri() === 'cas-public://{fid}/x.pdf'
$url = \Drupal::service('atomic_cas.manager')->getExternalUrl($file);
```
