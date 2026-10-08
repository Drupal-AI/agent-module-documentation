Adds an SFTP file server as a source resource for Data Pipelines datasets, fetching a remote file (e.g. JSON) into the pipeline over SSH/SFTP.

---

Data Pipelines - SFTP extends the Data Pipelines framework with a new source resource plugin so a dataset can read its input file from a remote SFTP server instead of a local upload or HTTP URL. When the module is installed it adds an `sftp` base field (one per registered Data Pipelines source, named `<source>_sftp`) to the `data_pipelines` dataset entity. Editors configure the remote path, host, port and a credentials Key on the dataset form; at pipeline run time the module opens an authenticated SFTP connection with `phpseclib3\Net\SFTP`, downloads the file contents, and hands a stream to the pipeline. An optional "Local copy" toggle mirrors the downloaded file to a private-filesystem cache (`private://data_pipelines_sftp/cache`) so the pipeline can fall back to the last-known-good copy if the server is unreachable. Username/password credentials are never stored on the dataset itself — they are read at runtime from a `user_password` Key entity selected through the Key module's `key_select` element.

---

- Import a JSON dataset into Data Pipelines from a file hosted on a remote SFTP server.
- Point a dataset at a file server path such as `/exports/products.json` instead of uploading the file by hand.
- Reuse an existing Key entity (username/password) as the SFTP login for one or many datasets.
- Keep SFTP credentials out of the dataset configuration and out of exported config by referencing a Key.
- Connect to a non-standard SFTP port by setting the port field (defaults to 22 when left blank).
- Automatically create a local cached copy of the remote file for resilience when "Local copy" is enabled.
- Fall back to the cached local copy automatically when the SFTP server or file is temporarily unavailable, with a log message on the dataset.
- Refresh a dataset on cron/queue runs so the latest remote file is pulled each pipeline execution.
- Centralize feed ingestion for partner data drops delivered to an SFTP inbox.
- Ingest catalog, pricing or inventory feeds that a supplier publishes over SFTP.
- Load nightly export files produced by an external ERP/CRM onto a shared SFTP host.
- Serve the same remote file to multiple datasets, each with its own path and credentials Key.
- Disable the local copy on a dataset to force a fresh fetch and remove any previously cached file (handled on save).
- Provide a resilient JSON source for downstream Data Pipelines transforms and destinations (e.g. OpenSearch).
- Store connection metadata (host, port, path) on the dataset while delegating secret storage to Key.
- Support environments where the source system only exposes files via SFTP rather than an API.
- Let site builders add a remote file source without writing a custom source plugin.
- Retrieve a file over SFTP into an in-memory stream when no local caching is desired.
- Log SFTP retrieval errors against the dataset so failures are visible to editors.
- Migrate content or configuration data that is delivered as files to an SFTP landing zone.
- Combine with other Data Pipelines source resources on the same dataset entity type.
