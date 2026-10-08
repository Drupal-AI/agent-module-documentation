# Configuration

Everything Acquia DAM does at runtime depends on a live connection to your DAM
(Widen) account, so configuration has two parts: **connect the site** (a one-time
admin task) and **authorize each editor** (once per person). After that you tune
metadata mapping, image styles, and whether individual media types download files
locally. All of the Drupal-side configuration lives in the **`acquia_dam.settings`**
config object and can be inspected offline with `drush cget acquia_dam.settings`.

## A note on credentials

The DAM **client secret** is a secret. Do **not** paste it into configuration that
gets exported and committed. Instead, install the **Key** module, store the secret
in a Key entity (the env-variable key provider is a good choice), and point Acquia
DAM at it with the `key_id` setting. Keep the raw secret in an environment
variable, never in version control.

## Open the settings forms

All the forms below require the **Administer Acquia DAM** permission
(`administer acquia_dam`), and the metadata, image-styles and integration-links
forms additionally require the site to already be connected.

| Form | Path | What it controls |
|------|------|------------------|
| **Acquia DAM** (main) | `/admin/config/acquia-dam` | DAM domain and the OAuth connection |
| **Metadata** | `/admin/config/acquia-dam/metadata` | which DAM metadata fields may be mapped onto media types |
| **Image styles** | `/admin/config/acquia-dam/image-styles` | which image styles are offered for DAM image assets |
| **Integration links** | `/admin/config/acquia-dam/integration-links` | integration-link behavior |

## Step 1 — Connect the site

1. On the main form (`/admin/config/acquia-dam`), enter your DAM **domain** — for
   example `mycompany.widencollective.com`. While this is empty the site counts as
   not connected.
2. Provide the OAuth **client id** and **client secret**. Prefer storing the secret
   in a Key entity and selecting it via **key_id** rather than typing it inline.
3. Complete the **site-level OAuth handshake** at `/acquia-dam/auth`. Once this
   succeeds the site is authenticated and the metadata, image-style and
   integration-link forms unlock.

To disconnect the site later, use the disconnect confirmation at
`/acquia-dam/disconnect`.

## Step 2 — Each editor authorizes their own DAM account

The site connection is not enough on its own — every user who will browse DAM
assets must also authorize their personal DAM account:

1. Give their role the **Authorize with Acquia DAM** permission
   (`authorize with acquia dam`).
2. They visit their own **/user/{user}/acquia-dam** page and follow the authorize
   link. They can log out of the DAM again from the same area.

```bash
# let editors connect their own DAM account
drush role:perm:add editor 'authorize with acquia dam'
# site admins configure the connection
drush role:perm:add administrator 'administer acquia_dam'
```

## The settings keys, field by field

These are the keys in `acquia_dam.settings` that the forms manage:

- **domain** — your DAM (Widen) domain. Empty means "not connected."
- **auth_type** — the authentication type used for the connection.
- **client_id** — the DAM OAuth client id.
- **client_secret** — the DAM OAuth client secret. Prefer `key_id` instead of a
  value here.
- **key_id** — the id of a Key entity that holds the DAM secret. This is the
  recommended way to supply the secret.
- **allowed_image_styles** — the image style machine names offered for image
  assets (set from the Image styles form).
- **allowed_metadata** — which DAM metadata names media types are allowed to map
  (set from the Metadata form).
- **asset_file_directory_path** — the local directory where downloaded files land.
  It defaults to `dam/[media:acquia_dam_asset_id:external_id]` and accepts tokens,
  relative to the default file scheme.

## Metadata mapping

On the **Metadata** form you choose which DAM metadata fields (description,
keywords, and so on) are eligible to be mapped onto your media types. Once a field
is allowed here, you wire it to a specific media field on that media type's own
field mapping. Keeping the mapping up to date is handled by the
`acquia-dam:asset-metadata-sync` Drush command and by cron.

## Image styles

The **Image styles** form restricts which of your site's image styles are offered
when rendering DAM image assets, so editors only see the renditions you intend.

## Step 3 — Decide which media types download locally

Whether an asset is copied into Drupal or referenced remotely is set **per media
type**, on that type's media source configuration (not in `acquia_dam.settings`).
The relevant source-configuration settings are:

- **download_assets** — when on, the file is downloaded and synced locally;
  otherwise the asset is referenced remotely and the DAM stays the single source of
  truth.
- **preserve_filename_case** — keep the original filename's capitalization on
  download.
- **uri_scheme** — where downloaded files are stored (`public`, `private`, or the
  module's own `acquia-dam://` stream wrapper).

You can inspect or change these per type from the command line:

```bash
drush cget media.type.acquia_dam_image_asset source_configuration
```

## Keeping assets fresh

Once connected, the module keeps embedded assets current through cron, an update
queue, and the **asset update check** action (usable as a bulk media action).
Editors are warned when a referenced asset has a newer version or has expired. For
manual runs, the module provides Drush commands such as
`drush acquia-dam:update-assets` (refresh changed assets) and
`drush acquia-dam:asset-metadata-sync` (pull the latest metadata) — see the
[`agent/`](../../agent/start.md) docs for the full command list.
