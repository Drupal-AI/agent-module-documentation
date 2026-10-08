# Simplify — permissions

Defined in `simplify.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer simplify` | Access the settings form (`/admin/config/user-interface/simplify`) **and** see the per-bundle "Simplify" section on content-type / comment-type / vocabulary / block-type edit forms. |
| `view hidden fields` | Users **with** this permission are exempt from Simplify — they see every hidden field normally. |

## How visibility is decided

`simplify_hide_fields()` hides the configured elements only when the user does **not** have
`view hidden fields` — with one override:

- User 1 and users with an admin role implicitly have all permissions (including
  `view hidden fields`), so by default they always see hidden fields.
- Setting the `simplify_admin` flag to `true` (checkbox "Hide fields from admin users" on the
  settings form) forces those admin/super-admin users to also get the simplified forms.

So the effective rule is: a field is hidden when
`!hasPermission('view hidden fields')  OR  (isAdminUser && simplify_admin === true)`.

```bash
# Let a role bypass Simplify entirely:
drush role:perm:add editor 'view hidden fields'

# Grant access to the settings form + per-bundle Simplify sections:
drush role:perm:add site_admin 'administer simplify'
```
