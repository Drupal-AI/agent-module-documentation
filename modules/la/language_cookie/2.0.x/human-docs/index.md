# Language Cookie — manual setup guide

**Language Cookie** (`language_cookie`) adds a **Cookie** language detection method
to a multilingual Drupal site. It remembers the language a visitor is using in a
cookie and reuses it on their next request — so an anonymous visitor who once
landed on the French version keeps getting French, even on URLs that carry no
language prefix. This is especially useful alongside a Language Selection Page or a
URL-prefix setup.

Like all detection methods, Cookie takes its place in Drupal's ordered list of
language negotiation methods. When a request arrives, it reads the cookie and — if
the value matches an enabled site language — uses it. When Drupal builds a response,
a subscriber writes (or refreshes) the cookie based on the language chosen by the
higher-priority detection methods, so the cookie always reflects the visitor's
current language.

You control the cookie's name, lifetime, path, domain, and its secure / HttpOnly
flags. A "set on every page load" option helps the module cooperate with reverse
caches like Varnish. Whether the cookie is written on a given request is decided by
a set of **condition plugins** — shipped conditions skip blacklisted paths, AJAX
requests, command-line/cron runs, and more — and developers can add their own
conditions or alter the outgoing cookie via hooks.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable and order the Cookie method,
   then tune the cookie settings field by field.

## Where it lives in the admin menu

Language Cookie plugs into core's language detection UI at **Configuration →
Regional and language → Languages → Detection and selection**
(`/admin/config/regional/language/detection`), where you enable and order the
**Cookie** method. Its own cookie settings form lives one click deeper at
`/admin/config/regional/language/detection/language_cookie`. Both are gated by the
core **Administer languages** permission.
