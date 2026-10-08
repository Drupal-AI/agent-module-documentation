# Buster — manual setup guide

**Buster** (`buster`) is a cache buster for public file URLs. When you replace a
file that keeps the same name — a logo, a stylesheet, a downloadable document —
browsers and CDNs will often keep serving the old, cached copy because the URL
did not change. Buster fixes that by appending a changing version token to public
file links, so a URL that points at updated content looks different and the
current file is fetched instead of a stale one.

It works quietly in the background: enable it and it affects how public file URLs
are generated. There is nothing you must fill in, no content it stores, and no
access-control role. It supports Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
a terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Buster has no configuration page. Once enabled it works automatically — public
file URLs simply gain a version token that changes when the underlying file
changes.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. That's it — public file links now carry a cache-busting token. When you update
   a public file, its URL changes so browsers and CDNs fetch the new version
   rather than serving a stale cached copy.
