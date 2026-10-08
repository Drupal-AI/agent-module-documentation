Entity Usage tracks relationships between entities — recording where each entity (node, term, media, block, file, custom entity, etc.) is referenced by other entities — and surfaces that "where is this used?" information in a report page, a per-entity Usage tab, Views, and a programmatic API.

---

The module watches *source* entities as they are created, updated, and deleted, and asks a set of pluggable tracking methods (`EntityUsageTrack` plugins) to record every *target* entity they point to, storing each relationship as a row in the `entity_usage` database table. Out of the box it detects relationships made through entity_reference fields (including file, image, webform and entity_reference_entity_modify field types), Entity Reference Revisions fields (paragraphs), link fields, plain HTML links to entity URLs inside text fields, entities embedded via Entity Embed / LinkIt / core media embed, inline `<img>` tags added by CKEditor, Layout Builder inline blocks, and Block Field and Dynamic Entity Reference fields. Site builders choose which entity types are tracked as sources and as targets, which tracking plugins are active, and which entity types show a "Usage" local task tab on their canonical (or edit-form) page. The module can also warn editors on the edit and delete forms when an entity is still referenced somewhere, helping prevent accidental breakage. Absolute URLs in content are resolved back to local entities through an extensible URL-to-entity service (with integrations for entity routing, language prefixes, public files, and the Redirect module), and URL changes are re-tracked automatically — synchronously for a small batch, then via a background queue for the rest. All settings live in the `entity_usage.settings` config object and are managed at Configuration → Content Authoring → Entity Usage Settings. A batch-update tool (UI form or the `drush entity-usage:recreate` command) erases and regenerates the usage table, needed after changing tracked types or importing content. Developers can read usage data through the `entity_usage.usage` service, expose it in Views, block specific records with a hook, or add new tracking methods by writing an `EntityUsageTrack` plugin. This 5.0.x release requires Drupal 11.4+ / 12 and uses attribute-based (OOP) hooks and plugins throughout.

---

- See every place a media item, image or file is used before deleting it.
- Show content editors a "Usage" tab on nodes listing all pages that reference them.
- Warn an editor on the delete form when a taxonomy term is still in use.
- Warn on the edit form before changing a reusable block that appears on many pages.
- Track reverse entity-reference relationships without building custom Views.
- Find orphaned media that is no longer referenced by any content.
- Audit which articles link to a given landing page via body-text HTML links.
- Track entities embedded in CKEditor text via Entity Embed or LinkIt.
- Track media embedded through core's media embed button.
- Track images referenced by inline `<img>` tags added in CKEditor.
- Track references created through Layout Builder inline (non-reusable) blocks and Entity Browser Block.
- Track paragraphs and other Entity Reference Revisions relationships.
- Track Dynamic Entity Reference and Block Field references.
- Limit tracking to only the source entity types you care about (e.g. nodes only).
- Restrict which target entity types are recorded to keep the table small.
- Enable only the tracking plugins relevant to your site for performance.
- Regenerate all usage statistics after a content import with `drush entity-usage:recreate`.
- Rebuild statistics for only specific entity types with `--entity-types=node,media`.
- Rebuild the usage table via the batch UI form after changing configuration.
- Display usage counts and source listings inside a custom View via the provided relationships.
- Retrieve, in custom code, every source that references a given entity (`listSources()`).
- List all target entities referenced by a given source entity or revision (`listTargets()`).
- Programmatically register or delete a usage record from custom integrations.
- Resolve an absolute or relative URL string back to the entity it points to (`UrlToEntity`).
- Block specific tracking records with `hook_entity_usage_block_tracking()`.
- Add support for a custom reference method by writing an `EntityUsageTrack` plugin.
- Track usage across revisions and translations independently.
- Configure the site's own domains so absolute URLs in content resolve to local entities.
- Update tracked entity URLs automatically when an entity's path alias changes.
- Provide content teams a governance view of cross-content dependencies.
