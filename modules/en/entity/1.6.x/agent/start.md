# entity — agent start

Developer framework for custom content entity types. No UI/config of its own; you wire its
handlers/providers into your entity type's annotation. No dependencies. Provides permissions
via callback (`EntityPermissions::buildPermissions`).

- Generic permissions + access control handlers → [api/access.md](api/access.md)
- Query-level access filtering (queries, Views, lists) + `QueryAccessEvent` → [api/query-access.md](api/query-access.md)
- Code-defined bundles (`BundlePluginInterface`, `BundleFieldDefinition`) → [api/bundle-plugins.md](api/bundle-plugins.md)
- Revisions base class + revision/route/task providers → [api/revisions-routing.md](api/revisions-routing.md)
- Duplicate entities/bundles + `EntityDuplicateEvent` → [extend/duplicate.md](extend/duplicate.md)
- Generated permissions reference → [permissions/permissions.md](permissions/permissions.md)
