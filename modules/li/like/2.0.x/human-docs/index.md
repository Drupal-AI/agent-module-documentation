# Like — manual setup guide

**Like** (`like`) adds a **like button** to content entities, records who liked
what, and displays a running count. It is the smallest, lowest‑effort unit of
engagement a site can offer: a reader who would never write a comment will still
press a button, and the aggregate tells your editorial team which content actually
resonated in a way page views cannot — a view records arrival, a like records
approval. Both registered and anonymous visitors can like content.

By design, Like is a **like‑only** module — its maintainers have stated it will
not add a "dislike" feature. If you need up/down voting, look at
[Like and Dislike](../../../like_and_dislike/2.0.x/human-docs/index.md) instead.

There are three decisions worth making deliberately before you turn it on:

- **Anonymous liking is hard to trust.** Without an account, the only identity
  available is a cookie or an IP address, so an anonymous count can be inflated by
  a script. Requiring authentication makes the number mean something (and usually
  reduces it). To harden anonymous liking, the module integrates automatically
  with [Antibot](https://www.drupal.org/project/antibot) if you install it.
- **A like is personal data about an opinion.** An aggregate count is one kind of
  disclosure; a *list of who liked* is another, and may be sensitive depending on
  what is being liked. Decide who can see what.
- **Counts interact with caching.** A per‑entity number that changes constantly
  can't simply sit inside a page cached for everyone. Like uses a small GET
  endpoint so the displayed count stays reasonably accurate.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which entity types can be
   liked, then place and label the Like element on your displays.

## Where it lives in the admin menu

The module's settings form — where you enable Like for specific entity types —
lives at **Configuration → User interface → Like**
(`/admin/config/user-interface/like`). The actual placement and labels of the Like
element are set per bundle under **Manage display**.
