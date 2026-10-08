# Configuration

You configure Search API Manticore through the standard Search API screens at
**Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`), with one preparatory step when your engine
uses authentication: storing the Manticore connection password in a Key.

## Step 1 — store the credentials in a Key (only if the engine requires auth)

When the Manticore engine has HTTP Basic Authentication enabled, the module reads
its password from a **Key entity** rather than from exported configuration, so the
secret never lands in your config export. An engine with authentication disabled
(for example a local engine on `http://localhost:9308`) needs no Key.

1. Go to **Configuration → System → Keys** (`/admin/config/system/keys`).
2. Choose **Add key**.
3. Choose the **Authentication** key type and a key provider that suits your setup
   — Key's **configuration**, **file**, or **environment** provider are all
   supported. The file and environment providers keep the value out of exported
   configuration.
4. Store the plain Basic Auth password as the key value and save.

## Step 2 — create the Manticore server

1. Go to **Search API** and choose **Add server**.
2. Name the server and select the **Manticore** backend.
3. Select the **SDK over HTTP JSON** connector and enter its settings:
   - **Manticore URL** — the full URL of the engine's HTTP JSON endpoint. Only the
     `http` and `https` schemes are accepted. A directly exposed engine serves
     plain HTTP on Manticore's native port 9308, written explicitly
     (`http://localhost:9308`); an engine behind a TLS reverse proxy is reached
     over standard HTTPS (`https://search.example.com`).
   - **HTTP Basic Authentication** — required only when the engine enforces it.
     Enter the **Username** and select the **Password key** you created in step 1.
     Leave both empty for an unauthenticated server.
4. Optionally set a **Table prefix** under **Storage settings** if several Drupal
   sites share one Manticore engine.
5. Save the server. Search API reports whether it can reach Manticore.

## Step 3 — create and configure the index

1. Choose **Add index**, name it, and pick your data source (for example,
   Content) and the Manticore server, then save. The Fields UI becomes available
   after this first save.
2. On the **Fields** tab, add the fields you want to index — all six built-in field
   types are supported, single- and multi-value.
3. On the **Manticore table settings** section of the index **Edit** tab, set the
   engine options that apply to the table as a whole — morphology (stemming),
   whether to store field lengths for ranking, and the infix indexing length that
   autocomplete and spellcheck depend on.
4. On the **Processors** tab, configure the processing pipeline as you would for
   any Search API index.
5. Index your content.

## Building search, facets, and the extra features

- **Search pages** are built with Views, using the Search API query integration,
  including the Direct parse mode for full-text queries.
- **Facets** work through the Facets module on any indexed field, including
  per-element counts on multi-value fields and the OR operator for multi-select
  facets.
- **Autocomplete** (Search API Autocomplete) and **spellcheck** (Search API
  Spellcheck) both require infix indexing on the index — set the infix length in
  the Manticore table settings, then rebuild an existing index.
- **Semantic and hybrid search** — matching by meaning using Manticore's native
  vector embeddings — is configured in Views, either on its own or fused with
  keyword relevance, with no custom code. Because Manticore generates the
  embeddings itself from local models, no external embedding service or API key is
  involved.
- **More Like This** (related items) is fulfilled by vector similarity and added
  as a contextual filter in Views.
- **Location & geospatial search** (with Search API Location) supports radius
  filtering, a closest-first distance sort, and optional server-side geohash
  clustering for maps. Clustering needs the `beste/latlon-geohash` library
  (`composer require beste/latlon-geohash`).

Random sort is available via the **Global: Random** Views sort criterion. Grouping
is not supported in this release. See the module README for the full narrative
reference on vector search, geospatial search, and the write-path events.
