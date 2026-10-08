# Permissions

`social_wall.permissions.yml` defines one permission.

| Permission | Machine name | Grants |
| --- | --- | --- |
| Administer social networks | `administer social networks` | Full access to the `social_network_config` list/add/edit/delete routes under `/admin/config/services/social-wall` |

It is the `admin_permission` of the `social_network_config` config entity and the `_permission`
requirement on all four `entity.social_network_config.*` routes. Because network settings include API
credentials, treat it as an administrative permission. Placing/arranging the **Social wall block**
itself is governed by core's `administer blocks` (Block Layout), not this permission.

No other permission is defined; there is no per-view / front-end permission — the wall's visibility is
whatever the block's own placement/visibility conditions allow.
