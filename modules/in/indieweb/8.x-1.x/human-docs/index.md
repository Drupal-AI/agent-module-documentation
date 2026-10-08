# IndieWeb — manual setup guide

**IndieWeb** (`indieweb`) brings the building blocks of the
[IndieWeb](https://indieweb.org/) movement to Drupal, so your site can be your
own home on the social web — owning your content, publishing it under your own
domain, and interoperating with other sites and the fediverse. Rather than one
monolithic feature, it is a **suite of submodules** you switch on as needed, each
covering one open standard.

The main module is an API layer that provides shared services, permissions, and
an admin **dashboard** from which you reach every part of the system. On top of it
you enable the pieces you want:

- **IndieAuth** — turns your site into an identity/authentication authority (or
  lets it use an external one), issuing and validating tokens with PKCE.
- **Micropub** — a token-authenticated endpoint that lets external apps create
  posts (notes, articles, replies, likes, reposts, bookmarks, RSVPs, and more)
  on your site.
- **Webmention** — sends and receives cross-site mentions and pingbacks, either
  via the internal endpoint or through Webmention.io, and can turn incoming
  replies into comments.
- **Microsub, WebSub, Microformats, Feeds, Contacts, Post context, Media cache**
  — a reader/subscription hub, real-time feed push, Microformats2 markup, Atom/
  JF2 feeds, a contact store, and image caching.

Because several of these endpoints are, by design, reachable from the public
internet, security matters. The Micropub endpoint validates the IndieAuth bearer
token and its scope on every request before creating anything, and the Webmention
endpoint accepts input from other sites — so serve everything over **HTTPS**, keep
your IndieAuth configuration tight, and treat received webmentions as untrusted
content to be moderated. Note that the `8.x-1.x` branch documented here is for a
**single-user site**; multi-user support lives on the `8.x-2.x` branch.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its PHP library
   dependencies with Composer, then enable the submodules you need.
2. [Configuration](configuration/index.md) — the dashboard and how each submodule
   is configured, with an emphasis on the auth and endpoint model.

## Where it lives in the admin menu

Everything is reached from the **IndieWeb dashboard** (its
`indieweb.admin.dashboard` route), found under **Configuration → Web services →
IndieWeb**. Each enabled submodule adds its own settings section there.
