# Admin User Language permissions

One permission, in `admin_user_language.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer admin interface language` | Access to the settings form (`admin_user_language.basic_form`, `/admin/config/admin_user_language/settings`). Required on the route via `_permission`. |

Notes:
- This permission only controls **who can change the module's settings**. It does not affect whose
  `preferred_admin_langcode` gets forced — the `hook_entity_presave()` logic runs for **all** user
  saves regardless of the acting user's permissions.
- The module also (indirectly) touches the core `language.preferred_admin_langcode` field on the user
  form: when `prevent_user_override` is TRUE the field is disabled for everyone editing a user. Note
  Drupal only shows that field to users who already have admin privileges, so non-privileged users
  never see it (as the module's README explains).
