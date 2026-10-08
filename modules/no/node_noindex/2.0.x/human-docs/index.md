# Node Noindex — manual setup guide

**Node Noindex** (`node_noindex`) adds a per‑node checkbox that emits a
`noindex` robots meta tag in the page's HTML head, telling well‑behaved search
engines not to list that page in their results. It is a deliberately lightweight,
focused alternative to a full metatag framework: when you just need to keep a
handful of pages out of search — a thank‑you page reached after a form, a
one‑campaign landing page, a deliberate duplicate, a client review page — this does
exactly that and nothing more. Checking the box also removes the canonical link
that core adds for the node.

**Two distinctions are worth being clear about, because they are constantly
confused:**

- **`noindex` is not access control.** A `noindex` page is still *fully readable*
  by anyone who has the URL — it only asks compliant search engines not to list it.
  Anything that must not be *read* needs proper **permissions**, not this module.
- **`noindex` is not `robots.txt`, and combining them backfires.** `robots.txt`
  asks a crawler not to *fetch* a page — but a page it never fetches can never be
  seen to carry the `noindex` tag, so a page blocked both ways can still appear in
  results as a bare URL. Use one mechanism or the other, deliberately.

Two more practical notes: removing a page that is *already* indexed takes time and
is best pushed through the search engine's own removal tools; and a `noindex` page
should be kept out of your internal linking strategy. The setting is gated by a
**mark content as not indexable** permission, so it is a deliberate editorial grant
rather than something every editor toggles casually. The module has no
dependencies beyond core and exposes a "No index" field to **Views**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no central settings page — you enable the feature per content type and
then flag individual nodes, as described in "How to use it" below.

## How to use it

1. Grant the **mark content as not indexable** permission to the roles that should
   be able to flag pages, at **People → Permissions** (`/admin/people/permissions`).
2. Enable the noindex option for the content type(s) where you want it available.
3. Edit an individual node of that type. In the vertical tabs you will find a
   **Search engine settings** tab with a **Set noindex in HTML head** checkbox.
4. Tick the box and save the node. Its HTML head now carries the `noindex` robots
   directive (and the core canonical link is removed). Untick and save to reverse
   it.
