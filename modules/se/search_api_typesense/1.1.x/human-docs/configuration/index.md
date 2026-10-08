# Configuration

Getting Typesense working is a short sequence of steps in the Search API UI. The
one step people miss is the **schema** — indexing will not work until it is
complete.

## 1. Create a Search API server

Go to **Configuration → Search and metadata → Search API** and add a **server**,
choosing the **Typesense** backend. Point it at the Typesense instance you set up
during installation and supply the connection details, including the Typesense
API key.

> **Keep the API key safe.** The Typesense API key has index-write access. Treat
> it as a credential and keep it out of exported configuration.

## 2. Create an index

Add a Search API **index** that uses the Typesense server you just created.

## 3. Add fields — including a sortable numeric field

Add the fields you want to index to the index. **You must include at least one
numeric field that can be used for sorting** — Typesense requires it.

## 4. Define the collection schema (required)

Open the index's **Schema** tab at
`/admin/config/search/search-api/index/{index_name}/schema` and configure the
Typesense collection's schema. **This step is mandatory: indexing content is not
possible until the schema has been completed.** Once the schema is saved, you can
index content as normal.

## 5. Manage search quality (optional)

The module surfaces Typesense's search-quality tools directly in the Drupal UI:

- **Synonyms** — teach the search that different words mean the same thing (users
  often search for a word your content does not use). Synonym management has its
  **own permission**, `administer search_api_typesense synonyms`, so you can hand
  it to a content editor without giving them control of the whole search server.
- **Curations** — pin or promote specific results for particular queries.
- **Stopwords** — words to ignore during search.
- **API-key management** and **embedding / semantic search** are also available
  from the backend.

## Note on front-end search

Unlike some other Search API backends, this module does **not** build a search
results page with Views — that is by design, since implementing the search in the
front end is faster. Plan to build your search experience on the front end rather
than expecting a Views-based results page.

## Resilience

Because Typesense is a network service, decide what should happen when it is
unreachable. A search page that fatals is a worse experience than one that
degrades gracefully — plan for a fallback rather than leaving search to error out.
