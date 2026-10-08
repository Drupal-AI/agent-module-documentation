Entity Construction Kit (ECK) lets site builders create brand-new **content entity types** and their **bundles** entirely through the UI (or code), without writing a custom module. Each entity type you define becomes a first-class fieldable content entity with its own database tables, Field UI, Views integration, and permissions.

---

ECK is built on two config entities: `eck_entity_type` (the entity type itself, e.g. "Event" or "Speaker") and a dynamically-registered bundle config entity `{type}_type` (the bundles inside it). When you save an `eck_entity_type`, ECK's `postSave` hook drives the core entity-definition-update system to install a real content entity type — creating its base table `{id}`, data table `{id}_field_data`, entity keys, route provider, view builder, access handler, and translation handler — via `hook_entity_type_build()` in `eck.module`. Each entity type exposes a fixed menu of optional **base fields** you toggle on per type: `title`, `uid` (Author/owner), `created`, `changed`, and `status` (published flag); enabling one adds the corresponding entity key and column. Bundles are ordinary config entities (`eck.eck_type.{type}.{bundle}`) that you attach configurable fields to through the standard Field UI, exactly like node content types. ECK generates per-type permissions dynamically (create/edit/delete/view, any and own) through `PermissionsGenerator`, and routes for content management live under `/admin/content/{type}` while structure lives under `/admin/structure/eck`. Deleting an entity type reverses everything: it purges reference fields, then uninstalls the entity type and drops its tables. Because the entities are standard content entities, they work out of the box with Views, tokens, translation, revisions-capable core APIs, and entity reference fields.

---

- Model a custom content type that is not a node — e.g. "Event", "Speaker", "Sponsor", "Location" — without the baggage of the node system.
- Create lightweight lookup/reference entities (e.g. "Brand", "Manufacturer", "Region") to reference from other content.
- Build a simple headless/JSON:API content store of custom entity types exposed over REST.
- Give site builders self-service power to add new entity types and bundles from the admin UI.
- Define an entity type with only the base fields you need (e.g. title + status, no author) to keep tables lean.
- Attach configurable fields (text, entity reference, date, media) to ECK bundles via the normal Field UI.
- Organize content of one entity type into multiple bundles (e.g. "Event" type with "Conference" and "Webinar" bundles).
- Replace bespoke custom-entity boilerplate modules with a UI-driven, exportable config workflow.
- Store structured data that needs Views listings but should not clutter the node table.
- Create per-bundle field sets that share a common entity type and permission model.
- Use ECK entities as targets of entity reference fields from nodes, users, or other ECK entities.
- Expose custom entities in Views (each ECK type ships `EntityViewsData` integration).
- Provide standalone canonical URLs (`/{type}/{id}`) for custom entities, or disable them to keep entities embedded-only.
- Enforce granular access with generated per-type permissions (create/edit any/edit own/delete/view).
- Translate custom entities using core Content Translation (ECK provides a translation handler).
- Build a catalog or directory (products, staff, portfolio items) as a dedicated entity type.
- Prototype a data model quickly, then export it to `config/sync` for deployment across environments.
- Programmatically create entity types and bundles in an install/update hook or Drush script.
- Add an "Author" base field to track ownership and gate "edit own" / "delete own" permissions.
- Keep editorial content (nodes) separate from operational data (ECK entities) for cleaner IA.
- Generate tokens for custom entities for use in Pathauto, Metatag, or email templates.
- Seed reference vocabularies as entities instead of taxonomy when you need extra fields per term.
- Use `status` base field to publish/unpublish custom entities without building your own workflow.
- Migrate legacy custom tables into managed content entities you can field, view, and reference.
