Acquia ContentHub connects a Drupal site to Acquia's Content Hub SaaS so entities can be syndicated between many Drupal sites: publishers serialize content to a Common Data Format (CDF) and push it, subscribers receive webhooks and import it with full dependencies resolved.

---

The base module handles the service connection — registering the site as a Content Hub "client" (API key, secret key, origin UUID, hostname), receiving service webhooks at `/acquia-contenthub/webhook`, and validating them with HMAC signatures via the `acquia/content-hub-php` library. Content is turned into CDF documents through an entirely event-driven pipeline (Symfony events such as `CREATE_CDF_OBJECT`, `SERIALIZE_CONTENT_ENTITY_FIELD`, `PARSE_CDF`, `ENTITY_DATA_TAMPER`, `PRE_ENTITY_SAVE`, `PRUNE_CDF`), and full dependency graphs are calculated by the required `depcalc` module so an imported entity arrives with its fields, references, files, and config. Roles are split across submodules: `acquia_contenthub_publisher` exports content and manages the export queue; `acquia_contenthub_subscriber` imports content, tracks imported entities, and runs the import queue; others add curation, a dashboard, metatag/canonical handling, moderation-state mapping, selective-language import, S3 file support, site-health audits, and per-entity unsubscribe. Connection credentials can be supplied three ways with a clear precedence: Drupal `settings.php` (highest), environment variables, then the admin settings form (which stores them in config). A large set of Drush commands (`acquia:contenthub-*`) cover connect/disconnect, queue runs, filters, webhooks, purge, audit, and reindex. New file locations are handled by a `FileSchemeHandler` plugin type (public/private/http(s)/s3). It targets multi-site content distribution — one authoring site feeding many delivery sites, or bidirectional content sharing across a fleet.

---

- Syndicate nodes and other content entities from one Drupal site to many.
- Build a hub-and-spoke publishing model: one authoring site, many delivery sites.
- Share content bidirectionally across a fleet of Drupal sites.
- Register a site as a Content Hub client from the settings form or Drush.
- Provide connection credentials securely via `settings.php` instead of config.
- Provide connection credentials via environment variables in containerized deploys.
- Receive and HMAC-validate service webhooks at `/acquia-contenthub/webhook`.
- Export a specific entity to Content Hub via the publisher export queue.
- Import incoming entities with all dependencies resolved via `depcalc`.
- Run the export queue from Drush (`acquia:contenthub-export-queue-run`).
- Run the import queue from Drush (`acquia:contenthub-import-queue-run`).
- Attach/detach syndication filters that decide which content a subscriber receives.
- Manage webhook "interests" so a subscriber only gets relevant updates.
- Purge all content from the Content Hub service (`acquia:contenthub-purge`).
- Reindex the origin's entities on the service (`acquia:contenthub:reindex`).
- Audit publisher/subscriber state for tracking inconsistencies (Drush audit commands).
- Regenerate or update the shared webhook secret without full re-registration.
- Disconnect a site (`acquia:contenthub-disconnect-site`) and delete its client.
- Alter serialized CDF output by subscribing to serialization events.
- Tamper/normalize imported field data before save via `ENTITY_DATA_TAMPER`.
- Exclude specific entity types or bundles from the export queue.
- Import content directly into a chosen workflow moderation state (moderation submodule).
- Selectively import only desired languages (translations submodule).
- Store and syndicate S3-hosted files across sites (s3 submodule, deprecated).
- Disconnect individual entities from further pushed updates (unsubscribe submodule).
- Curate and discover syndicated content from an admin interface (curation submodule).
- Monitor syndication health from a dashboard (dashboard submodule).
- Add a custom file scheme handler plugin for a non-standard storage backend.
- Diagnose Drupal/ContentHub incompatibilities with site-health audits.
