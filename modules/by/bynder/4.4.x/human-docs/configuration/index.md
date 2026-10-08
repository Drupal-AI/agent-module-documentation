# Configuration

## Open the settings form

Go to **Configuration → Media → Bynder** (`/admin/config/services/bynder`). You need
the **Administer bynder configuration** permission (a restricted permission). All
values are saved to the `bynder.settings` configuration object.

## Step 1 — Credentials and connection

- **Account domain** *(required)* — your Bynder domain, e.g. `name.bynder.com` (any
  trailing slash is stripped when you save).
- **Permanent token** *(required)* — a Bynder permanent API token. Create one in
  Bynder under your account's API settings (`your-domain/pysettings`). This is used
  for global, server-to-server asset access.
- **Client ID** and **Client secret** — the credentials of an OAuth2 app in Bynder.
  These are needed for user-attributed features such as uploading, so that uploads
  are credited to the editor's own Bynder account.
- **OAuth redirect URL** — a read-only value the form displays. Copy it into your
  Bynder OAuth app's "Authorization redirect URIs" list.
- **Test connection before saving** *(on by default)* plus a **Test connection**
  button — this calls Bynder with the token and domain you entered. If the test
  fails, saving is blocked (uncheck the box to save anyway).
- **Debug** — verbose logging of every API call to the `bynder` log channel. Leave
  off in production.

Remember the tip from [Installation](../installation/index.md): for real
environments, override the token and secret per environment from `settings.php`
rather than storing them in exported config.

## Step 2 — Usage restrictions (appears once credentials work)

Bynder can encode each asset's usage rights (royalty-free, web, print) in a
metaproperty. Map that here:

- **Usage metaproperty** — pick which Bynder metaproperty holds the usage rights.
- **Restrictions** — map each license level (**royalty free**, **web license**,
  **print license**) to the corresponding metaproperty option. If you leave these
  unset, assets are treated as royalty-free.

## Step 3 — Metadata sync and performance

- **Metadata update frequency** *(default 604800 seconds = 7 days)* — how often cron
  refreshes the locally stored copy of each asset's metadata. The **Update local
  metadata** button runs the refresh immediately as a batch.
- **Cache life time** *(default 86400 seconds = 24 hours)* — how long metaproperties,
  derivatives, and tags are cached to avoid repeated API calls.
- **Timeout** *(default 10 seconds)* — the per-request API timeout.
- **Use remote images** *(off by default)* — serve remote Bynder thumbnails without
  downloading them locally. Only available if the Remote Stream Wrapper module is
  installed.
- **Bynder image derivatives** — lists the standard derivatives (`mini`, `webimage`,
  `thul`) plus any custom ones. The **Update cached information** button re-fetches
  derivatives, metaproperties, and tags from Bynder.

## Step 4 — Create a Bynder media type

1. Go to **Structure → Media types → Add media type**.
2. Give it a name (e.g. "Bynder image") and set **Media source** to **Bynder**.
3. Save. The module automatically adds the shared metadata field and a
   transformations field to Bynder media types.
4. On the media type's **Field mapping**, map the Bynder metadata attributes you want
   (name, description, tags, dimensions, custom metaproperties, and so on) to fields.
5. On **Manage display**, choose the matching Bynder formatter for the source field —
   **Bynder** for images (with derivative, responsive, and transformation options),
   **Bynder document**, or **Bynder video**.

## Step 5 — Wire up the Entity Browser widgets

1. Go to **Configuration → Content authoring → Entity browsers** and add (or edit) an
   Entity Browser.
2. Add the **Bynder search** widget so editors can browse and insert existing assets.
   Configure which media types new pins/documents/videos become, and whether only a
   single file may be selected.
3. Optionally add the **Bynder upload** widget so editors can upload new files to
   Bynder. This needs OAuth configured, the editor's Bynder account to have upload
   rights, and the DropzoneJS module.
4. Reference the Entity Browser from a media or media-library field on your content
   type. Editors now get the Bynder browser right where they add media.

## OAuth login flow

When OAuth is configured, an editor using an upload/search flow that needs user
attribution is sent to Bynder to authorize, and returns to the module's callback
(`/bynder-oauth`), which stores their access token in the session. Changing the
global configuration invalidates existing OAuth sessions so everyone re-authorizes
against the current settings.

## Permissions

- **Administer bynder configuration** *(restricted)* — access to the settings form.
- **View bynder media usage** — access to the per-node **Bynder media usage** tab,
  which lists the Bynder assets referenced by a node.
