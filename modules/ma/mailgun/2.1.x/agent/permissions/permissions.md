<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mailgun permissions

The module defines one permission (`mailgun.permissions.yml`):

| Permission | Gates | Notes |
|---|---|---|
| `administer mailgun` | The Mailgun settings form (`/admin/config/services/mailgun/settings`) and the Test Email form (`/admin/config/services/mailgun/settings/test`). | `restrict access: true` — grant only to trusted administrators (it exposes the API key and can send mail). |

Grant it with:

```bash
drush role:perm:add administrator 'administer mailgun'
```

The `mailgun_mailing_lists` submodule reuses this same `administer mailgun` permission for its
own routes; it defines no separate permissions.
