Entity Association groups content entities together under a configurable "association" entity whose behavior plugin governs which entities may join, and shares context, blocks, menus and landing pages across the grouped content.

---

Entity Association adds an `association` content entity (bundled by the `association_type` config entity) that acts as a container for other content — nodes by default, or any entity type declared through an entity adapter. Each association type is driven by a **behavior plugin** (e.g. `entity_list`, `entity_manifest`) that determines the allowed entity types/bundles, cardinality and ordering, and renders the per-association content-management UI at `/association/{id}/manage`. A **landing-page handler plugin** (`none`, `associated_entity`, or the `association_page` entity from the submodule) supplies the canonical URL for an association. Members carry a computed `associations` reference field back to their `association_link` records, which grants a shared "active association" context used by the Association display block and by menus. Associations enforce access through per-bundle operation permissions and rewrite entity/Views access queries so unpublished or unauthorized association content is filtered from listings. On save, associations run **entity updaters** (pathauto alias, Search API reindex, or custom ones registered via an event) over their members, batching large sets to cron. Extensibility comes from behavior and landing-page plugins, YAML entity adapters, tagged association negotiators, and dispatched events. Requires Token and Toolshed; Pathauto is recommended.

---

- Group a set of nodes into a named "landing page" package (hero node + related articles) managed from one screen.
- Build editorially-curated collections (e.g. a campaign, a product family, an event program) as a single association.
- Restrict which content types and how many items an editor may add to a collection, via the `entity_list` behavior configuration.
- Create a "manifest"-style association where each slot/tag holds a specific entity type/bundle (using the `entity_manifest` behavior).
- Give each association a dedicated, revisionable landing page entity with its own fields and display (with `association_page`).
- Share a block region across every node in an association so a banner or CTA follows the whole collection.
- Attach a per-association navigation menu and breadcrumb trail to the grouped content (with `association_menu`).
- Auto-generate a starter node (or other entity) whenever an association of a given type is created (with `association_autogen`).
- Maintain a consistent pathauto URL pattern for all content belonging to an association.
- Automatically re-index association members in Search API when the association changes (mark the type "searchable").
- Propagate an association's active/published state so deactivating the association hides its member content from listings.
- Delegate per-bundle create/edit/delete/manage/publish rights to specific roles using generated per-association-type permissions.
- Add support for a custom entity type to associations by dropping a `<module>.association.entity_adapter.yml` file.
- Register a custom entity updater to run site-specific maintenance over association members on every association save.
- Add a custom association negotiator to resolve the "active association" from your own routes or context.
- Filter Views of associable content by association type or active state automatically (query-alter, works without the Group module).
- Expose association fields and the association reference on member entities for use in tokens and displays.
- Use the Association display block in Layout Builder to render the active association in a chosen view mode.
- Lock a behavior or landing-page plugin choice once an association type has content, preventing structural breakage.
- Curate landing-page revisions (revert/delete) for association pages under per-type revision permissions.
- Reassign or unpublish a user's associations and landing pages automatically when that user account is cancelled.
