# Intersection Observer (io) — manual setup guide

**Intersection Observer** (`io`) brings the browser's
[Intersection Observer API](https://developer.mozilla.org/docs/Web/API/Intersection_Observer_API)
into Drupal so blocks and Views can **lazy‑load their contents once they scroll
into view**. Instead of loading everything up front, a block or a View's next
page of results is fetched over AJAX only when the visitor actually reaches it —
which keeps initial page loads light. For older browsers that lack the native
API, it degrades gracefully to the bLazy library, so behavior stays consistent.

Two headline features come out of this: **IO block lazy‑loading** (an AJAX block
loads when it becomes visible) and an **IO Views infinite pager** (the next page
of a View loads automatically as the visitor scrolls, no "next page" click). An
optional **IO Browser** submodule (`io_browser`) adds an infinite‑pager
integration for Entity Browser.

This is a front‑end mechanism with no security surface of its own — it provides
the plumbing, and the content that loads on visibility is whatever your blocks
and Views already render. Note that its settings piggyback on the **Blazy**
module's configuration rather than living on a page of their own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer along
   with its Views and Blazy dependencies, then enable it.

There is **no dedicated settings page** for this module. Its handful of options
live inside the Blazy settings form, and the real setup happens per‑block and
per‑View, described in "How to use it" below.

## Where it lives in the admin menu

Intersection Observer adds no admin page of its own. Its options sit under
**Configuration → Media → Blazy** (`/admin/config/media/blazy`, in the *Extra
Settings* section), and you switch it on for individual blocks and Views from
**Structure → Block layout** and **Structure → Views** respectively.

## How to use it

**Turn the feature on (optional Blazy settings).** Visit
`/admin/config/media/blazy`, expand **Extra Settings**, and fill out the fallback
text shown for blocks under *IO fallback*. If you only want the Views infinite
pager and not lazy‑loaded blocks, tick **Disable IO block** here — the block
option below then disappears.

**Use it as a block observer** (only when *Disable IO block* is unchecked):

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Edit the block you want to lazy‑load.
3. Check **Lazyload using Intersection Observer** and save.

**Use it as a Views observer (infinite pager):**

1. Go to **Structure → Views** (`/admin/structure/views`) and edit a view.
2. Under **Advanced → Other**, enable the **Use AJAX** option.
3. Under **Pager**, choose **Intersection Observer**.

> **Good to know:** IO works with `block.html.twig` templates that print the
> `{{ content }}` variable directly (as core blocks do) — the AJAX trigger lives
> in that markup. If a block's option to lazy‑load doesn't appear, the module has
> deliberately excluded that block (for example page titles or crucial content)
> to avoid lazy‑loading things that shouldn't be deferred.
