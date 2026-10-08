# Node Token Filter — manual setup guide

**Node Token Filter** (`node_token_filter`) is a small **text‑format filter** that
lets `[node:…]` tokens (and `[group:…]` tokens) in your content resolve against the
entity of the **current URL**. Normally a token in a reusable piece of content — a
block, for instance — has no "current node" to resolve against, so `[node:title]` and
friends come back empty. This filter checks whether the current route is a node (or a
group) page and, if so, hands that entity to Drupal's token system, so the tokens
render against the page the visitor is actually viewing.

That makes it easy to build shared or block content that references "the current
node" dynamically — a byline, a title echo, a field value — without hard‑coding
anything. It depends on core's **Filter** and the contributed **Token** module. It was
written as a workaround for a core limitation around token context in content blocks.

A note on where to place it: the filter resolves tokens against the entity in the
current URL — the page the viewer is already on and can access — and uses Drupal's
standard token replacement, which sanitizes token values, so it does not reach
arbitrary entities. As with any token‑rendering filter, enable it only on **trusted
text formats** whose content is controlled by editors, not on formats open to
untrusted input. It has no access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it and its Token dependency.

There is **no dedicated settings page** — you turn the filter on within a text
format's own configuration, described below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a **trusted** text format used by
   editors (for example *Full HTML*).
3. Under **Enabled filters**, tick the Node Token Filter filter.
4. Save the text format.
5. In content using that format, write tokens such as `[node:title]` (or
   `[group:name]`). On a node or group page, they now resolve against the current
   entity.
