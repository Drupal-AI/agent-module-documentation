# Permissions

Defined in `easy_email.permissions.yml`. Two axes: **templates** (`easy_email_type` config)
and **email entities** (`easy_email` content / the log).

## Global settings & templates
| Permission | Gates |
|---|---|
| `access easy email settings` | The global settings & theme settings forms (`easy_email.settings`). Restricted. |
| `administer email types` | Admin permission for templates — create/edit/delete (also Field UI on templates). Restricted. |
| `access the email types overview` | View the templates list page. |
| `create email types` | Create a new template. |
| `edit email types` | Edit templates. |
| `delete email types` | Delete templates. |
| `preview email types` | Preview a template. |

## Email entities (the log & individual emails)
| Permission | Gates |
|---|---|
| `administer email entities` | Admin permission for `easy_email` entities. Restricted. |
| `add email entities` | Create new Email entities. |
| `edit email entities` | Edit Email entities. |
| `delete email entities` | Delete Email entities. |
| `view own email entities` | View emails you created. |
| `view all email entities` | View all logged emails (email log). |
| `view all email revisions` | View email revisions. |
| `revert all email revisions` | Revert revisions (needs view + edit rights). |
| `delete all email revisions` | Delete revisions (needs view + delete rights). |

```
drush role:perm:add content_admin 'administer email types'
drush role:perm:add content_admin 'view all email entities'
```

Note: the `easy_email_override` submodule's override entity uses core
`administer site configuration` (it defines no permissions of its own).
