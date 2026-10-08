# Node by Term — manual setup guide

**Node by Term** (`node_by_term`) is an admin tool that lists your site's content
and lets you **filter it by vocabulary, taxonomy term, and content type**. Pick a
vocabulary and its terms load automatically; choose a term and/or a content type,
submit, and you get a paged results table showing each node's title, content type,
published status, created and changed dates, and Edit/View links.

It's useful when you have a lot of tagged content and need to answer questions like
"which articles are tagged with this term?", "what content is in this vocabulary?",
or "show me everything of this content type" — quickly, from one screen, without
building a View. The listing includes unpublished nodes as well as published ones,
so treat it as an administrative page. It depends on core's **Node** and
**Taxonomy** modules.

There is no settings form to fill in — the module's page *is* the tool. You enable
the module and go straight to the listing.

> **Access note.** Both of the module's pages are gated by an *administer node by
> term* permission that the module does not actually declare on the Permissions
> screen. In practice that means only **user 1** can reach the pages out of the box.
> If you need other roles to use it, you would first have to add a matching
> permission; until then, don't expect the *Permissions* page to expose a grant for
> it. Because the listing shows unpublished content, keep it restricted to trusted
> administrators anyway.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Node/Taxonomy dependencies.

There is **no configuration page** — nothing is stored as settings. Use the tool as
described in "How to use it" below.

## Where it lives in the admin menu

After enabling, the main listing is at **`/node-list`** (route
`node_by_term.nodelist`), which is also linked as the module's *Configure* action on
the Extend/modules page. A standalone filter form is available at
**`/node-by-term-form`**.

## How to use it

1. Go to **`/node-list`** (or click *Configure* next to Node by Term on the Extend
   page). Right after installation the module shows a "Go to nodelist" message that
   links you there.
2. Choose a **Vocabulary**. Its terms load into the **Term** select automatically.
3. Optionally pick a **Term** and a **Content type** to narrow the results.
4. Submit. You're taken to the results table (paged, a couple of rows per page). The
   filters travel in the URL as `vocab`, `t_id`, and `cont_type` query parameters,
   so you can bookmark or share a filtered view.
5. Use each row's **Edit** and **View** links to jump straight to a node, and the
   form's reset option to return to the full list.
