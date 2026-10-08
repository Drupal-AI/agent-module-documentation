# Configuration

Mediaflow does nothing until you supply valid Mediaflow API credentials. This page
covers the settings form, its fields, and how to handle the credentials safely.

## Get your Mediaflow API credentials

In Mediaflow, create (or collect from an existing) API app to obtain three values:

- an OAuth2 **client id**,
- an OAuth2 **client secret**, and
- a long‑lived **refresh token**.

For version 2.x these are no longer bundled with the module — contact
support@mediaflow.com if you do not already have them.

## Open the settings form

1. Log in as a user with the **`administer mediaflow`** permission (restrict this to
   trusted administrators).
2. Go to **Configuration → Media → Mediaflow**, or navigate directly to
   `/admin/config/media/mediaflow`.

## Fields

- **Client ID** — the OAuth2 client id from your Mediaflow API app.
- **Client secret** — the OAuth2 client secret.
- **Refresh token** — the long‑lived refresh token. The module exchanges this for a
  short‑lived access token, caches the access token, and renews it automatically
  before it expires — so you enter the refresh token once and the integration keeps
  authenticating on its own.
- **Enforce alt‑text** — when enabled, requires alt text to be entered for imported
  images (good for accessibility).
- **Allow cropping** — permits cropping of imported images where the workflow
  supports it.
- **Video embed method** — chooses how Mediaflow video embeds are rendered.

## Save

Click **Save configuration**. The module immediately attempts to authenticate; if
the Mediaflow library appears empty in the editor UI later, re‑check these
credentials and the `use mediaflow` permission first.

## Handling the credentials safely

The client id, client secret and refresh token are effectively account‑level
secrets — treat them with care:

- Keep the **`administer mediaflow`** permission restricted to trusted
  administrators only.
- Avoid exposing the values in exported configuration that lives in a public
  repository. If you use configuration synchronisation, keep the exported config out
  of public version control, or override the sensitive keys per‑environment in
  `settings.php` (for example via `$config['mediaflow.settings']['client_secret'] =
  getenv('MEDIAFLOW_CLIENT_SECRET');`). With DDEV you can store the value in an
  environment variable — `ddev dotenv set .ddev/.env --mediaflow-client-secret=<value>`
  (keep `.ddev/.env` out of version control), then `ddev restart` — and read it with
  `getenv()` in `settings.php`.

## A note on external requests

Mediaflow talks to Mediaflow's servers over the network, and imported assets are
downloaded server‑side. Ensure your Drupal server has outbound HTTPS access to
Mediaflow's hosts, and if you run the Content‑Security‑Policy module, the module's
subscriber whitelists Mediaflow resource hosts for you.
