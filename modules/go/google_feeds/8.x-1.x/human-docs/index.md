# Google custom RSS feeds — manual setup guide

**Google custom RSS feeds** (`google_feeds`) adds **Views** style and row plugins
that produce the specific RSS dialects Google expects — a **Google News** feed and a
**Google Shopping (Merchant Center)** product feed. Neither of these is ordinary
RSS: Google News wants publication metadata, publication dates and access flags in
its own namespace, while Merchant Center wants product identifiers, prices,
availability and image links in the `g:` namespace with strict rules about what may
be omitted. Core's RSS style produces neither, so people usually end up hand‑building
a Twig template that breaks the next time the spec changes.

Doing it as **Views plugins** is the right shape. Because a feed is just a View,
your filters decide which content is included, your sorts decide the order,
contextual filters can produce a feed per category, and access and caching all behave
normally. Two field formatters ship alongside for the fields these feeds are fussy
about: an **absolute image URL** formatter (feeds need absolute URLs — a relative one
is silently rejected) and a **Google Shopping term** formatter for mapping taxonomy
terms onto Google's product categories.

This module has **no configuration page and no settings form** — you build feeds
entirely in the Views UI. It depends on core **Options**, **Node** and **Views**.

> **Keep an eye on validity.** Both target specifications are maintained by Google
> and change independently of Drupal's release cycle. The real test of a feed is the
> item‑level rejection report in Merchant Center / News, not the module version.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Views dependency.

There is **no configuration page** for this module. All setup happens in the Views
UI, described in "How to use it" below.

## Where it lives in the admin menu

Google custom RSS feeds adds no admin page of its own. You use it entirely from
**Structure → Views** (`/admin/structure/views`) when you create or edit a View.

## How to use it

1. Create a new **View** of the content you want to syndicate (for example, articles).
2. For the display, choose a **feed / page** display and set its **Format** to
   **Google News feed** or **Google Shopping feed**, with the matching **row** style.
3. Use the View's **filters** to include only the right content (for example, only
   published, promoted items), **sorts** to order items (news feeds typically sort by
   publication date), and a **pager** to limit feed length. **Contextual filters**
   let one View emit a feed per category.
4. For image and product fields, use the module's **absolute image URL** formatter so
   URLs are absolute, and the **Google Shopping term** formatter to map taxonomy
   terms to Google product categories.
5. Save the View, then **validate the output** against Merchant Center / Google News
   and watch their item‑level rejection reports — that is the definitive check.
