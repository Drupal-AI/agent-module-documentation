# Configuration

Setting up Azure AI Search follows the standard Search API pattern — a server, an
index, indexed content, and a View to display results — plus careful handling of the
Azure credentials.

## Handle the Azure credentials first

The module connects to Azure with admin and query keys. Before anything else:

- **Store the keys as secrets.** Use the module's **Key** submodule (with the Key
  module) so the credentials live in a Key entity or an environment variable rather
  than in plain, exported configuration.
- **Scope the keys.** Use a query-only key for querying and reserve the admin key for
  indexing/administration, so a front-end search can never use an administrative key.
- **Be aware of data residency.** Content you index is sent to and stored in Azure.
  Decide deliberately whether that is acceptable for the content in question,
  especially anything sensitive.

## Set up the server and index

On Search API's admin pages (**Configuration → Search and metadata → Search API**,
`/admin/config/search/search-api`):

1. **Add a server** and choose the Azure AI Search backend. Configure it with your
   Azure endpoint and the credentials you prepared above.
2. **Add an index** to that server and choose which content (entities, bundles, and
   fields) to index.
3. **Index your content** so it is written to Azure.

## Build the search experience

1. **Create a search View** for the new index to query Azure AI Search.
2. Optionally **add the semantic answer widget** to the View so the semantic answer
   is displayed as a field next to the results.
3. **Test the search** to confirm results come back from Azure as expected.

## Optional extras

- With the **Autocomplete** submodule and the Search API Autocomplete module, add the
  Azure suggester to your search box.
- With the **Logging** submodule, enable the upvote/downvote scoring widget on the
  semantic answer and log semantic searches to the database for later analysis.

For Azure-specific field mappings and setup details, follow the README included with
the module.
