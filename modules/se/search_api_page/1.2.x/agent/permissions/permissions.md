<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `search_api_page.permissions.yml`:

| Permission | Title | Gates |
|---|---|---|
| `administer search_api_page` | Administer Search pages | Create/edit/delete `search_api_page` config entities and the whole admin UI at `/admin/config/search/search-api-pages` (this is the entity's `admin_permission`, required by every `entity.search_api_page.*` route). Trusted — effectively site-builder level. |
| `view search api pages` | Use search | Viewing/using the front-end search pages the module serves. |

Grant example:

```bash
drush role:perm:add anonymous 'view search api pages'
drush role:perm:add content_editor 'administer search_api_page'
```

Note the machine names differ in style: the admin one is `administer search_api_page`
(underscored, matches the module/entity id); the front-end one is `view search api pages`
(spaced).
