# Home Redirect Language — manual setup guide

**Home Redirect Language** (`home_redirect_lang`) sends visitors who land on your
homepage to the version of it in their preferred language. On a multilingual site,
a returning visitor who has previously chosen to browse in, say, French will be
redirected from `/` to the French front page automatically — offering them their
native content by default.

How it knows the preference: when a visitor changes the language of any page, the
module stores their choice in a cookie
(`home_redirect_lang_preferred_langcode`) via JavaScript. On a later visit to the
homepage, that cookie triggers the redirect if they arrive in a different
language. Visitors can still switch languages freely — the redirect only fires on
the **homepage**, never on any other page. A first‑ever visit can't be handled by
a cookie that doesn't exist yet, so there's an optional **fallback** that uses the
visitor's browser‑preferred language instead (see
[Configuration](configuration/index.md)).

The module has no dependencies beyond Drupal core, runs on Drupal 10.5 and 11, and
provides its own permission. It's sponsored by
[Antistatique](https://www.antistatique.net/).

> **Important caching note:** for anonymous users this module requires the core
> **Internal Page Cache** (`page_cache`) module to be **disabled**, because that
> cache assumes every anonymous visitor gets an identical page regardless of cache
> contexts. See [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the first‑visit fallback option, the
   language switcher, and the required caching change.

## Where it lives in the admin menu

The module attaches its cookie‑setting JavaScript to Drupal's core **Language
Switcher** automatically, so basic behaviour needs no admin page. Its options (the
first‑visit fallback) live on the module's settings form — see
[Configuration](configuration/index.md).
