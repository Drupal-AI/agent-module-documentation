Atomic CAS deduplicates Drupal file uploads by SHA-256 content hash, storing the physical bytes of each unique file once while keeping full Drupal file-entity semantics via cas-public:// and cas-private:// stream wrappers.

---

Atomic Content-Addressable Storage (atomic_cas) hashes uploaded source files and stores the bytes once per unique (hash, scheme) pair in a blob store on disk, laid out under a sharded {root}/{scheme}/{aa}/{bb}/{hash} path. Each Drupal file entity keeps a logical URI of the form cas-public://{fid}/{filename} or cas-private://{fid}/{filename}, and an atomic_cas_map row records which blob (by hash) that fid references; blob metadata (size, MIME, creation time) lives in atomic_cas_blob. New public:// and private:// uploads are auto-ingested on hook_file_presave/hook_file_insert (or a developer can call atomic_cas_queue_ingest() explicitly before saving). Public blobs are served through versioned, immutably cacheable URLs at /files/cas/{fid}/{short_hash}/{filename}; when the bytes change the short hash changes and the stale URL returns a hard 404. Private blobs are served through the same route but gated by hook_file_download() access control with no-cache headers. Blob roots are configured in settings.php (not Drupal config), and optional Nginx X-Accel-Redirect / Apache X-Sendfile acceleration offloads the byte transfer from PHP. Drush commands cover migrating existing files into CAS, garbage-collecting orphaned blobs, and auditing blob integrity. It requires only core's File module, Drupal 10.2+/11, and PHP 8.1+.

---

- Reduce disk usage on a media-heavy site where editors repeatedly upload the same PDF, image, or document.
- Store one physical copy of a shared asset (a logo, a boilerplate contract) even though dozens of nodes each have their own file entity for it.
- Keep normal Drupal file entities, filenames, and per-file access control while transparently deduplicating the bytes behind them.
- Serve public files with year-long immutable browser caching that is automatically busted when the underlying bytes change (content-versioned URLs).
- Serve access-controlled private files through Drupal's hook_file_download() permission checks with strict no-cache headers.
- Migrate an existing site's public:// and private:// files into deduplicated CAS storage with `drush atomic-cas:migrate` (preview first with `--dry-run`).
- Reclaim space by deleting blobs no longer referenced by any file entity with `drush atomic-cas:gc` (always preview with `--dry-run`).
- Export the orphan list to CSV for review before deletion with `drush atomic-cas:gc --dry-run --csv=/tmp/orphans.csv`.
- Verify that every mapped blob still exists on disk with `drush atomic-cas:audit`.
- Detect silent bit-rot or truncated blobs by re-computing SHA-256 with `drush atomic-cas:audit --rehash`.
- Deduplicate identical image-style derivatives so the same rendered thumbnail is stored once and shared via per-file symlinks.
- Programmatically ingest a new file from a temp path via `atomic_cas_queue_ingest($file, $sourcePath, 'cas-public')` before `$file->save()`.
- Replace the bytes behind an existing CAS file with `AtomicCasManager::replaceFile($file, $newPath)` while keeping its fid and filename.
- Generate a public URL for a CAS file with `AtomicCasManager::getExternalUrl($file)`.
- Offload byte transfer to Nginx (`atomic_cas_x_accel_redirect`) or Apache mod_xsendfile (`atomic_cas_x_sendfile`) for higher throughput than PHP readfile().
- Monitor storage savings, deduplication ratio, largest blobs, and orphan counts on the admin dashboard at /admin/reports/atomic-cas.
- Surface misconfigured or non-writable blob roots automatically on the Status Report (/admin/reports/status) via hook_requirements().
- Restrict which staff can see blob statistics using the "administer atomic cas" permission.
- Duplicate a CAS file entity and have the copy transparently reference the same underlying blob (copy_map action) without copying bytes.
- Provision blob storage outside the document root so raw physical files are never web-accessible except through the controlled serve route.
- Support a controlled rollback: export atomic_cas_map, copy blobs back to public://, and rewrite URIs, then GC leftover blobs.
- Give document-heavy platforms (local government, publishing, editorial) predictable storage growth proportional to unique content rather than upload count.
