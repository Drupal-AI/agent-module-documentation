# Permissions

Defined in `paragraphs_ee.permissions.yml` (one permission).

| Permission | Gates |
|---|---|
| `administer paragraphs categories` | Create, edit, delete and list **Paragraphs category** config entities at `/admin/structure/paragraphs_category` (all `entity.paragraphs_category.*` routes). Also the config entity's `admin_permission`. |

There is no separate permission for the dialog itself — the enhanced widget is shown to anyone
who can edit the host content and use the Paragraphs field. The off-canvas browser route
(`paragraphs_ee.paragraphs_browser`) is gated by core `access content`.

```
drush role:perm:add content_admin 'administer paragraphs categories'
```
