# Configuration

You configure Search API Manticore through the standard Search API screens at
**Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`), with one preparatory step: storing the
Manticore connection password in a Key.

## Step 1 — store the credentials in a Key

The module reads Manticore's HTTP Basic Auth password from a **Key entity** rather
than from exported configuration, so the secret never lands in your config export.

1. Go to **Configuration → System → Keys** (`/admin/config/system/keys`).
2. Choose **Add key**.
3. Pick a key provider that suits your setup — Key's **configuration**, **file**,
   or **environment** provider are all supported. The environment provider (which
   reads the value from an environment variable) is the usual choice for keeping
   secrets out of the database and code entirely.
4. Enter or point to the Manticore password and save the key.

## Step 2 — create the Manticore server

1. Go to **Search API** and choose **Add server**.
2. Name the server and select the **Manticore** backend.
3. Enter the connection details for your running Manticore instance — its host and
   the HTTP JSON API endpoint — and, where authentication is required, select the
   **Key** you created in step 1 for the password.
4. Save the server. Search API will report whether it can reach Manticore.

## Step 3 — create and configure the index

1. Choose **Add index**, name it, and pick your data source (for example,
   Content).
2. Assign it to the Manticore server.
3. On the **Fields** tab, add the fields you want to index — all six built-in field
   types are supported, single- and multi-value.
4. On the **Processors** tab, configure the processing pipeline as you would for
   any Search API index.
5. Index your content.

## Building search, facets, and semantic search

- **Search pages** are built with Views, using the Search API query integration,
  including the Direct parse mode for full-text queries.
- **Facets** work through the Facets module on any indexed field, including
  per-element counts on multi-value fields and the OR operator for multi-select
  facets.
- **Semantic and hybrid search** — matching by meaning using Manticore's native
  vector embeddings — is configured in Views, either on its own or fused with
  keyword relevance, with no custom code. Because Manticore generates the
  embeddings itself from local models, no external embedding service or API key is
  involved.

Autocomplete, More Like This (via vector similarity), and random sort are also
supported. Spellcheck, grouping, and location data types are not supported in this
release.
