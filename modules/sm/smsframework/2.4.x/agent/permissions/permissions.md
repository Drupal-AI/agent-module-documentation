# Permissions

Defined in `sms.permissions.yml`:

| Permission | Restricted | Grants |
|---|---|---|
| `administer smsframework` | yes (`restrict access: 1`) | All admin routes under `/admin/config/smsframework`: settings, gateway CRUD (incl. credentials), phone-number settings. Also the `admin_permission` of the `sms_gateway` and `phone_number_settings` config entities. |
| `sms verify phone number` | no | Access the public verification form at `sms.settings:page.verify` (default `/verify`) to submit a code and verify a phone number. |

Submodules add their own: `Send SMS Blast` (sms_blast), `send to any number` (sms_sendtophone),
`sms_devel form` (sms_devel). See each submodule's docs.

Set via drush:

```
drush role:perm:add authenticated 'sms verify phone number'
```
