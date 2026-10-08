# Permissions

Contact Storage defines **no permissions of its own** (there is no
`contact_storage.permissions.yml`). All of its admin surfaces reuse a single **core Contact**
permission.

| Permission | Provided by | Gates |
|---|---|---|
| `administer contact forms` | core `contact` | The message list, view/edit/delete of stored messages, bulk delete, the `contact_storage.settings` form, and clone/enable/disable of contact forms |

Where it is enforced:

- Set as the `admin_permission` on the `contact_message` entity type (`hook_entity_type_alter`).
- The `_permission: 'administer contact forms'` requirement on the settings and bulk-delete
  routes (`contact_storage.routing.yml`) and on the collection route (`ContactRouteProvider`).
- The `access: perm` of the bundled `contact_messages` view.

```
drush role:perm:add site_manager 'administer contact forms'
```

Who may **submit** a contact form (and therefore create a stored message) is still governed by
core Contact's own permissions such as `access site-wide contact form` and
`access personal contact form`.
