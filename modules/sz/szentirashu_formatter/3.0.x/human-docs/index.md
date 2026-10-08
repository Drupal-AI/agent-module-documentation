# szentiras.eu Reference Formatter — manual setup guide

**szentiras.eu Reference Formatter** (`szentirashu_formatter`) is a field formatter
that turns plain Bible reference strings — something like "Jn 3,16" — into the actual
scripture passage, fetched on demand from the szentiras.eu web API. It is aimed
mainly at Hungarian Drupal sites, since szentiras.eu provides Hungarian Bible
translations. You store a reference in an ordinary text field, and this formatter
renders it as readable scripture.

The module supports three display behaviours: a **simple link** to szentiras.eu; a
**load-on-click** mode that fetches the referenced passage from the API when the
reader clicks it; and an **auto-load** mode that fetches all referenced passages when
the page loads. Behind the click-to-load and auto-load behaviours is a small proxy
route (`/szentirashu/proxy/{ref}/{translation}`) that returns passage text as JSON so
the front end can lazy-load it. Both the formatter and the proxy go through a shared
service that calls the fixed szentiras.eu host over HTTPS, sends your configured API
key in an `X-API-Key` header, and caches results (passages cached permanently per
reference; the translation list for 24 hours). It depends on core's **Field** module,
provides its own permission for the settings form, and ships no submodules.

To use it you need an API key from szentiras.eu, which you enter on the settings form
at the `szentirashu_formatter.settings` route, along with a default translation — see
[Configuration](configuration/index.md). One thing to be aware of: the proxy route is
gated by the core **Access content** permission, which anonymous visitors have by
default, so it is effectively public. That is not an SSRF risk — the reference is only
URL-encoded into the fixed szentiras.eu host, there is no arbitrary URL fetching, and
TLS is left at Guzzle's secure defaults. The practical consideration is that anonymous
visitors can drive reference lookups to szentiras.eu using your site's API key, which
could consume your API quota; if that is ever abused, lean on the built-in caching and
consider adding rate limiting. Note the module is minimally maintained and not covered
by the security advisory policy.

This guide is written for a **human** setting the module up through the admin UI. If
you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter the API key and default
   translation, and add the formatter to a field.

## Where it lives in the admin menu

Once enabled, the settings form is at the `szentirashu_formatter.settings` route
(access controlled by the module's own *Administer szentirashu api* permission), where
you store the API key and default translation. You then apply the formatter to a
reference-holding text field through that entity's **Manage display** screen.
