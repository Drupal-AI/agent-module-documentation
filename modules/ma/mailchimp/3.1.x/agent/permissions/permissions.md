# Permissions

Base module defines one permission in `mailchimp.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer mailchimp` | Access all Mailchimp configuration (settings, OAuth, audiences, fields). Restricted/trusted. |

Submodules add their own: `mailchimp_campaign` → `administer mailchimp campaigns`;
`mailchimp_signup` → `administer mailchimp signup entities`, `access mailchimp signup pages`;
`mailchimp_events` its own. Most admin routes also apply a
`_mailchimp_configuration_access_check` that additionally requires the account to be
configured/connected.

```
drush role:perm:add administrator 'administer mailchimp'
```
