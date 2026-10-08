# LocalGov Guides — manual setup guide

**LocalGov Guides** (`localgov_guides`) lets you publish multi-page guides — the
kind of "how to" or step-by-step content that is too long for one page but should
read as a single journey. A guide is made of two content types that work together:
a **guide overview** (`localgov_guides_overview`), which is the landing page and
holds the ordered list of pages, and one or more **guide pages**
(`localgov_guides_page`), each pointing back at their overview. It ships a **contents
block** (a table of contents) and a **previous/next block** so visitors can move
through the guide.

The module's cleverest trick is that it keeps both sides in sync automatically. Add
a page and set its parent, and it appears in the overview's list on its own; edit the
overview's list, and the pages' parent references update to match. Editors can start
from either end and the guide never drifts out of order. It is part of the LocalGov
Drupal distribution and depends on `localgov_core` plus core **Block**, **Node**, and
**Text**.

There is **no settings page to configure** — the module works by giving you the two
content types and the two blocks the moment you enable it. "Setting it up" means
creating an overview, adding pages, and placing the blocks. When
`localgov_services_navigation` or `localgov_topics` are also installed, guides can
sit in the LocalGov services tree or be classified by topic; those integration fields
are imported automatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and rebuild caches.

## Where it lives in the admin menu

There is no dedicated configuration form. You create guides from the normal content
tools: **Content → Add content → Guide overview** and **Guide page**. The two
navigation blocks are placed at **Structure → Block layout**
(`/admin/structure/block`).

## How to use it

1. **Create a guide overview** (`Guide overview` content type) — this is the guide's
   landing page and the title everyone lands on.
2. **Add guide pages** (`Guide page` content type), setting each page's *parent* to
   that overview. As soon as you save a page, it is appended to the overview's page
   list automatically — you never have to maintain both sides by hand.
3. **Reorder pages** from the overview's edit form: the running order lives in the
   overview's page list, so drag the rows there rather than editing each page.
4. **Place the navigation blocks** at **Structure → Block layout** — the *Guide
   contents* block (table of contents) and the *Guides prev next block*
   (previous/next links), typically restricted to the two guide content types. On the
   LocalGov Base theme these are placed for you; on a custom theme you place them
   yourself.
5. **Preview** an overview and its preview link covers the whole guide, including
   unpublished pages — handy for sharing a draft guide with a reviewer.

> **A note for moderated sites.** When someone saves an overview, the module
> re-checks which pages point at it *as that user*. If a page is unpublished and the
> person saving cannot view unpublished content, that page is treated as "not a
> child" and dropped from the list. Give guide editors permission to view unpublished
> content (or `bypass node access`) to avoid the list churning on moderated
> workflows.

## Optional integrations

If you also run `localgov_services_navigation` or `localgov_topics`, enabling them
imports the extra fields so guides can live in the services tree or be classified by
topic. If those modules were turned on during a config sync (so the automatic import
was skipped), import the optional field storage config manually — see the sibling
[`agent/`](../agent/start.md) docs for the exact command.
