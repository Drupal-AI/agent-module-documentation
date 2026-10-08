# Search API Exclude — manual setup guide

**Search API Exclude** (`search_api_exclude`) adds a per‑node **"exclude from search
index"** checkbox, so editors can keep specific nodes out of a Search API index
without unpublishing them. It is the tidy way to hide a thank‑you page, a privacy
policy, staging notes, or thin/duplicate content from on‑site search while leaving
those pages perfectly viewable to visitors.

Exclusion is enforced by a Search API **processor** that drops flagged nodes at
index time, so an excluded node never reaches your search backend at all — which
means it works with any backend (database, Solr, and so on). Because the filtering
happens during indexing, a node's exclusion setting only takes full effect after a
reindex.

You switch the feature on per content type: a checkbox on the content‑type form
enables the exclude option for that bundle, and then the node edit form gains a
**"Prevent this node from being indexed"** checkbox. Finally you add the module's
processor to the Search API index that should honour the exclusions. The module
defines no permissions of its own — anyone who can edit a node of an
exclusion‑enabled bundle can set its flag.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   Search API) and enable it.

## How to use it

There is no admin settings page — the module has no configuration form of its own.
Setting up exclusion is three steps:

**1. Enable exclusion for a content type.** Go to the content‑type form
(**Structure → Content types → *your type* → Edit**,
`/admin/structure/types/manage/{bundle}`). Under *Additional settings* you'll find a
**Search API Exclude** group with an **Enabled** checkbox. Tick it and save. (This
is stored on the content type's configuration, so it exports with
`drush config:export`.)

**2. Flag individual nodes.** On a node of that bundle, the add/edit form now shows a
**Search API Exclude** group in the sidebar with a **"Prevent this node from being
indexed"** checkbox. Tick it on any node you want kept out of search, and save. (If
the bundle isn't enabled in step 1, this checkbox doesn't appear.)

**3. Add the processor to your index.** Go to your index's **Processors** tab
(**Configuration → Search and metadata → Search API → *your index* → Processors**,
`/admin/config/search/search-api/index/{index}/processors`) and enable the **Node
exclude** processor, then save. The processor only works on indexes whose datasource
covers nodes.

**Reindex.** Because exclusion is applied while indexing, reindex the index after
enabling the processor, after toggling a content type's Enabled setting, or after
changing a node's checkbox, so the change reaches the backend. The module prompts you
to reindex when a content type's setting changes.

### Who can exclude a node

The module adds no "may exclude" permission. Enabling exclusion for a content type
uses core's **Administer content types**; ticking a node's checkbox is available to
anyone with edit access to that node; adding the processor uses Search API's
**Administer search_api**. To restrict who can exclude nodes, restrict who can edit
them (or only enable exclusion on bundles edited by trusted roles).
