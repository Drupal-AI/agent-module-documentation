# Permissions

Taxonomy Manager relies mostly on **core Taxonomy permissions** and adds a few of its own.

## Permissions the module defines (`taxonomy_manager.permissions.yml`)

| Permission | Gates |
|---|---|
| `access taxonomy manager list` | The vocabulary list page, the tree editor page, the settings form, and the subtree JSON endpoints. |
| `taxonomy manager export csv for {vid}` | The **Export CSV** toolbar button, one per vocabulary (dynamic, via `TaxonomyManagerPermissions::permissions`). |
| `taxonomy manager export list for {vid}` | The **Export list** toolbar button, one per vocabulary (dynamic). |

## Core permissions that actually gate operations

The custom access check (`_taxonomy_manager_access_check`, class `TaxonomyManagerAccessCheck`)
and the toolbar `#access` flags defer to core taxonomy permissions:

- `administer taxonomy` — full access to every operation on every vocabulary (the README's
  stated requirement to use the module). Short-circuits the access check.
- `create terms in {vid}` — shows the **Add** button; add/export routes use
  `_entity_create_access: taxonomy_term:{vocabulary}`.
- `edit terms in {vid}` — gates **Move**, term edit and the AJAX term form.
- `delete terms in {vid}` — shows the **Delete** button and gates the delete route.

So a non-admin editor needs `access taxonomy manager list` plus the relevant per-vocabulary
`create/edit/delete terms in {vid}` permissions to work in the tree; grant `administer taxonomy`
for unrestricted use.

```
drush role:perm:add editor 'access taxonomy manager list'
drush role:perm:add editor 'edit terms in tags'
```
