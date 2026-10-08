# Architecture & extension points

## Analysis pipeline

1. **Tracking.** Content entities are registered with **entity_registry**. The `EntityMeshConsumer`
   (`Plugin/EntityRegistryConsumer/EntityMeshConsumer`, id `entity_mesh`) declares which entity types/bundles
   to track from `source_types` (`getTrackedEntityTypes()`), and `shouldProcessItem()` gates each item by the
   source/target config.
2. **Processing.** `processItem($type,$id,$langcode,$phase)` runs per the processing mode (see settings doc).
   It loads the entity and calls `EntityRender::processEntity()`. Access is evaluated as the configured
   **analyzer account**, not the request user — `EntityRender` calls `checkViewAccessEntity()` per translation
   internally, so the consumer deliberately does NOT re-check against the current user.
3. **Extraction.** `EntityRender` (extends `Entity`, service `entity_mesh.entity_render`) renders each
   translation via **entity_render_context**, parses the DOM (cached in `domCache` for the request), and
   extracts hrefs/iframes/images. Each target is resolved and classified (internal entity, view, external by
   scheme, iframe, file, broken, or the synthetic `no-links` placeholder when `track_no_links` is on).
4. **Storage.** `Repository` (`entity_mesh.repository`) writes rows to the `entity_mesh` DB table
   (source_entity_type/id, target type/id, category, subcategory, target_scheme, href, langcode, …). Schema in
   `entity_mesh.install` (`entity_mesh_schema()`); there are NO config/content entities.

## Menu mesh

`Menu` (service `entity_mesh.menu`) records parent-page→child-page edges for enabled menus (MESH_TYPE
`menu`). The second consumer `entity_mesh_menu` (`EntityMeshMenuConsumer`) processes menu links.
`EntityMeshHooks` keeps edges fresh: node publish-change/delete re-queues linking sources
(`entity_mesh_mark_sources_for_target`); menu link create/update/delete rebuild or drop the affected edges.

## Reporting surfaces

- **Overview** — `OverviewController` (`/admin/reports/entity-mesh`) renders one row per case from
  `CaseRegistry` (`entity_mesh.case_registry`), a hardcoded ordered list of `CaseDefinition`s (broken links,
  orphans, etc.) with counts + deep links. The same registry feeds `hook_requirements` on the status report
  (`entity_mesh_get_insights_for_drupal_report()`).
- **Views** — ships `entity_mesh` (table), `entity_mesh_node`, `entity_mesh_media`, `entity_mesh_taxonomy`,
  `entity_mesh_domains` (in `config/optional`). Custom field plugins (`LinkSource`, `TargetUrl`,
  `TargetHrefLink`, `LinkTarget`, `SourceUrl`, `FilteredViewLink`) and filter plugins (`CategoryFilter`,
  `SubcategoryFilter`, `TargetSchemaFilter`, `TargetEntityTypeFilter`, `TargetBundleFilter`,
  `Source/TargetLangcodeFilter`, `SourceBundleFilter`, `TargetHrefFilter`, `TargeTypeLinkFilter`) live in
  `Plugin/views/`. Views Data Export integration allows exporting the inventory.

## D3 visualization

Views style `entity_mesh_d3_style` (`Plugin/views/style/EntityMeshD3Style`, theme
`views_view_entity_mesh_d3`). `render()` builds nodes/links/types via `ProcessDataForD3Trait::processData()`
and attaches libraries `entity_mesh/d3` + `entity_mesh/entity_mesh`, plus
`drupalSettings.entity_mesh.settings.fullHeight` when the display is a page. Add this style to any View over
the `entity_mesh` data to get a force-directed graph.

> The `entity_mesh/d3` library loads D3 v7 from `https://d3js.org/d3.v7.min.js` (external CDN). Sites with a
> strict CSP or offline requirement should mirror D3 locally and override the library.

## Notable services

| Service | Class | Role |
|---|---|---|
| `entity_mesh.repository` | `Repository` | DB reads/writes for the mesh table |
| `entity_mesh.entity_render` | `EntityRender` | render + extract + classify links |
| `entity_mesh.menu` | `Menu` | menu parent→child edges |
| `entity_mesh.case_registry` | `CaseRegistry` | case definitions + counts for reports |
| `entity_mesh.logger` | PSR logger | channel `entity_mesh` |

There is a legacy `entity_mesh_queue_worker` QueueWorker marked `@todo Remove` — new work goes through
entity_registry, not this queue.
