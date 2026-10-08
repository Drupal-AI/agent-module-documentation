# Search API - revisions — manual setup guide

**Search API - revisions** (`search_api_revisions`) is a Search API *datasource*
that lets you build a search index over the **revisions** of your content
entities, rather than only their current published version. If your content is
revisionable — nodes, media, paragraphs and so on — this module makes every
historical revision indexable, so a search can turn up content as it existed in
a past state.

That is useful for auditing ("show me every version of this page that mentioned
the old product name") and for any workflow where the history of a piece of
content matters as much as its latest state. The datasource offers the same
options you already know from the standard content-entity datasource — you can
include or exclude particular languages and bundles when you set it up on the
index.

It works purely at the indexing layer and has no access-control role of its own.
It depends only on the **Search API** module and adds no settings page of its
own — you choose and configure it while building a Search API index.

**A word of caution about what you expose.** Historical revisions include
unpublished and draft states, and old content that has since been changed or
removed. If your index and its search display do not restrict results by access
and revision status, a search could surface content a visitor should never see —
for example the text of an old, never-published draft. When you index revisions,
be deliberate about *which* revisions you index and *who* is allowed to search
them, and lean on Search API's own access handling and your index configuration
to keep restricted material out of the wrong hands.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no separate configuration screen for this module. Once it is enabled,
its datasource becomes available when you create or edit a Search API index at
**Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`). On the index's setup form, choose the
**revisions** datasource (instead of, or alongside, the standard content
datasource), then pick the entity type, bundles and languages you want indexed
exactly as you would for the normal content datasource. From there you add
fields, choose processors and index as usual.
