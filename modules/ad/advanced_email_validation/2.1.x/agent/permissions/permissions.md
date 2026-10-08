# Permissions

| Permission | Gates |
|---|---|
| `administer advanced email validation` | Access the settings form (`/admin/config/people/advanced-email-validation`) and change all rules, domain lists, error messages, and `validate_account_on`. |

Only one permission. The validation itself runs automatically for anyone creating/updating a
user account (no permission required to be *subject* to validation). The Webform handler is
managed via Webform's own admin permissions.
