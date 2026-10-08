# Search API Taxonomy Filter — manual setup guide

**Search API Taxonomy Filter** (`search_api_tax_filter`) is a Search API index
pre-processor that limits indexing to content associated with a set of taxonomy
terms you choose. Instead of indexing everything on the site, the index only
picks up items tagged with the terms you configure — so your search results stay
scoped to exactly the content you want to be findable.

It solves a common need: you have a large site, but only some of it should turn
up in a particular search. By enabling this processor on a Search API index and
selecting the relevant vocabulary terms, everything else is simply left out of
the index. The module depends only on **Search API** and adds no settings page of
its own — you configure it from within the Search API index's processor
settings.

One important caveat, worth repeating because it is easy to misread: this is a
**scoping tool, not access control**. Content that is not indexed is merely
not-found-in-search — it is not protected. The pages themselves remain reachable
by their URL. Never rely on "it isn't in the index" to hide sensitive content;
use real permissions for that.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

The module has no standalone settings page. Once it is enabled, edit the Search
API index you want to scope (**Configuration → Search and metadata → Search
API**, then your index → the **Processors** tab), turn on the taxonomy filter
processor, and choose which taxonomy terms content must match to be indexed. Save
the index and re-index so the new scope takes effect.
