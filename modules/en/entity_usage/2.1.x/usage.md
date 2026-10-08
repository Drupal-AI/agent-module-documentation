Entity Usage tracks relationships between entities — recording where each entity (node, term, media, block, file, custom entity, etc.) is referenced by other entities — and surfaces that "where is this used?" information in reports, a per-entity Usage tab, Views, and a programmatic API.

---

The module watches *source* entities as they are created, updated, and deleted, and asks a set of pluggable tracking methods to record every *target* entity they point to. Out of the box it detects relationships made through entity_reference and link fields, plain HTML links to entity URLs inside text fields, entities embedded via Entity Embed / LinkIt / media embed, Layout Builder inline blocks, and fields from Block Field, Entity Reference Revisions and Dynamic Entity Reference. Site builders choose which entity types are tracked as sources and as targets, which tracking plugins are active, and which entity types show a "Usage" local task tab on their canonical page. The module can also warn editors when they edit or delete an entity that is still referenced somewhere, preventing accidental breakage. All settings are stored in the `entity_usage.settings` config object and managed at Configuration → Content Authoring → Entity Usage Settings. A batch-update tool (UI form or Drush command) erases and regenerates the whole usage table, which is needed after changing tracked types or importing content. Developers can read usage data through the `entity_usage.usage` service, expose it in Views, block specific records with a hook, or add new tracking methods by writing an `EntityUsageTrack` plugin.

---

- See every place a media item, image or file is used before deleting it.
- Show content editors a "Usage" tab on nodes listing all pages that reference them.
- Warn an editor when they try to delete a taxonomy term that is still in use.
- Warn before editing a reusable block that appears on many pages.
- Track reverse entity-reference relationships without building custom Views.
- Find orphaned media that is no longer referenced by any content.
- Audit which articles link to a given landing page via body-text HTML links.
- Track entities embedded in CKEditor text via Entity Embed or LinkIt.
- Track media embedded through core's media embed button.
- Track references created through Layout Builder inline (non-reusable) blocks.
- Track paragraphs and other Entity Reference Revisions relationships.
- Track Dynamic Entity Reference and Block Field references.
- Limit tracking to only the source entity types you care about (e.g. nodes only).
- Restrict which target entity types are recorded to keep the table small.
- Enable only the tracking plugins relevant to your site for performance.
- Regenerate all usage statistics after a big content import with a Drush command.
- Rebuild the usage table via a batch UI form after changing configuration.
- Display usage counts and source listings inside a custom View.
- Retrieve, in custom code, every source that references a given entity.
- List all target entities referenced by a given source entity or revision.
- Programmatically register or delete a usage record from custom integrations.
- Block specific tracking records with `hook_entity_usage_block_tracking()`.
- Add support for a custom reference method by writing an EntityUsageTrack plugin.
- Track usage across revisions and translations independently.
- Gate access to usage reports and the batch-update tool with dedicated permissions.
- Update tracked entity URLs automatically when an entity's path changes.
- Provide content teams a governance view of cross-content dependencies.
