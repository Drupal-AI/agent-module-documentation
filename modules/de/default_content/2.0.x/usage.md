Default Content exports content entities (nodes, terms, files, media, menu links, blocks, etc.) to YAML files that a module or install profile can ship, and imports them automatically when that module is enabled.

---

Default Content lets a module or install profile carry real content, not just configuration. You export entities to per-entity YAML files with a set of Drush commands (`dce`, `dcer`, `dcem`, `dcemr`); each file lives at `content/{entity_type}/{uuid}.yml` inside the providing module and captures the entity's field values plus a `_meta` block (entity type, UUID, bundle, default langcode, and a `depends` map of referenced UUIDs). On `hook_modules_installed`, the importer scans every enabled module's `content/` directory, parses each file, builds a dependency graph with Drupal core's Gliph/`Graph` utility, and saves the entities in dependency order so referenced entities (a term before the node that references it, a user before the node it owns) exist first. Referenced entities are stored as `entity: {uuid}` values and re-resolved on import; File entities also copy their physical file from the same folder to the destination stream wrapper. Import runs as user 1 via the account switcher and marks entities as syncing/new. The `default-content-export-module` commands read a `default_content:` list of UUIDs from the module's `.info.yml` to know what to export. Legacy `hal_json` (`.json`) content is still importable but deprecated and removed in 3.0.0 in favor of YAML. The module has no UI or settings; developers extend it via the `default_content.import` / `default_content.export` events and can swap the exporter, importer, and normalizer services. This 2.0.x release is a beta (`2.0.0-beta1`).

---

- Ship demo or starter content with an install profile so a fresh site is not empty.
- Bundle example nodes, taxonomy terms, and media with a feature module.
- Export a single node to YAML with `drush dce node 123 my_module`.
- Export an entity plus every entity it references with `drush dcer node 123`.
- Export all UUIDs listed in a module's info file with `drush dcem my_module`.
- Export a module's listed content and all references with `drush dcemr my_module`.
- Move curated content between environments (dev to prod) as code in version control.
- Seed content fixtures for automated tests via a test module's `content/` directory.
- Provide default menu links, blocks, or configuration pages as content.
- Migrate hand-picked content by committing its YAML into a module.
- Preserve entity references (node to term, node to author) across import.
- Import files/media by shipping the physical file alongside its `content/file/{uuid}.yml`.
- Recreate content with stable UUIDs so references stay valid on every install.
- Guarantee dependency order (referenced term imported before the referencing node).
- Keep default content in Git and review changes to it in pull requests.
- Re-import content automatically when a module is enabled — no manual step.
- Rebuild a demo site reproducibly from code alone.
- Attach editorial content to a distribution shipped to many sites.
- Export content to a chosen folder with the `--folder` option, grouped by entity type.
- Write a single export to a `.yml` file with the `--file` option instead of stdout.
- React to imported entities via the `default_content.import` event (e.g. index or notify).
- React to each exported entity via the `default_content.export` event.
- Swap in a custom normalizer to change the YAML representation of entities.
- Decorate the importer or exporter service to alter import/export behavior.
- Import content as part of a configuration-sync deployment (config import triggers it).
- Populate a staging or QA site with a known content baseline on install.
