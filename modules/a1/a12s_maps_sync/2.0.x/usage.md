A12S MaPS Sync connects a Drupal site to the MaPS System PIM/DAM Web API and imports its objects, media and library taxonomy into Drupal entities and fields through configurable profiles and converters.

---

The module models the integration as configuration entities: a *profile* (`maps_sync_profile`) holds the connection context for one MaPS "python profile" (default MaPS language, media path), and one or more *converters* (`maps_sync_converter`) under it map a MaPS object type, media type or library to a Drupal entity type + bundle. Each converter carries filters, a field/property mapping (driven by pluggable mapping handlers), status management and optional auto-configuration derived from the remote attribute sets. Imports run through a batch/queue engine exposed both as admin forms and a rich set of Drush commands, with per-profile locking so long-running syncs do not overlap. Data is read from the MaPS API over HTTPS using an API key and base URL supplied via environment variables; imported objects are stamped with a computed global ID (GID) base field so re-imports update rather than duplicate. Multilingual content is supported via core `content_translation` and a configurable Drupal-langcode-to-MaPS-language-id mapping. The module also ships a `contextualized_attribute` content entity (with bundle types) for storing criteria-scoped attribute values.

---

- Publish a MaPS System product catalog into Drupal nodes, taxonomy and media without manual data entry.
- Import MaPS "objects" into any allowed Drupal entity type (nodes, taxonomy terms, media, custom entities) via a converter.
- Sync MaPS media (images, documents, videos) into Drupal media entities and map them onto file/media fields.
- Convert MaPS library trees into Drupal taxonomy vocabularies and terms.
- Define multiple profiles to connect one site to several MaPS python profiles or environments.
- Map individual MaPS attributes to Drupal fields with per-field mapping handlers (integer, float, date, link, HTML, entity reference, media, criteria attribute, etc.).
- Append instead of replace multi-value field data during import when a mapping requires accumulation.
- Filter which MaPS objects/media are imported per converter using source/target/type/status/attribute filters.
- Manage publication status by mapping MaPS statuses to Drupal published / unpublished / deleted states.
- Auto-configure a converter's mapping from the remote MaPS attribute sets instead of building it by hand.
- Run differential imports that only fetch data changed since the last successful import timestamp.
- Force a full re-import of a profile or converter when a complete refresh is required.
- Schedule recurring imports (via cron/drush) so Drupal stays continuously in sync with MaPS.
- Import a single MaPS object or media on demand from the "Import object" admin form or `drush amsio`.
- Re-import an individual existing Drupal entity from its edit page via the added "Reimport" tab/action.
- Roll back everything imported by a profile or converter to clean up a bad sync (`drush amsrp` / `amsrc`).
- Track and drive long imports through a persistent state queue and batch, resuming across runs.
- Release, list and ignore per-profile import locks to recover from interrupted or stuck syncs.
- Store criteria-scoped values as `contextualized_attribute` entities for contextualized (multi-tree) MaPS data.
- Restrict which entity types may receive the MaPS GID field and reimport route through the settings form.
- Explore the remote MaPS configuration (languages, statuses, object properties) from the Config explorer form.
- Integrate imports into deployment pipelines by scripting the Drush import/rollback/auto-config commands.
- Keep MaPS translations aligned with Drupal languages through the configurable language mapping.
