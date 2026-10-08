# Configuration

Configuring Qdrant VDB Provider is two jobs: **store the API key securely**, then
**tell the provider where Qdrant lives** and select it for an AI Search index.

## 1. Store the Qdrant API key as a Key

Never paste the API key straight into a settings form or commit it to
configuration. Store it as an environment variable and reference it through the
**Key** module.

1. Put the value in an environment variable (with DDEV:
   `ddev dotenv set .ddev/.env --qdrant-api-key=<value>`, then `ddev restart` —
   keep `.ddev/.env` out of version control).
2. Enable Key if it is not already: `drush en key -y`.
3. Create a Key that reads the variable (env provider), for example
   `qdrant_api_key`, so the secret is never stored in Drupal's config.

## 2. Connect the provider to Qdrant

The Qdrant provider is configured together with the AI module's other
vector‑database providers under **Configuration → AI**. On its settings you
supply:

- **Endpoint / host** — the URL of your Qdrant instance. Use **HTTPS** and point
  it at an instance you trust. For self‑hosting this is your internal Qdrant
  host; for Qdrant Cloud it is the cluster URL they give you.
- **API key** — select the **Key** you created above rather than typing the
  secret directly.
- Any collection / index naming details the form exposes.

> **Data egress:** the content you index and its embeddings are sent to Qdrant.
> If that is a cloud instance, the data leaves your infrastructure — self‑host
> Qdrant if you need it to stay in‑house.

## 3. Use it for an AI Search index

1. Go to your AI Search / Search API server configuration.
2. Choose **Qdrant** as the vector‑database provider for the index.
3. Add your content to the index and let it build the embeddings.
4. Run semantic or RAG queries — they now execute as similarity searches inside
   Qdrant.

If queries fail, check the endpoint URL, that the Key resolves to a valid API
key, and that Drupal can reach the Qdrant host over the network.
