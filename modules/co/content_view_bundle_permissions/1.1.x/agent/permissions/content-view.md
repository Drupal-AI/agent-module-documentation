<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-bundle content-view permissions

## Install / enable

`drush en content_view_bundle_permissions`. Pulls in core `views` and `node` (both usually
already on). No configuration objects to set up, no settings form. Immediately after enable, the
new permissions appear on `/admin/people/permissions` and take effect on the `content` view.

## Permissions

Defined dynamically per node type by `ContentViewBundlePermissions::permissions()`
(`src/ContentViewBundlePermissions.php`), registered as a `permission_callbacks` entry in
`content_view_bundle_permissions.permissions.yml`. Uses core `BundlePermissionHandlerTrait` over
`NodeType::loadMultiple()`. For a node type with machine id `<type>`:

- `view any <type> in content view` — `getAnyPermission()`; title *"%label: View any in content
  view"*.
- `view own <type> in content view` — `getOwnPermission()`; title *"%label: View own in content
  view"*.

A role with no matching permission sees **no rows** of that bundle in the content listing.

## How filtering works (`Service\Hook\ViewsQueryAlter`)

Called from `hook_views_query_alter` (`.module`) via service
`content_view_bundle_permissions.views_query_alter`. Early-returns unless `$view->id() === 'content'`.
For each node bundle from `@entity_type.bundle.info`:

1. If the user has `view any <bundle> in content view` → `continue` (no restriction; all rows of
   that bundle stay).
2. Otherwise a new OR where-group is opened (`$query->setWhereGroup('OR')`) with condition
   `node_field_data.type != <bundle>`.
3. If the user additionally has `view own <bundle> in content view`, the group also adds
   `node_field_data.uid = <current user id>`.

Because each bundle's group is AND-combined with the others, the net effect for a restricted role
is: keep rows whose type the role may see, plus (for `view own` bundles) that role's own nodes.
This is **default-deny / fail-closed**: absent any permission a bundle is fully excluded; the code
never adds a clause that broadens visibility. Note it only *narrows* the `content` view (normally
gated by core's `access content overview`); it cannot grant access the base view didn't already
allow.

## Exposed-filter form (`Service\Hook\FormViewsExposedFormAlter`)

Called from `hook_form_views_exposed_form_alter`. Also guarded to `view->id() === 'content'`. For
each bundle where the user has neither the `any` nor the `own` permission, it `unset()`s that
bundle from `$form['type']['#options']`, so the *Content type* exposed filter only offers bundles
the query would actually return.

## Scope & caveats

- **Views listing only.** Enforcement lives entirely in Views query/form alters for the `content`
  view. The module does **not** implement `hook_node_access` or node access grants, so canonical
  `/node/{id}` pages, JSON:API, REST, and other Views are unaffected — the permission name (*"in
  content view"*) is honest about this. Do not treat it as a global content-hiding mechanism.
- Only the View with machine id `content` is altered. A site that renamed/replaced the default
  admin content View, or uses a different listing, gets no filtering.
- Depends on the node type set at request time (`@entity_type.bundle.info`); new bundles get their
  two permissions automatically (clear caches to surface them on the permissions page).
- Ships no configuration objects, no config schema, and no settings form — there is nothing to
  export or set. All behavior derives from role permission assignments.
