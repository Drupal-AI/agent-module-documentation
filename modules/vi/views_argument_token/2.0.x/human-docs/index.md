# Views Argument Token — manual setup guide

**Views Argument Token** (`views_argument_token`) lets a view's contextual filter
fill itself in automatically from a Drupal **token**. Normally a contextual filter
(argument) gets its value from the URL, or from one of Views' built‑in "provide
default value" plugins. This module adds one more option to that list — **Token** —
so instead of writing custom code you can just type something like
`[node:field_tags]` or `[current-user:uid]` and the argument resolves from the
current page context at render time.

That small addition unlocks a lot of common "related content" patterns with zero
custom code. On an article page you can default a term‑reference contextual filter
to `[node:field_tags]` to show "related by tag" listings; you can build a "my
content" view whose author filter defaults to `[current-user:uid]`; or you can
drive a related‑products block from the current product's brand field. Because the
argument is derived from the page rather than hard‑coded, the same view can be
reused in many contexts, and the value never has to appear in the URL.

The token is resolved intelligently against the page: `current-user` tokens use the
logged‑in account, and entity tokens (`node`, `taxonomy_term`, `user`, media, …)
use whatever entity the current route is about — the node on `node/5`, the term on
`taxonomy/term/3`, and so on. A **Get fields raw values** option swaps a field's
rendered output for its stored raw value (for example, an entity‑reference field's
target ID instead of the referenced title), and multi‑value fields can be joined
with `+` (OR) or `,` (AND) to feed a multi‑value contextual filter. There's also
an option to fall back to `all` when the token resolves empty, and a debug toggle
that prints the computed value while you build the view.

The module depends on core **Views** and the contrib **Token** module (Token
powers the "browse available tokens" helper). It has no settings page of its own —
everything is configured per view, right on the contextual filter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There's no dedicated settings page. The feature appears inside the **Views UI**
(**Structure → Views**, `/admin/structure/views`) whenever you edit a view's
contextual filter and choose to provide a default value.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Edit a view and open **Advanced → Contextual filters**; add or edit an argument.
3. Under **When the filter value is NOT available**, choose **Provide default
   value**.
4. Set **Type** to **Token**.
5. In the **Token** field, enter your token — for example `[node:field_category]`
   to match the current node's category, or `[current-user:uid]` for the logged‑in
   user. Use the **Browse available tokens** link to look up what's available.
6. If you're matching a multi‑value contextual filter, enable **Allow multiple
   values** on the filter, and when the source is a field, tick **Get fields raw
   values** so you get IDs rather than rendered titles. Choose whether multiple
   values join with `+` (OR) or `,` (AND).
7. Optionally leave **send `all` when empty** on (so an empty token shows
   everything rather than nothing — this needs the filter's "all" exception
   enabled), and turn on **debug** while building to see the resolved value.

Save the view. The setting is stored as part of the view's configuration, so it
exports and deploys with the view like any other Views setting.

> **A note on caching:** the resolved argument is cached permanently without cache
> contexts, so this plugin is best for values that are stable within the rendered
> view's cache. Keep that in mind when the token depends on the current user.
