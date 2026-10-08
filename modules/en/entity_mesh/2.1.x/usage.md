Entity Mesh analyzes the links inside your content — renders each entity, extracts every href/iframe/image, resolves each to its target, and records the source→target relationships so you can report on and visually explore how pages connect (and find broken or orphan pages).

---

Entity Mesh registers content entities (nodes by default) with the **entity_registry** consumer framework; when an entity is saved or processed by cron, its `EntityMeshConsumer` renders the entity (through **entity_render_context**) as a configurable "analyzer account", extracts all links, classifies each target (internal entity / view / external http / tel / mailto / iframe / file / broken / no-links) and stores the relationships in the `entity_mesh` table. A separate menu analysis records parent-page→child-page edges for the menus you enable. Processing can be synchronous (up to a per-save link threshold) or asynchronous via the registry queue/cron. Results are exposed through Views (a `table` display plus filters and fields for source/target type, bundle, langcode, category/subcategory, scheme, href) and a bundled **D3.js** force-directed graph Views style (`entity_mesh_d3_style`). An Overview report at `/admin/reports/entity-mesh` summarizes each "case" (e.g. broken links, orphan pages) with counts and deep links, and the same case data feeds Drupal's status report. The settings form (`/admin/config/system/entity-mesh`) chooses source entity types/bundles, target types/schemes, menus, the analyzer account, and processing mode; a cron form tunes batch size. When a node's publish status changes or it is deleted, the sources that link to it are re-queued so relationships stay fresh. Both admin surfaces are gated by `restrict access: true` permissions. Depends on node, views, views_data_export, language, media, entity_render_context and entity_registry. The D3 library is loaded from the `d3js.org` CDN.

---

- See a force-directed D3 graph of how your pages link to each other.
- Find broken internal links across all analyzed content.
- Detect orphan / dead-end pages (entities that link to nothing or are linked from nothing).
- Report how many links of each category exist (internal, external, iframe, tel, mailto, file).
- Warn an editor, on the delete form, that the node/media they are deleting is referenced elsewhere.
- Track which pages are reachable through a given menu (parent→child page edges).
- Choose exactly which entity types and bundles are treated as link sources.
- Choose which entity types/bundles and external schemes count as valid targets.
- Analyze links as a specific audience (anonymous, an authenticated role set, or a named user) via the analyzer account.
- Treat absolute self-domain URLs as internal so they are resolved to entities.
- Reclassify links to physically-present but untracked public files as valid instead of broken.
- Export the link inventory via the Views Data Export integration.
- Process link analysis in the background (asynchronous) to avoid slowing entity saves.
- Process simple content synchronously on save while auto-queueing link-heavy content.
- Limit how many entities are processed per cron run to avoid timeouts.
- Rebuild/clear all mesh data from the entity_registry consumer detail actions.
- Surface link-health "cases" (broken links, orphans) on the site status report.
- Filter the report by source/target entity type, bundle, language, category, subcategory, scheme or href.
- Keep relationships current automatically when a target node is unpublished or deleted.
- Include media entities as link targets so unused/embedded media relationships are visible.
- Build a custom View over the `entity_mesh` data and render it with the D3 style on its own page.
- Audit cross-language link structure using the source/target langcode filters.
- Identify pages that embed external iframes across the site.
