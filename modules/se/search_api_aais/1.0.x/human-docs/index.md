# Search API Azure AI Search — manual setup guide

**Search API Azure AI Search** (`search_api_aais`) provides a Search API backend
that indexes and queries your content using **Azure AI Search** — Microsoft's
hosted search service, formerly known as Azure Cognitive Search, which offers
traditional and AI/semantic search over your own content at scale. Content you index
through Search API is stored in and queried from Azure, and the module can display
the semantic *answer* of a search as a separate field next to the results.

In practice you use it the way you use any Search API backend: you add an Azure AI
Search *server* in Search API, attach an *index* to it, index your content, and
build a search View to query that index. On top of that, the module offers extra
capabilities through submodules — an **autocomplete suggester** for the Search API
Autocomplete module, and a **logging/scoring** feature that adds upvote/downvote
widgets on the semantic answer, tracks semantic answers, and logs semantic searches
to the Drupal database. A companion **Key** submodule lets you store your Azure
credentials as managed secrets.

There is an important security and data-handling consideration. The module talks to
Azure using **admin and query keys**: store these as secrets (use the key submodule
rather than pasting keys into plain configuration), and scope query keys versus admin
keys appropriately so a front-end search cannot use an administrative key. Also note
that your **indexed content is sent to and stored in Azure**, which is a
data-residency and data-handling decision you should make deliberately, especially
for sensitive content. It depends on core **Language** and the **Search API** module,
and supports Drupal 9.2 through 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect to Azure, add a server and
   index, and handle credentials safely.

## Where it lives in the admin menu

The module's own configuration form is registered as
`search_api_aais.configuration_form`. The main setup, however, happens on Search
API's own admin pages under **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`), where you add and configure the Azure AI Search
server and index.
