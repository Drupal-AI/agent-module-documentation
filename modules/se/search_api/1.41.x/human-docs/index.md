# Search API — manual setup guide

**Search API** (`search_api`) is a generic, backend-agnostic framework for
building search on your Drupal site. Rather than hard-wiring one search engine,
it splits the job into pieces you configure: a **server** (backed by a *backend*
plugin such as the bundled Database or Apache Solr), an **index** that pulls
content from one or more entity types, the **fields** you want to search, and a
pipeline of **processors** that clean and tokenize the text before it is stored.
Once content is indexed you expose the results to visitors — most commonly with a
**Views** display that runs a Search API query.

This guide is written for a **human** clicking through the admin UI. It walks you
from installing the module to building your first server and index and getting
content indexed. Search API is a large module with many advanced options; this
guide sticks to the essential path — install, understand the concepts, and build a
working server plus index. If you are looking for terse, token-cheap references for
an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

![The Search API overview page listing servers and indexes](images/overview.png)

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → Search and metadata →
Search API** (`/admin/config/search/search-api`). That overview page lists your
servers and the indexes grouped beneath them, and gives you the buttons to build
new ones:

- **+ Add server** (`/admin/config/search/search-api/add-server`) — define a
  storage/query engine backed by a backend plugin.
- **+ Add index** (`/admin/config/search/search-api/add-index`) — define which
  content is indexed, on which server, with which fields and processors.
- **+ Execute pending tasks** — run any queued indexing/maintenance tasks.

## Contents

1. [Installation](installation/index.md) — install Search API with Composer, enable
   it, and turn on a backend submodule such as Database Search.
2. [Configuration](configuration/index.md) — the overview page and the overall
   flow of building search: server → index → fields → processors → index content.
3. [Creating a server and index](creating-a-server-and-index/index.md) — the
   click-by-click steps to add a server, add an index, add fields, index your
   content, and display the results with a view.
