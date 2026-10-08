The Entity API module supplies reusable, developer-facing building blocks — generic permissions, access control, query-level access filtering, code-defined bundles, revision UI, and route providers — that custom content-entity types would otherwise have to reimplement by hand.

---

`entity` is a framework module with no UI of its own; it is a dependency for many contrib projects (notably Drupal Commerce and Profile) and a toolkit for anyone building custom content entity types. Its `EntityPermissionProvider`/`UncacheableEntityPermissionProvider` generate the full matrix of view/create/update/duplicate/delete (own/any, per bundle) permissions automatically, and the matching `EntityAccessControlHandler` enforces them so you never write boilerplate access logic. A `QueryAccess` API extends that enforcement to entity queries, Views, and list builders, filtering rows a user may not see and exposing a `QueryAccessEvent` to add custom conditions. It ships route providers (`DefaultHtmlRouteProvider`, `AdminHtmlRouteProvider`, `RevisionRouteProvider`, `DeleteMultipleRouteProvider`) plus local task/action providers that wire up canonical, add, edit, delete, revision, and duplicate pages from entity link templates. For versioned data it offers `RevisionableContentEntityBase` and a revision overview/revert/delete UI. Bundle plugins (`BundlePluginInterface` + `BundleFieldDefinition`) let a module define entity bundles and their fields entirely in code. A `BundleEntityDuplicator` service and `EntityDuplicateEvent` support cloning entities and their bundle configuration. Together these APIs are described as things that "will be moved to Drupal core one day."

---

- Auto-generate the full view/create/update/delete permission set for a custom content entity type.
- Add per-bundle granularity permissions without hand-writing each permission string.
- Provide "own vs any" update/delete permissions for author-owned entities.
- Add "view own unpublished" access for draft content.
- Enforce entity access with `EntityAccessControlHandler` instead of custom access logic.
- Use `UncacheableEntityPermissionProvider` when you need "view own" permissions.
- Filter entity query results by access with the QueryAccess API.
- Hide inaccessible rows in Views listings automatically.
- Add custom access conditions by subscribing to `QueryAccessEvent`.
- Define an entity bundle entirely in code via a `BundlePluginInterface` plugin.
- Attach bundle fields in code using `BundleFieldDefinition`.
- Install/uninstall code-defined bundles safely via the bundle plugin installer.
- Base a versioned entity on `RevisionableContentEntityBase` for correct revision URLs.
- Give an entity a revision overview page listing all revisions.
- Add revert and delete actions for individual revisions.
- Provide a "Delete multiple" bulk confirmation form for entities.
- Wire canonical/add/edit/delete routes from link templates with the route providers.
- Use `AdminHtmlRouteProvider` to render entity forms on the admin theme.
- Generate local tasks (tabs) and local actions from entity definitions automatically.
- Duplicate an entity and its referenced data with `BundleEntityDuplicator`.
- React to entity duplication via `EntityDuplicateEvent`.
- Provide a duplicate ("Save as new") form action for content entities.
- Add a revision access check (`_entity_access_revision`) to custom routes.
- Build a bulk-operations entity list with `BulkFormEntityListBuilder`.
- Supply Views data and revision link fields for custom entities.
- Standardize entity permission naming across a suite of custom modules.
- Reuse Commerce/Profile-style entity patterns in your own project.
