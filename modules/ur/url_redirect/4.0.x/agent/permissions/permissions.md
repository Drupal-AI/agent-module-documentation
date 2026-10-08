<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `url_redirect.permissions.yml`. All three gate the admin routes in
`url_redirect.routing.yml`; none affect whether a redirect fires (redirects run for any
visitor based on the rule's role/user config).

| Permission | Title | Gates |
|---|---|---|
| `access url redirect settings page` | Access URL Redirect Settings | the collection list + the Add form (routes `entity.url_redirect.collection`, `.add_form`). Also the entity's `admin_permission`. |
| `access url redirect edit page` | Access URL Redirect Edit Page | the Edit form (`entity.url_redirect.edit_form`). |
| `access url redirect delete page` | Access URL Redirect Delete | the Delete form (`entity.url_redirect.delete_form`). |

Grant with core APIs, e.g.:

```bash
drush role:perm:add editor 'access url redirect settings page'
```

Note: these are UI-management permissions only. The redirect behavior itself is unconditional
for matching visitors — there is no "bypass redirect" permission.
