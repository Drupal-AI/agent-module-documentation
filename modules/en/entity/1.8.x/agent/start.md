# entity — agent start

Developer framework for custom content entity types. No UI/config of its own; you wire its
handlers/providers into your entity type's annotation. No dependencies. Provides permissions
via callback (`EntityPermissions::buildPermissions`).

- Generic permissions + access control handlers → [api/access.md](api/access.md)
- Query-level access filtering (queries, Views, list builders, JSON:API) + `QueryAccessEvent` → [api/query-access.md](api/query-access.md)
- Code-defined bundles (`BundlePluginInterface`, `BundleFieldDefinition`) → [api/bundle-plugins.md](api/bundle-plugins.md)
- Revisions base class + revision/route/task providers → [api/revisions-routing.md](api/revisions-routing.md)
- Duplicate entities/bundles + `EntityDuplicateEvent` → [extend/duplicate.md](extend/duplicate.md)
- Generated permissions reference → [permissions/permissions.md](permissions/permissions.md)

Version note: `1.8.x` (release `8.x-1.8`) targets Drupal `^10.1 || ^11`. The access-control,
permission-provider, and query-access APIs are unchanged from `1.7.x`; the JSON:API collection
filter-access mapping (`hook_jsonapi_entity_filter_access`) is the area that changed in this
release — see [api/query-access.md](api/query-access.md).
