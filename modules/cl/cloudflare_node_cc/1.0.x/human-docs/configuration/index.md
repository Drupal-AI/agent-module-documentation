# Configuration

Configuring the module has four parts: put your Cloudflare credential in a Key,
choose the authentication type, set your zone(s), and grant the purge permission.

## Step 1 — Store your Cloudflare credential in a Key

The module reads secrets from a **Key** entity rather than storing them directly:

1. Make sure the **Key** module is enabled (it is a dependency).
2. Go to **Configuration → System → Keys → Add key** and create a Key holding
   either your Cloudflare **Global API Key** or an **API token**, depending on
   which auth style you'll use.

> **Keep the secret out of the database and config.** The environment‑variable or
> file key provider is recommended. With DDEV you can store the value as an
> environment variable — `ddev dotenv set .ddev/.env --cloudflare-token=<value>`
> then `ddev restart` — and point the Key's provider at it.

## Step 2 — Open the settings form and choose an auth type

Go to **Configuration → Web services → Cloudflare Node Cache Clear**
(`/admin/config/cloudflare-node-cache-clear`); it requires the **Administer
cloudflare_node_cc** permission. The settings are stored in Drupal's **state**
(they are not part of exported configuration). Set:

- **Auth type** — choose **Key** (Global API Key) or **Token**. Configure only
  one of the two.
- **Account email** — required for the Global API Key auth style only.
- **API key name / API token name** — select the **Key entity** (by name) that
  holds the corresponding secret from step 1.

## Step 3 — Set your zone(s)

- **Zone ID** — the default single Cloudflare zone to purge.
- **Multiple zones per language/domain** — enable this if your site is served
  from several hostnames or languages, then map each **language** to its **zone
  ID** and, where relevant, to its **domain**. This lets a purge target the right
  Cloudflare zone for the content's language.

## Step 4 — Grant the purge permission

On **People → Permissions**, give the **Cloudflare Node Cache Clear: purge cache**
permission to the editor roles that should be allowed to purge.

## Optional — restore the client IP

- **Restore client IP** — when enabled, an event subscriber rewrites the
  visitor's IP from Cloudflare's `CF-Connecting-IP` header so Drupal logs the real
  client rather than Cloudflare's proxy.

> **Only enable this behind a proper Cloudflare‑only guard.** The subscriber trusts
> the `CF-Connecting-IP` header unconditionally, so before turning it on make sure
> Drupal's `trusted_host` / reverse‑proxy settings accept traffic **only** from
> Cloudflare's IP ranges. Otherwise a client could spoof its IP by sending that
> header directly.

## Using it

Once configured:

- **Per node:** open a node's **edit** page and use the purge **action button** to
  clear that node's URL from the edge cache.
- **Whole site / zone:** use the **Purge Cloudflare Cache** item in the Admin
  Toolbar Tools menu, or visit
  `/admin/cloudflare-node-cache-clear/purge-cache`.
