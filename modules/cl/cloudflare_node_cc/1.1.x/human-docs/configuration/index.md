# Configuration

Configuring the module has four parts: put your Cloudflare credential in a Key,
choose the authentication type, set your zone(s), and grant the purge permissions.

## Step 1 — Store your Cloudflare credential in a Key

The module reads secrets from a **Key** entity rather than storing them directly:

1. Make sure the **Key** module is enabled (it is a dependency).
2. Go to **Configuration → System → Keys → Add key** and create a Key holding
   either your Cloudflare **Global API Key** or an **API token**, depending on
   which auth style you'll use. Give it the **Authentication** key type.

> **Keep the secret out of the database and config.** The environment‑variable or
> file key provider is recommended. With DDEV you can store the value as an
> environment variable — `ddev dotenv set .ddev/.env --cloudflare-token=<value>`
> then `ddev restart` — and point the Key's provider at it.

## Step 2 — Open the settings form and choose an auth type

Go to **Configuration → Web services → Cloudflare Node Cache Clear**
(`/admin/config/services/cloudflare-node-cache-clear`); it requires the
**Administer cloudflare_node_cc** permission. Set:

- **Cloudflare Auth Type** — choose **Email/API Key** or **API Token**. Configure
  only one of the two.
- **Email Address** — required for the Global API Key auth style only.
- **API Key / API Token** — select the **Key entity** (by name) that holds the
  corresponding secret from step 1.

When you save, the form validates your zone id(s) by calling the Cloudflare API
with the selected credential.

## Step 3 — Set your zone(s)

- **Default Zone Id** — the single Cloudflare zone to purge.
- **Enable Multiple Cloudflare Zones** — enable this if your site is served from
  several hostnames or languages, then map each **language** to its **zone ID** and,
  where relevant, to its **domain**. This lets a purge target the right Cloudflare
  zone for the content's language.

## Step 4 — Grant the purge permissions

On **People → Permissions**, grant:

- **Purge Cloudflare Cache** (`cloudflare_node_cc purge cache`) — allows the
  site‑wide zone purge (menu item and route).
- **Purge Cloudflare Cache Per Node** (`cloudflare_node_cc purge cache per node`) —
  adds the purge button to node edit forms.

Grant these to the editor roles that should be allowed to purge.

## UI and behaviour options

- **Confirm cache clear** — show a confirmation step before a site‑wide purge from
  the menu.
- **Log each purge request** — write a log message every time a purge runs.
- **Always purge CF on node save** — reuse the normal **Save** button for the purge
  instead of adding a separate "Save & Purge" button.
- **Purge front page when its node is purged** — also clear the site root if the
  node being purged is the configured front page.

## Optional — restore the client IP

- **Restore Client IP Address** — when enabled, an event subscriber rewrites the
  visitor's IP from Cloudflare's `CF-Connecting-IP` header so Drupal logs the real
  client rather than Cloudflare's proxy. As with any Cloudflare‑fronted site, pair
  this with Drupal's reverse‑proxy / trusted‑host settings and an origin firewall
  that only accepts traffic from Cloudflare's IP ranges.

## Using it

Once configured:

- **Per node:** open a node's **edit** page and use the purge **action button** to
  clear that node's URL from the edge cache.
- **Whole site / zone:** use the **Purge Cloudflare Cache** item in the Admin
  Toolbar Tools menu, or visit `/admin/cloudflare-node-cache-clear/purge-cache`.
- **From the command line:** `drush cloudflare-node-cc:flush-cache` (optionally
  scoped with `--zone`, `--path`, `--content-type`, `--nid`).
