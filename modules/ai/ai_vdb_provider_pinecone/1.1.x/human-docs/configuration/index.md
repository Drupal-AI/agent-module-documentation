# Configuration

There are two steps: give the module your Pinecone API key (as a Key entity), then choose
Pinecone as the vector database on an AI Search index.

## 1. Store the Pinecone API key as a Key entity

The settings form never stores the raw secret — it stores the **name of a Key entity**, and
the key value is resolved at runtime. So create the Key first. The recommended approach is to
keep the secret in an environment variable and use Key's **env** provider.

Store the value in an environment variable (for DDEV, use its dotenv command so it isn't
committed), then create the Key:

```bash
drush key:save pinecone_api_key --label='Pinecone API Key' --key-type=authentication \
  --key-provider=env --key-provider-settings='{"env_variable":"PINECONE_API_KEY"}' \
  --key-input=none -y
```

(You can also use Key's file or config providers if that suits your setup better — the module
only cares that a Key entity exists and resolves to a valid Pinecone key.)

## 2. Fill in the settings form

1. Log in as a user with the **Administer AI providers** permission.
2. Go to **Configuration → AI → VDB Providers → Pinecone**, or navigate directly to
   `/admin/config/ai/vdb_providers/pinecone`.
3. In the **API key** field, select the Key entity you created (for example *Pinecone API
   Key*). This is a Key-selector, not a place to paste the raw key.
4. **Save**. On save the form fetches the key's value and tests it by asking Pinecone to
   **list your indexes**. If the credentials are wrong, or the account has no indexes, the
   form reports an error instead of saving — so a successful save confirms the connection
   works.

Only the Key's name is written to configuration (`ai_vdb_provider_pinecone.settings:api_key`).
The schema also carries optional `hostname`, `region` and `cloud_provider` values; in normal
use the index host is resolved automatically from Pinecone's own responses, so you do not
need to set these by hand.

## 3. Use Pinecone on an AI Search index

With `ai_search` and `search_api` enabled:

1. Create (or edit) a **Search API server** that uses the **AI Search** backend.
2. For its **vector database**, select **Pinecone DB** (the `pinecone` provider).
3. Point a Search API **index** at that server as usual, and index your content.

From then on, AI Search routes all index and vector operations — creating/describing the
index, upserting vectors into a namespace, similarity queries with metadata filters, fetches
and deletes — to your Pinecone index. Using separate namespaces within one index is a neat
way to keep multiple tenants or content bundles apart.

## Notes

- The list of your Pinecone indexes is cached to cut down on API calls; if you add an index in
  Pinecone and don't see it, clear Drupal's caches.
- Errors from Pinecone are shown as site messages and logged to the `ai_search` log channel,
  so check **Reports → Recent log messages** if a query or indexing run misbehaves.
