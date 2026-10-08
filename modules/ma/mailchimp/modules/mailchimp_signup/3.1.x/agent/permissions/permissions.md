# Permissions

Defined in `mailchimp_signup.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer mailchimp signup entities` | Create, edit, and delete signup forms (admin routes). Restricted/trusted. |
| `access mailchimp signup pages` | View standalone signup **pages**. Does NOT affect signup **blocks** (block visibility is governed by normal block access). |

```
drush role:perm:add anonymous 'access mailchimp signup pages'
```
