# Search API Content Moderation — manual setup guide

**Search API Content Moderation** (`search_api_content_moderation`) adds a
Content Moderation *processor* to Search API. Once you enable the processor on an
index, Search API can take a content item's moderation state into account while
indexing — most commonly to keep unpublished or draft content out of the index so
it never turns up in search results.

The typical use case is a site running core's editorial workflow (Content
Moderation) where content moves through states like *Draft*, *Needs review*, and
*Published*. Without this module, a search index built from rendered or field
content might happily index a draft and expose it to anyone who can search. This
processor lets the index filter by moderation state so that, for example, only
content marked **Published** is indexed. That matters for more than tidiness: if
you index draft content and don't filter it out, you risk disclosing work-in-progress
to people who shouldn't see it. The module has no access-control role of its own —
it simply makes moderation state available to Search API so you can configure the
index to respect it.

This is not an on-enable feature. Enabling the module makes the processor
available, but you then have to turn it on for each index and choose how it should
behave. It depends on **Search API** (`search_api`) and core's **Content
Moderation** (`content_moderation`), and it ships no submodules.

This guide is written for a **human** working through the admin UI. If you are an
AI agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The module has no configuration page of its own; you enable and configure the
processor on each Search API index:

1. Go to **Configuration → Search and metadata → Search API** and edit the index
   you want to control.
2. Open the **Processors** tab.
3. Enable the **Content Moderation** processor.
4. Configure it so that non-published or draft content is not indexed (or is
   filtered out of results), then save and re-index.

Because search results should respect content access, take a moment to confirm
that after re-indexing your draft content really is absent from search — indexing
draft content without filtering it out is a disclosure risk.
