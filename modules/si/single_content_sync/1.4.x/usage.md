Single Content Sync exports a single content entity (and the entities it references) to a YAML file or a ZIP bundle, and imports it on another site — a lightweight way to move individual pieces of content between environments without a full migration.

---

The module adds an **Export** tab/operation to fieldable content entities (node, media, taxonomy term, block content, menu link content, and any entity type you enable). From that form you preview the entity serialized as YAML and download it either as a plain `.yml` file or as a `.zip` that also bundles referenced assets (files, images). Referenced entities are followed recursively so a node's paragraphs, media, terms, links and embedded content travel with it; an "export mode" setting decides whether embedded links and menu links are exported as stubs (base fields only, matched by UUID on import) or as full entities. Import happens at **Admin → Content → Import** by pasting YAML or uploading a `.yml`/`.zip`, or programmatically via the `single_content_sync.importer` service (`importFromFile()` / `importFromZip()`), which is ideal for importing content on deploy from a `hook_update_N`. Drush commands `content:export` and `content:import` handle bulk and scripted transfers, with flags for translations, assets, bundles, specific entity IDs, and dry runs. Extensibility is plugin-based: **SingleContentSyncFieldProcessor** plugins (keyed by field type) control how a field is serialized/deserialized, and **SingleContentSyncBaseFieldsProcessor** plugins (keyed by entity type) control base-field handling; events (`ExportEvent`, `ImportEvent`, `ExportFieldEvent`, `ImportFieldEvent`, `BulkExportRoutesEvent`) offer an alternative alter path. A settings form gates which entity types/bundles may be exported, toggles a source/destination Site UUID check, and picks the file schema used during import/export.

---

- Move a single node from staging to production as a downloadable YAML file.
- Export a landing page with all its paragraphs and referenced media as a ZIP with assets.
- Import content on deploy from a `hook_update_N` using `single_content_sync.importer`.
- Bulk-export every node of a bundle with `drush content:export node --bundle="article"`.
- Export all content of every allowed entity type with `drush content:export --all-content`.
- Include translations in an export using the Export form checkbox or the `--translate` flag.
- Import a `.zip` bundle (content plus assets) with `drush content:import path/to/file.zip`.
- Preview exactly what a specific set of entity IDs would export via `--entities="1,4,7" --dry-run`.
- Ship a reusable homepage as a committed `.yml` asset imported by a custom module on install.
- Copy a taxonomy term and its dependencies between environments from the term's Export tab.
- Export a block content / menu link content entity along with the content it links to.
- Keep referenced entities as stubs (matched by UUID) instead of duplicating them on import.
- Fully export embedded links and referenced entities by switching the export mode to "full".
- Restrict which entity types and bundles editors are allowed to export via the settings form.
- Prevent importing content from a different site by enabling the Site UUID check.
- Choose the temporary vs. public file schema used for import/export directories.
- Write a custom SingleContentSyncFieldProcessor plugin to serialize a custom field type.
- Write a custom SingleContentSyncBaseFieldsProcessor plugin to handle a custom entity type's base fields.
- Alter an exported entity or field value with an ExportEvent / ExportFieldEvent subscriber.
- Alter an imported entity or field value with an ImportEvent / ImportFieldEvent subscriber.
- Add or remove entity collection routes from the bulk-export action via BulkExportRoutesEvent.
- Grant editors per-entity-type export rights with the dynamic "export {type} content" permissions.
- Gate the Import page and settings form with the "import single content" / "administer" permissions.
- Serialize a node to an array in code with `single_content_sync.exporter`'s `doExportToArray()`.
- Reconstruct an entity from an exported array in code with the importer's `doImport()`.
- Duplicate a complex piece of content within the same site by exporting then re-importing it.
- Seed a fresh environment with sample content generated once and stored as YAML fixtures.
- Transfer a Layout Builder page (sections/blocks) between sites via the layout_section processor.
- Move content that embeds Webform, Metatag, or Address values using the bundled field processors.
