# Per-tag permissions

Provided dynamically via `permission_callbacks` →
`Drupal\metatag_extended_perms\MetatagPermissions::permissions` (no static
`.permissions.yml` list). One permission is generated **per meta tag** currently available
on the site, so enabling more tag submodules adds more permissions.

- Grant at `/admin/people/permissions`; each tag becomes its own checkbox per role.
- Access is enforced on the Metatag field widget: a role only sees tags it may edit.
- Caveat (README): with many tags the permissions page can become very large/slow.
- Pair with core **Field Permissions** to also gate the Metatag field as a whole.
