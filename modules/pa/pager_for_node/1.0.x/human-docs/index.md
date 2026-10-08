# Pager For Node — manual setup guide

**Pager For Node** (`pager_for_node`) adds **previous / next (and first / last)**
navigation to your nodes, so visitors can browse straight from one piece of content to the
next without going back to a listing. It works **per content type**: you switch the pager
on for a given type (articles, blog posts, and so on), and each type gets its own,
independent pager.

As a nice touch for SEO and browsers, it can also add **semantic previous/next links to
the document `<head>`** (the `rel="prev"` / `rel="next"` hints that tell browsers and
crawlers how a series of pages is ordered), alongside the on‑page navigation links.

It is a content‑display / navigation feature. The navigation follows normal node access,
and the module has no access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.

Pager For Node has **no central configuration page** (its configure route is empty).
Instead, you turn the pager on **per content type**, on the content type's own edit form,
so that setup is described here rather than in a separate Configuration section.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Content types** (`/admin/structure/types`) and click **Edit** on
   the content type you want to add a pager to.
3. Open the **Pager for node settings** tab on that form.
4. Tick **Build a pager for this content type**.
5. Optionally tick **Add semantic previous and next links to the document HEAD** to emit
   the `rel="prev"`/`rel="next"` hints.
6. Enter the **label for the previous link** and the **label for the next link**.
7. Click **Save**.

Repeat for any other content types that should have their own pager. View a node of that
type to confirm the previous/next navigation appears.
