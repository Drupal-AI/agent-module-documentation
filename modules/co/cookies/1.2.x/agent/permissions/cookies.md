# Permissions

Defined in `cookies.permissions.yml` (three permissions).

| Permission | Gates |
|---|---|
| `configure cookies config` | The base configuration form (`cookies.config`, `/admin/config/system/cookies/config`) and the `cookies.overview` landing page — cookie name/lifetime, CDN, group consent, styling, etc. |
| `configure cookies widget texts` | The banner/widget texts form (`cookies.texts`, `/admin/config/system/cookies/texts`). |
| `administer cookies services and service groups` | Creating/editing/deleting the `cookies_service` and `cookies_service_group` config entities (all `entity.cookies_service.*` and `entity.cookies_service_group.*` routes). |

All three are administrative/trusted. The public routes (`cookies.getServices`, `cookies.callback`,
`cookies.cookies_documentation`) require only `access content`.

```
drush role:perm:add site_manager 'configure cookies config'
```
