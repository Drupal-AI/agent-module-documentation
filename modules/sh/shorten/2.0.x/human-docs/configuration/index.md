# Configuration

Shorten URLs has two admin forms — a **general settings** form and an **API Keys**
form — plus a couple of blocks. This page walks through each.

## General settings

Open **Configuration → Web services → Shorten URLs**
(`/admin/config/services/shorten`) as a user with the **Administer site
configuration** permission. The settings, stored in the `shorten.settings` config
object, are:

- **Fetch method** (`shorten_method`) — how the module makes its outbound request:
  **PHP** (Guzzle) or **cURL**. It auto-selects whichever is available (cURL is
  preferred). Leave it on the default unless you have a reason to change it.
- **Service** (`shorten_service`) — your **primary** shortening service (for example
  `is.gd`, `TinyURL`, or `bit.ly`). This is used whenever a shortening request
  doesn't specify a service.
- **Backup service** (`shorten_service_backup`) — used automatically when the primary
  fails. It must be different from the primary (and note that `j.mp` and `bit.ly`
  count as the same service). If both the primary and backup fail, the original URL
  is returned unchanged.
- **Show service selector** (`shorten_show_service`) — when on, the page and blocks
  let users pick which service to use per shortening.
- **Hidden services** (`shorten_invisible_services`) — services to hide from that
  selector.
- **Use alias** (`shorten_use_alias`) — prefer the path-alias form of a URL when
  shortening.
- **Use www.** (`shorten_www`) — replace `http://`/`https://` with `www.` in the
  output where that's shorter.
- **Timeout** (`shorten_timeout`) — how long, in seconds, to wait for the service
  before giving up (default **3**). Keeps a slow service from blocking your page.
- **Cache duration** (`shorten_cache_duration`) — how long to cache successful
  results so repeat requests don't call the API again (default **1814400** seconds =
  3 weeks; leave blank for permanent caching).
- **Failure cache duration** (`shorten_cache_fail_duration`) — how long to cache a
  failure so a down service isn't hammered (default **1800** seconds = 30 minutes).
- **Clear cache on full cache clear** (`shorten_cache_clear_all`) — whether a
  site-wide cache clear also drops the shorten cache.

You can also set these from the command line, for example:

```bash
drush config:set shorten.settings shorten_service is.gd -y
drush config:set shorten.settings shorten_service_backup TinyURL -y
drush config:set shorten.settings shorten_timeout 3 -y
```

The always-available services (no key needed) include **is.gd**, **migre.me**,
**Metamark**, **PeekURL**, **qr.cx**, **ri.ms**, and **TinyURL**. Others require API
keys (below).

## API Keys form

Open **Configuration → Web services → Shorten URLs → Keys**
(`/admin/config/services/shorten/keys`) as a user with the **Manage Shorten URLs API
keys** permission. Here you enter credentials for the services that need them —
including **Bit.ly** (login + key), **BudURL**, **Cli.gs**, **Ez**, **Fwd4.me**,
**Goo.gl**, and **Redirec**. A credentialed service only appears as an option in the
selector once its key(s) are filled in.

Because these are secrets, treat the Keys form with care and grant the *Manage
Shorten URLs API keys* permission only to trusted administrators. (If your workflow
keeps secrets in environment variables rather than in the site's exported
configuration, coordinate that with how you deploy this config object so keys don't
end up committed.)

## Permissions

The module defines two permissions:

- **Use Shorten URLs page** — allows access to the `/shorten` page (and the block
  form).
- **Manage Shorten URLs API keys** — allows viewing/editing the third-party API keys
  on the Keys form.

The general settings form uses core's **Administer site configuration** permission.

## Blocks

Two blocks are available at *Structure → Block layout*:

- **Shorten URLs** (`shorten`) — embeds the shortening form, so visitors can paste any
  URL and get a short one.
- **Short URL** (`shorten_short`) — shows the short URL for the page it's placed on.
  Note that this block calls out to the shortening service when the page is built, so
  **place it carefully**: on uncached pages it triggers an outbound request each time.

## Tokens

The module provides a `[url:shorten]` token that resolves to a shortened version of
the current URL using your default service — handy in text and templates. (The older
`[node:short-url]` token is deprecated; prefer `[node:url:shorten]` or
`[node:url:unaliased:shorten]`.)

## How shortening works (and a safety note)

Shortening is delegated entirely to the external service: the module performs a
server-side GET to a **fixed** service host with your URL as a query parameter, and
returns whatever short URL that service replies with (validated to start with
`http://` or `https://`). The module has no local redirect route and creates no local
short codes, so there is no open-redirect surface in the main module. Just be aware
that every shortening is an outbound request to a third party, which is why the
caching and timeout settings above matter.

## Extending it

Developers can register additional services with `hook_shorten_service()` and react to
each shortening with `hook_shorten_create()` (which is how the **Record Shorten**
submodule logs shortenings). Both hooks, plus the `shorten_url()` API, are documented
in the [`agent/`](../../agent/start.md) docs.
