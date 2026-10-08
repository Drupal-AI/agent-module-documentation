# Shorten URLs — manual setup guide

**Shorten URLs** (`shorten`) turns long URLs into short ones using external
shortening services — is.gd, TinyURL, Bit.ly, and roughly two dozen others. It's a
front-end and API around those services: it does **not** mint its own short codes or
run its own redirects. When you shorten a URL, the module makes a server-side request
to the chosen service (for example `https://is.gd/…?url=<your-url>`) and hands back
the short URL that service returns.

You can use it in several ways:

- **A shortening page** at `/shorten` where a user pastes a URL and gets a short one
  back via AJAX (optionally choosing which service to use).
- **Two blocks** — a "Shorten URLs" block (the shortening form) and a "Short URL"
  block that shows the short URL for the current page.
- **A token**, `[url:shorten]`, that resolves to a shortened URL in text and
  templates.
- **A developer API**, `shorten_url($long)`, to shorten from your own code.

It's built for resilience and speed: you pick a **primary** service and a **backup**
that's used automatically if the primary is down (and if both fail, it returns the
original URL unchanged). Results are **cached** so you don't hit the service's API
repeatedly, failures are cached briefly so a down service doesn't get hammered, and a
configurable request **timeout** keeps a slow service from blocking your page.
Services that need credentials (like Bit.ly) have their API keys entered on a
dedicated Keys form, and only appear as options once their keys are set.

Three optional submodules extend it: **Record Shorten** (`record_shorten`, logs
shortened URLs and provides a report / Views data), **Shorten Custom Services**
(`shorten_cs`, add your own services through the UI), and **Shortener** (`shortener`,
an input filter that shortens links in text automatically).

It has no dependencies and runs on Drupal 9, 10, 11, or 12.

This guide is written for a **human** setting the module up through the UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — they cover the `shorten_url()` API, the
service/token internals, and the extension hooks in depth.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and pick the submodules you need.
2. [Configuration](configuration/index.md) — the general settings form, the API Keys
   form, permissions, and the blocks.

## Where it lives in the admin menu

- **General settings:** *Configuration → Web services → Shorten URLs*
  (`/admin/config/services/shorten`) — uses the core *Administer site configuration*
  permission.
- **API keys:** *Configuration → Web services → Shorten URLs → Keys*
  (`/admin/config/services/shorten/keys`) — uses the *Manage Shorten URLs API keys*
  permission.
- **The shortening page** for end users is at `/shorten`, gated by the *Use Shorten
  URLs page* permission.

## How to use it

Choose a primary (and optionally a backup) service on the settings form, enter API
keys for any services that need them, then let users shorten URLs via the `/shorten`
page, the blocks, the `[url:shorten]` token, or your own code. The full walkthrough
is on the [Configuration](configuration/index.md) page.
