Cloudflare Stream - Sync imports videos that already exist in your Cloudflare Stream account into Drupal as Media items, so videos uploaded outside Drupal become manageable content.

---

The submodule adds a settings/sync form at `/admin/config/media/cloudflare-stream/sync` (route `cloudflare_stream_sync.sync`, permission `sync cloudflare stream videos`) where you pick a target Media type (any type whose source is `cloudflare_stream`) and press "Sync videos". It lists videos from the Cloudflare API via the parent's `cloudflare_stream.api` service, and for each video not already present (matched by `cloudflareStreamVideoID` on the media source field) it writes an empty placeholder file, creates a published Media entity of the chosen type referencing the Cloudflare video id and thumbnail, and registers file usage. Runs happen through Drupal's Batch API from the form, or non-interactively via the `cloudflarestream:sync` Drush command (alias `css`). The first sync imports everything; later syncs only fetch videos created after the stored `last_imported` timestamp (config `cloudflare_stream_sync.settings`, keys `media_type_id` + `last_imported`). Requires the parent `cloudflare_stream` module configured with valid credentials and a Cloudflare-backed Media type.

---

- Import videos uploaded directly in the Cloudflare dashboard into Drupal as Media.
- Backfill a Drupal Media library from an existing Cloudflare Stream account.
- Create published Media entities of a chosen Cloudflare-backed Media type from remote videos.
- Skip videos already represented in Drupal (dedupe by Cloudflare video id).
- Run the import interactively with a progress batch from the sync form.
- Automate imports via cron using `drush cloudflarestream:sync` (alias `css`).
- Target a specific Media type per run (`drush css my_media_type`).
- Incrementally import only videos added since the last sync.
- Keep Drupal's Media library in step with videos managed on Cloudflare.
- Register file usage so imported placeholder files are tracked correctly.
- Seed a video catalog without re-uploading files that already live on Cloudflare.
- Restrict who can trigger imports via the `sync cloudflare stream videos` permission.
- Reset the incremental window by changing the stored `last_imported` config value.
- Bulk-create Media entities for hundreds of existing Cloudflare videos in one batch.
- Bridge externally-produced video workflows into Drupal editorial workflows.
