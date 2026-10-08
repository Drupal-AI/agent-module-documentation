# Catalog listings, URL aliases, breadcrumb & 404 redirect

## Shipped Views (config/optional)

| View id | Page display route | Path | Purpose |
|---|---|---|---|
| `apigee_api_catalog` | `view.apigee_api_catalog.page_1` | `/apis` | Public "API Catalog" listing of `apidoc` nodes (the "APIs" menu link). Base table `node_field_data`. |
| `api_catalog_admin` | `view.api_catalog_admin.page_1` | `/admin/content/apis` | Admin "API catalog" listing (label "APIDoc Catalog Admin"), reachable as a tab under **Content** and as a menu item under `system.admin_content`. |

Both are imported only if `views` is enabled (they live in `config/optional`, and `UpdateService`
imports them conditionally on legacy updates). Customize them at **Structure → Views**. The
admin listing is where the **OpenAPI** add-action link (`node.apidoc.add_form`) and the per-node
Re-import operation appear.

## `/api/{id}` aliases

On save of an `apidoc` node without an existing alias, `hook_node_update` creates a `path_alias`
`/node/{nid}` → `/api/{nid}` (see [../hooks/node-lifecycle.md](../hooks/node-lifecycle.md)). The
SmartDocs renderer expects this `/api/{entityId}` pattern, so keep it if you rely on SmartDocs.

## 404 redirect subscriber

`apigee_api_catalog.page_not_found_subscriber`
(`EventSubscriber\PageNotFoundEventSubscriber`, args `@path.matcher`, `@path.validator`) subscribes to
`KernelEvents::EXCEPTION`. On a `NotFoundHttpException` whose request URI matches `/api/*/*`, it
extracts the id segment, and if `/api/{id}` is a valid path it issues a `RedirectResponse` there. This
lets deep SmartDocs sub-paths (e.g. `/api/{id}/operations`) resolve back to the doc's canonical page.

## Breadcrumb

`apigee_api_catalog.breadcrumb` (`ApigeeApiCatalogBreadcrumbBuilder`, breadcrumb_builder priority
1000) applies on any route carrying an `apidoc` node and sets the trail to
**Home → API Catalog** (the "API Catalog" crumb links to `view.apigee_api_catalog.page_1`), cached per
`route`.

## Access / RBAC

`apidoc` is a plain node type, so access is standard node access. The module defines no permissions of
its own; use any contrib node-access module (the README recommends
[`permissions_by_term`](https://www.drupal.org/project/permissions_by_term)) to restrict which docs a
role can view. The Re-import operation and form require node **update** access on the bundle.
