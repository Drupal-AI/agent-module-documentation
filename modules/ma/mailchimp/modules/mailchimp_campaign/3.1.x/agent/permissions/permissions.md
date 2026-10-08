# Permissions

Defined in `mailchimp_campaign.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer mailchimp campaigns` | Create, edit, send, test, view stats for, and delete Mailchimp campaigns (all campaign routes). Restricted/trusted. |

Grant only to editors trusted to email your audiences:
```
drush role:perm:add newsletter_editor 'administer mailchimp campaigns'
```
