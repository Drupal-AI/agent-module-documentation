# Configuration

This provider has no connection form of its own — it reuses the OpenAI credential
you configure for the OpenAI provider. Setup is two steps: confirm the OpenAI key
is stored as a secret, then choose OpenAI as the vector database for your AI
search.

## 1. Confirm the OpenAI API key is stored as a Key

The OpenAI API key should already be configured for the **OpenAI provider**
(`ai_provider_openai`) as part of setting up the AI module. It must be stored as a
secret, not in plain configuration:

1. Make the key available to the site as an **environment variable** (for DDEV,
   `ddev dotenv set .ddev/.env --openai-api-key=<value>` then `ddev restart`).
2. Under **Configuration → System → Keys** (`/admin/config/system/keys`), the key
   should read from that environment variable (authentication key type,
   environment provider), and the OpenAI provider should be pointed at that Key.

If the OpenAI provider already works for text generation, this is done — the same
key is reused for vector storage.

## 2. Select OpenAI as the vector database

OpenAI does not have its own settings page — you select it while configuring AI
Search on a Search API server:

1. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`).
2. Add (or edit) a **server** that uses the **AI Search** backend.
3. Choose **OpenAI** as the vector database provider.
4. Save, then create a Search API **index** on that server and index your content
   so the embeddings are stored via OpenAI.

## Things to check

- **This is experimental.** The module is marked experimental (release
  1.0.0-alpha3) — treat its behavior as unsettled and test before relying on it.
- **Cost and data egress.** Storing and querying embeddings sends vectors and text
  to OpenAI, which is billed by OpenAI and means content leaves your site.
- **Respect access.** A vector index is not governed by Drupal's permissions by
  default, so restrict what you index and make sure any search you expose does not
  surface content a viewer shouldn't see.
