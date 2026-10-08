# Cloudflare Purge — manual setup guide

**Cloudflare Purge** (`cloudflare_purge`) clears Cloudflare's CDN cache directly
from your Drupal site. When you put Cloudflare in front of Drupal, Cloudflare
caches your pages at its edge network — which is great for speed, but it means an
updated page can keep serving the old version until that edge cache expires. This
module lets you tell Cloudflare "drop that cached copy now," either by hand or
automatically whenever content changes.

You can purge in several ways: the **entire zone** at once (everything Cloudflare
has cached for your domain), specific **URLs**, a Drupal **cache tag** such as
`node:123`, a **URL prefix** like everything under `/blog/`, or a whole
**hostname**. Each of these is available as an admin form and as a Drush command,
so you can also purge from a deploy script or cron job. On top of that, the module
can **automatically** purge Cloudflare whenever Drupal invalidates cache tags for
the entity types you choose (nodes, taxonomy terms, media by default) — either
immediately or batched through a queue on cron so a busy site stays under
Cloudflare's rate limits.

To talk to Cloudflare you give the module an API credential and your Zone ID. It
supports a scoped **Bearer Token** (recommended — you can limit it to just the
Cache Purge permission) or the legacy **Email + Global API Key** pair. Credentials
can be stored three ways, in priority order: an override in `settings.php`, a
[Key module](https://www.drupal.org/project/key) entity (recommended for
production, so secrets stay out of the database and config export), or plain
config. The module only ever calls the fixed Cloudflare API host, so the purge
forms are not a general server-side request risk.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) add the Key module.
2. [Configuration](configuration/index.md) — enter your Cloudflare credentials,
   then optionally turn on automatic purging and tune the queue, rate limits, and
   `Cache-Tag` header.

## Where it lives in the admin menu

Everything sits under **Configuration → Cloudflare Purge**
(`/admin/config/cloudflare-purge`). That landing page links to the credentials
form, the auto-purge settings, the manual purge forms (by URL, tag, prefix,
hostname, and the destructive "Purge Everything"), the queued-tags view, the
Purge History page, and a "Plans & Limits" reference page. Which links you see
depends on your permissions.

## How to use it

After you enter and save valid credentials, the manual purge forms become active.
Pick the form that matches what you want to clear, enter the URLs / tags / prefixes
/ hostnames, and submit — the module batches large lists automatically (100 items
per request) and reports success or failure. Prefer the CLI? The same operations
are available as Drush commands (`drush cloudflare:purge-all`,
`cloudflare:purge-url`, `purge-tags`, `purge-prefixes`, `purge-hostnames`, and
`cloudflare:status` to check your setup). For hands-off operation, enable
automatic purging in [Configuration](configuration/index.md) so Drupal clears the
matching edge cache the moment your content changes.
