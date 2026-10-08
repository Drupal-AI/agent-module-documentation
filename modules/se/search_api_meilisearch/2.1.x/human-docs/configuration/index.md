# Configuration

You configure Search API Meilisearch through the standard Search API screens at
**Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`). The Meilisearch-specific settings live inside
the server form.

> **Security first.** Keep the Meilisearch server off the public internet, and give
> Drupal a **scoped search API key rather than the master key**. Exposing the
> server or handing it the master key is the classic mistake that lands search
> instances in security scans.

## Create the Meilisearch server

1. Go to **Search API** and choose **Add server**.
2. Name the server and select the **Meilisearch** backend.
3. Enter the connection details for your running Meilisearch instance — its host
   URL and the API key Drupal should authenticate with (use a scoped search key).
4. Save the server. Search API will report whether it can reach Meilisearch.

## Create and configure the index

1. Choose **Add index**, name it, and pick your data source (for example,
   Content). The module creates the corresponding index on the Meilisearch server.
2. Assign the index to the Meilisearch server.
3. On the **Fields** tab, add the fields you want searchable, filterable, and
   sortable.
4. On the **Processors** tab, set up your processing pipeline as usual.
5. Index your content. Removing the index later also deletes it on the Meilisearch
   server.

The backend supports filtering and sorting, plus **synonyms** and **stop words**,
which you manage as part of the index configuration.

## Facets

If you enabled the **Facets** submodule (`search_api_meilisearch_facets`) and the
Facets module, add facets through **Configuration → Search and metadata → Facets**
(`/admin/config/search/facets`), targeting your Meilisearch index. Because facets
and complex filtering are the areas where lighter engines historically trail Solr,
test the facet set your site actually uses rather than a simple keyword query.

## Autocomplete

If you enabled the **Autocomplete** submodule
(`search_api_meilisearch_autocomplete`) together with the Search API Autocomplete
module, configure search-as-you-type on your search box through the Search API
Autocomplete settings for the relevant index. Note that Meilisearch already
provides typo tolerance and prefix matching by default, so the search feels
forgiving without extra tuning.
