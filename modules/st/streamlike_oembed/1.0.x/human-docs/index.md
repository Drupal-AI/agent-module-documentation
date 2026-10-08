# Streamlike oEmbed — manual setup guide

**Streamlike oEmbed** (`streamlike_oembed`) adds oEmbed support for
[Streamlike](https://www.streamlike.com) videos to your entity pages. On an
entity's canonical page (a node page, a taxonomy term page, and so on) it works out
which Streamlike media ID applies — by reading a field you have mapped for that
route — and prints the oEmbed discovery tags that point at the Streamlike endpoint,
so the Streamlike player can be embedded and discovered via oEmbed. Streamlike is a
SaaS platform for live and on-demand streaming.

The heart of the module is a small settings form where you list **route-to-field
mappings**: for each route you care about (for example a node's canonical route),
you name the field that holds the Streamlike media ID. At render time the module
checks whether the current route is one of your mapped canonical routes, loads the
page's main entity, and reads the media ID from the mapped field. It understands
the `vpx_media_field` field type specially and otherwise falls back to a field's
plain value, and it validates that a media ID looks right (a 16-character string).
It pairs naturally with the **Streamlike Media** module, whose field can be the
source of the media ID.

The only route the module adds is the permission-gated admin settings form;
discovery itself is read-only against the current entity, with no anonymous or
mutating endpoints. It depends only on Drupal core and supports Drupal 9 and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — map the routes and fields the module
   should read media IDs from.

## Where it lives in the admin menu

The settings form sits at **Configuration → Media → Streamlike oEmbed**
(`/admin/config/media/streamlike-oembed`), behind the **Administer streamlike_oembed
configuration** permission.
