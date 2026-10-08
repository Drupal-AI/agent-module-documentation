# Flippy — manual setup guide

**Flippy** (`flippy`) adds Previous / Next navigation — and optionally First,
Last, and Random links — to node pages, so visitors can flip through all the
published nodes of a content type one at a time. Think "browse the next article"
on a blog, a walk-through of a photo gallery, or paging through chapters of a
manual.

Flippy is configured **per content type**. On a content type's edit form you get a
"Flippy settings" section where you turn the pager on and choose its options; the
settings are stored per type so each content type gets its own independent pager.
Once enabled for a type, Flippy exposes a `Flippy pager` pseudo-field on that
type's *Manage display* page, so you can position the pager among the node's
fields — or you can place the **Flippy Block** in any region instead.

The links are worked out at view time by querying the other published nodes of the
same type. By default they are ordered by post date (oldest first), but you can
sort by any base field or configured field in ascending or descending order. Link
labels support tokens (so a "Next" link can show the target node's title), can be
truncated with an ellipsis, and can optionally emit `rel="prev"`/`rel="next"`
`<link>` tags in the page head for SEO. With the optional HammerJS integration you
also get keyboard-arrow and touch-swipe navigation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the pager service,
the query-alter event, and theming — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — turn Flippy on for a content type,
   set the labels and sorting, and place the pager.

## Where it lives in the admin menu

Flippy has **no central settings page** (`configure: null`). You configure it on
each content type's edit form — **Structure → Content types → (your type) → Edit**
(`/admin/structure/types/manage/<type>`) — in the collapsible **Flippy settings**
group. The pager is positioned on that type's **Manage display** page, and the
**Flippy Block** is placed from **Structure → Block layout**.
