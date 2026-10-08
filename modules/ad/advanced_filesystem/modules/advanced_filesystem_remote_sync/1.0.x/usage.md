Pulls a Drupal site's uploaded files from another Drupal server running the same module, over HTTP Basic Auth, so a migrated site can fetch its files after only the database was moved.

---

Advanced Filesystem: Remote Sync is a submodule of Advanced Filesystem Backup for the migration case where you import a database dump to a new server but the actual files (public://, private://, and any other local stream wrappers) are still sitting on the old server. Enable the module on both sites. The old (source) server exposes two authenticated, read-only endpoints: a paginated JSON listing of the files under a given stream-wrapper scheme, and a single-file binary download. The new (destination) server has an admin form where you enter the source base URL, a service-account username/password, the schemes to sync, and whether to overwrite existing files. Running the sync fires a Batch API job that walks the remote listing page by page and downloads each file into the matching local URI, showing a progress bar. A Test connection button verifies the URL and credentials before you commit to a full run. Access to the source endpoints is gated by HTTP Basic Auth plus a dedicated restricted permission, and TLS certificate verification is on by default (it can be disabled only for self-signed development certificates).

---

- Finish a server migration where the database was imported but the uploaded files were never copied to the new host.
- Avoid a large manual rsync/scp of the files directory before putting a migrated site into production.
- Pull the entire public:// tree from an old server into a new server in one batched, resumable run.
- Also sync private:// (and any other local stream-wrapper scheme) alongside public:// in the same job.
- Bring a locally restored database dump up to date by fetching the production files it references.
- Populate a fresh staging or QA environment with real files copied from production.
- Sync only files that are missing locally by turning off "Overwrite existing local files".
- Force a refresh of every file (re-download and overwrite) when the local copies may be stale.
- Tune throughput/stability on slow links by lowering the "Files per batch step" chunk size.
- Test that the source server is reachable and the credentials are valid before starting, using the Test connection button.
- Use a dedicated Drupal service account on the source server that holds only the sync API permission.
- Keep credentials confidential in transit by running the source server over HTTPS with certificate verification enabled.
- Allow a self-signed certificate on an internal/dev source server by unchecking SSL verification.
- Query the source server's file inventory programmatically via GET /advanced-filesystem-remote-sync/list?scheme=public with Basic Auth.
- Download a specific file from the source server via GET /advanced-filesystem-remote-sync/file?uri=public://path/to/file.jpg with Basic Auth.
- Paginate through very large file sets using the offset and limit query parameters on the listing endpoint (limit capped at 500).
- Restrict a sync to just one scheme (for example, only private:// documents) by selecting a single checkbox.
- Re-run the sync later to top up newly added files from a source server that is still live.
- Migrate files between two environments of the same project (for example production to a cloud target) without shell access to the source filesystem.
- Recover files onto a rebuilt server from a still-running old server without touching its disk directly.
- Integrate remote pulls into a migration runbook: import DB, enable module on both ends, configure connection, run batch.
- Keep the file transfer inside Drupal's permission and stream-wrapper model rather than exposing raw filesystem access.
