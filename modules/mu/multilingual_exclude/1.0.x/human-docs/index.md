# Multilingual exclude — manual setup guide

**Multilingual exclude** (`multilingual_exclude`) lets you keep certain pages and
routes **out of your site's translation handling**. On a multilingual site, some
pages really only make sense in one language — the Layout Builder editing screen, an
admin utility page, or an API path, for example. This module lets you list those
routes so they are not treated as translatable or language‑prefixed, and lets you
pick which theme they render with.

The problem it solves is a familiar multilingual annoyance: admin and utility pages
picking up the "wrong" language, or being needlessly drawn into the language‑prefix
URL scheme. With Multilingual exclude you simply add the routes you want to keep in
the default language and, from then on, whatever language you have admin pages set
to, the excluded routes stay in that language.

It is a routing/multilingual convenience: it changes which routes participate in
translation and language negotiation. It does **not** change your content or your
access rules, and it has no access‑control role. It provides its own permission for
managing the exclusion list, and everything is set up on one simple settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the routes to exclude and choose
   the theme they render with.

## Where it lives in the admin menu

The settings form is at route `multilingual_exclude.settings`, under
**Configuration** (reachable via the module's *Configure* link on the Extend page).
Managing the list requires the permission the module provides.
