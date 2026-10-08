Optional DKAN Dataset Archiver submodule that copies (or moves) each generated dataset archive file to AWS S3 remote object storage using League Flysystem.

---

`dkan_dataset_archiver_remote_storage` extends the parent archiver so that stored archive files can live in—or be mirrored to—an AWS S3 bucket instead of, or in addition to, Drupal's local file system. When a `dda_archive` entity is saved (or its local files change), an event subscriber queues the archive onto the `archive_remote_file_sync` queue; the `SyncToRemote` queue worker then streams each resource file to S3 via a Flysystem `AwsS3Adapter`, records the resulting `s3://bucket/…` URL on the archive's `remote_url` field, and—if the storage mode is "remote only"—deletes the local copy afterward. The S3 client (`AwsS3Service`) is built from the AWS SDK using region and bucket address configured on the parent module's settings form, while the AWS credentials are supplied to the process through standard AWS SDK environment variables rather than being stored in Drupal configuration. Only AWS S3 is supported today, though the code is structured to allow other backends later.

---

- Store DKAN dataset archives in an AWS S3 bucket to offload large zip/CSV files from local disk.
- Keep both a local and a remote (S3) copy of every archive for redundancy ("local_and_remote" mode).
- Move archives to S3 and delete the local copy to reclaim server storage ("remote" mode).
- Automatically sync newly-created individual, theme, keyword, annual, and "current" archives to S3 as they are generated.
- Re-sync an archive to S3 whenever its local files change, without manual intervention.
- Record the canonical `s3://` URL on each archive so the archive API can hand out remote download links.
- Serve archive download URLs from S3 when no local copy exists.
- Supply AWS credentials via environment variables (AWS SDK credential chain) instead of committing secrets to Drupal config.
- Point archives at any AWS region and bucket by setting the region and bucket address on the parent archiver settings form.
- Defer all remote transfers to Drupal's cron queue (`archive_remote_file_sync`) so uploads never block a web request.
- Retry a failed upload by re-queuing the item to the end of the queue rather than blocking the whole queue.
- Enable the "remote" and "local and remote" storage options that the parent module greys out until this submodule is installed.
