<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site API

## Endpoints
- `GET /jsonapi/self` → `SiteApiController::self` — this site's entity data.
  Permission `access site data api`. Auth: `basic_auth`, `cookie`, `key_auth`, `ip_consumer_auth`.
- `POST /jsonapi/action/{plugin_id}` → `SiteApiController::action` — run a Site Action plugin.
  Permission `access site actions pages`. Same auth set.
- `GET/POST` entity routes for `site` (add/collection/refresh/revision) under `/site/...` and
  `/admin/content/site/...`, permission-gated (`administer sites`, `refresh site data`, etc.).

## Remote reporting & overrides
- `site.remote` POSTs this site's data to a configured **Site Data Destination** (another site / Site Manager).
- **Site Overrides**: a remote receiver may override selected config/fields/state — configure which are allowed on the settings form.

## Plugins
- SiteProperty plugins (`plugin.manager.site_property`) populate entity properties.
- SiteAction plugins (`plugin.manager.site_action`) are the actions invoked by the action routes.

## Security
Every API route requires an explicit permission; key_auth/basic_auth supported. The permission
`bypass site action user login password requirement` weakens the User Login action — grant only when intended.
