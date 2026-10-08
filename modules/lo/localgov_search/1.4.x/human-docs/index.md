# LocalGov Search — manual setup guide

**LocalGov Search** (`localgov_search`) is the sitewide search for
[LocalGov Drupal](https://localgovdrupal.org/). It gives a LocalGov site working
search the moment you install it: a Search API index that covers every content
type, a `/search` results page, a search box you can place in the header, and —
the clever part — automatic enrolment of new content types into the index as they
are created, so you never have to remember to add them.

The module ships two ready-made configuration objects: the
`localgov_sitewide_search` Search API index and a matching view that renders the
results page. Content is indexed through a **`search_index`** view mode and
displayed in results through a **`search_result`** view mode, which means tuning
*what* gets searched and *how* a result looks is done on the content type's
Manage display screens — not deep inside Search API.

Whenever a new content type appears on the site, LocalGov Search automatically
adds it to both the index and the results view, so it becomes searchable without
any manual step. The results page also stays tidy: it shows a bare search form
until a query has actually been submitted, and it puts the search term into the
page heading once there are results.

Importantly, the search **backend** is deliberately kept separate. LocalGov
Search defines the index but not the server that stores it. For a simple
database-backed setup, enable the bundled `localgov_search_db` submodule; to use
Apache Solr instead, point the index at a Solr server and leave the submodule
off.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and choose a search backend.
2. [Configuration](configuration/index.md) — place the search block, tune what is
   indexed and how results look, and manage content types.

## Where it lives in the admin menu

LocalGov Search does not add a settings form of its own. Instead it works through
several standard admin areas:

- The search index and its fields live under **Configuration → Search and
  metadata → Search API**
  (`/admin/config/search/search-api/index/localgov_sitewide_search`).
- The results view is at **Structure → Views → Sitewide search**.
- The search box is the **Sitewide search block**, placed at **Structure → Block
  layout**.
- What is indexed and how results render is controlled by the `search_index` and
  `search_result` view modes on each content type's **Manage display** screen.
