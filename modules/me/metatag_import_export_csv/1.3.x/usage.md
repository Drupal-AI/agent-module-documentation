Metatags Import Export CSV adds two admin forms that let you bulk **export** the Metatag values of entities to a CSV file and bulk **import** a CSV to update those meta tags — across nodes, users, taxonomy terms, or any entity with a Metatag field.

---

The module sits alongside the Metatag module and works entirely through two batch-driven forms under *Configuration > Search and metadata > Metatag*. The **Export** form (`/admin/config/search/metatag/download`, permission `metatag import export csv download`) lets you choose an entity type, bundle, the meta tags to include, and a delimiter, then downloads a CSV with one row per entity (columns `entity_id`, `entity_title`, `entity_bundle`, `entity_type`, `field_machine_name`, `alias`, then one column per selected tag). The **Import** form (`/admin/config/search/metatag/upload`, permission `metatag import export csv upload`) takes a CSV in the same shape and updates each entity's Metatag field. Each import row must identify the entity — either by `entity_type` + `entity_id`, or by `path_alias` — and must name the entity's Metatag field via the mandatory `field_machine_name` column; an optional `language` column targets a translation. For tag columns, leave a cell empty to keep the current value, or put `_blank` to explicitly clear it; values equal to what Metatag would already generate are skipped. Both directions run as Batch API processes with success/error messages. The module defines only these two permissions (both `restrict access`), no config of its own, and depends on Metatag and Token; it supports both Metatag v1 and v2 encoding APIs.

---

- Bulk-export all node meta titles and descriptions to a spreadsheet for review.
- Hand a CSV of SEO meta tags to a marketing team to edit offline.
- Re-import an edited CSV to update meta descriptions across hundreds of nodes.
- Migrate meta tags between environments via CSV.
- Set Open Graph / Twitter Card tags in bulk from a CSV.
- Target entities by path alias instead of entity id in the import file.
- Update meta tags for a specific language/translation using the `language` column.
- Clear a meta tag on many entities at once with the `_blank` value.
- Leave selected tags untouched by keeping their CSV cells empty.
- Export meta tags for taxonomy terms or users, not just nodes.
- Audit which entities have which meta descriptions by exporting to CSV.
- Prepare a canonical set of meta tags in a CSV and apply it site-wide.
- Choose the CSV delimiter (comma/semicolon) to match your spreadsheet locale.
- Restrict who can export meta tags with the download permission.
- Restrict who can import/overwrite meta tags with the upload permission.
- Bulk-fix duplicate or missing meta descriptions flagged by an SEO audit.
- Roll out schema/structured-data-related meta tags across a content type.
- Populate meta tags for freshly migrated content from a source CSV.
- Correct meta tags for a batch of pages identified by their aliases.
- Export a bundle's meta tags, transform them in a script, and re-import.
- Give editors a familiar spreadsheet workflow for SEO metadata.
- Apply consistent meta keywords/robots values to a set of entities.
- Skip values that already match generated output (the importer ignores no-ops).
