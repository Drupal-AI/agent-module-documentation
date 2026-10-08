# Custom Publishing Options — agent index

Define extra per-node boolean publishing states as config entities. Each option adds a boolean
**base field on `node`** (named after the option id), a node-form checkbox, a Views field/filter/sort,
and a per-option permission. Ships an Action plugin. No Drush, no plugin types of its own.

- **Create/read an option config entity, its keys, the admin route, and the auto-created field** →
  [configure/options.md](configure/options.md)
- **Permissions: the per-option permission and the admin permission (and the core-status caveat)** →
  [permissions/permissions.md](permissions/permissions.md)
- **The Action plugin and setting an option programmatically** →
  [api/action.md](api/action.md)

Key facts: config entity `custom_publishing_option` → config `custom_pub.custom_publishing_option.<id>`
(keys `id`, `label`, `description`, `publish_under_promote_options`). Admin at
`/admin/config/content/custom_publishing_option` (route `entity.custom_publishing_option.collection`).
Creating an option installs a boolean node base field `<id>`; deleting it uninstalls that field.
