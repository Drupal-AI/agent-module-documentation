<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure & connect Acquia DAM

Central config object: **`acquia_dam.settings`**. The site talks to the DAM SaaS over OAuth,
so real asset operations need valid credentials — but the config itself is inspectable
offline (`drush cget acquia_dam.settings`).

## Admin forms (all require `administer acquia_dam`)

| Route | Path | Purpose |
|---|---|---|
| `acquia_dam.config` (the `configure` link) | `/admin/config/acquia-dam` | domain + connection / authentication |
| `acquia_dam.metadata_config` | `/admin/config/acquia-dam/metadata` | which DAM metadata may be mapped to media types |
| `acquia_dam.image_style_config` | `/admin/config/acquia-dam/image-styles` | which image styles are allowed for DAM images |
| `acquia_dam.integration_links` | `/admin/config/acquia-dam/integration-links` | integration-link behavior |

The three latter forms also require the site to be authenticated
(`_acquia_dam_site_authenticated_access_check`).

## `acquia_dam.settings` keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `domain` | string | `''` | DAM (Widen) domain, e.g. `mycompany.widencollective.com`. Empty = not connected. |
| `auth_type` | string | — | authentication type used for the connection |
| `client_id` | string | — | DAM OAuth client id |
| `client_secret` | string | — | DAM OAuth client secret (prefer storing via `key_id`) |
| `key_id` | string | — | id of a **Key** entity holding the DAM secret (recommended over inline `client_secret`) |
| `allowed_image_styles` | sequence | — | image style machine names offered for image assets |
| `allowed_metadata` | sequence | — | metadata names allowed to be mapped by media types |
| `asset_file_directory_path` | string | `dam/[media:acquia_dam_asset_id:external_id]` | local dir for downloaded files (tokens allowed, relative to default scheme) |

```bash
drush cget acquia_dam.settings
drush cget acquia_dam.settings domain
```

## Connecting (authentication flow)

1. Set the `domain` and OAuth `client_id`/secret (store the secret in a Key entity and set
   `key_id`). The Key module is a dev/optional dependency — enable it and create a Key.
2. **Site authentication**: `/acquia-dam/auth` (`acquia_dam.site_auth`, admin only) performs
   the site-level OAuth handshake. Disconnect via `/acquia-dam/disconnect`
   (`acquia_dam.disconnect_site`).
3. **Per-user authorization**: each editor authorizes their own DAM account at
   `/user/{user}/acquia-dam` (`entity.user.acquia_dam_auth`) → `/user/acquia-dam/auth`.
   Requires `authorize with acquia dam`. Logout: `/user/acquia-dam/logout`.

An `AuthenticationService` (`acquia_dam.authentication_service`) and a client factory
(`acquia_dam.client.factory`) back these; a custom access check
(`acquia_dam.site_authenticated_access_check`) gates the config forms that need a live
connection.

## Local download vs remote reference

Whether assets are copied locally is **per media type**, on the media source configuration
(not this settings object) — see [../plugins/media-source.md](../plugins/media-source.md)
(`download_assets`, `uri_scheme`, `preserve_filename_case`). The
`asset_file_directory_path` here is where downloaded files land.

## Config schema highlights

`acquia_dam.schema.yml` also defines schema for the media source
(`media.source.acquia_dam_asset:*`), field formatters (`acquia_dam_embed_code`,
`acquia_dam_thumbnail`, `embed_style`, `acquia_dam_responsive_image`), the media-library
widget, the Views metadata filters (`asset_metadata_string`, `asset_metadata_in_operator`),
and the `asset_update_check_action` action.
