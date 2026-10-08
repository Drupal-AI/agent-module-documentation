# Permissions

Defined in `mailjet_api.permissions.yml`.

| Permission | Restricted | Grants |
|------------|------------|--------|
| `administer mailjet api` | `restrict access: true` | Access to both module routes: the settings form (`mailjet_api.admin_settings_form`, `/admin/config/services/mailjetapi/settings`) and the test-email form (`mailjet_api.test_email_form`, `.../settings/test`). |

This is the only permission the module defines. Both routes gate on it via
`_permission: 'administer mailjet api'`. `restrict access: true` marks it as sensitive, so Drupal
warns before granting it to a role.
