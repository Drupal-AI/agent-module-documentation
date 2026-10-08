Entity IO exports and imports Drupal content entities as portable JSON files, following entity references and revisions so related content travels together.

---

Entity IO turns any supported content entity (node, taxonomy term, user, media, block content, comment, paragraph and the files they reference) into a self-contained JSON document, then re-creates or updates that entity on another site or environment from the same file. Export recursively serializes referenced entities and embeds file/image binaries as base64, while import maps each source UUID to a local entity through a dedicated tracking table, shows a side-by-side diff before overwriting, and can create new revisions or set the change author. You drive it from per-entity "Export JSON" tabs and operations, "Export" links in revision lists, batch export forms, an admin JSON import form, JSON API routes, and Drush commands. Exports can be stored in the public or private file system, and per-bundle configuration lets you choose exactly which fields and how much reference depth to include. Optional submodules add queued processing, event-driven webhooks (HTTP/email/FTP), direct push-to-another-site deployment, and export-directory cleanup.

---

- Migrate individual nodes and their referenced content between Drupal environments as JSON.
- Move a taxonomy term (and its fields) from staging to production.
- Copy a user account's profile fields to another site as JSON.
- Export a media item together with its underlying file (embedded as base64).
- Export a custom block's content for reuse on another site.
- Export a comment thread, preserving parent/child reply structure.
- Export a specific node revision from the revision history "Export" link.
- Export specific taxonomy term, media, or block revisions from their revision lists.
- Bulk-export every entity of a type through the batch export form.
- Export selected entities by ID through the batch-by-IDs form.
- Export all sample or all entities from the CLI with `drush entity-io:export --all`.
- Export one entity from the CLI with `drush entity-io:export --entity-type=node --id=123`.
- Import previously exported JSON from the admin form at `/admin/content/import`, reviewing the diff first.
- Re-import all exported files at once with `drush entity-io:import`.
- Import every JSON file from a folder with `drush entity-io:import-folder /path/to/json`.
- Run an import as a specific user with `drush entity-io:import --user=editor`.
- List all exported files and their sizes with `drush entity-io:list`.
- Clear generated export files with `drush entity-io:clear-exports`.
- Choose per content type / bundle which fields and reference depth get exported.
- Store exports privately and download them through an access-gated route.
- Produce compressed exports (`.gz` or Brotli `.br`) to reduce file size.
- Keep a synchronized copy of content by pushing entities to another site with the Push submodule.
- Automatically send an entity's JSON to an external endpoint on create/update/delete using the Webhooks submodule.
- Email or FTP-upload exports automatically on entity events via the Webhooks submodule.
- Queue large export/import jobs for background batch processing with the Queue submodule.
- Periodically purge the export storage directory with the Purge submodule.
- Review changes on import via the built-in visual JSON diff before confirming an overwrite.
- Track imported source UUID → local entity mappings to avoid duplicate content on re-import.
