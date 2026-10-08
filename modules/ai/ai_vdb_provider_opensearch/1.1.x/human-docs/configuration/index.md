# Configuration

Setting this up is a two-part job: store the OpenSearch credentials as a secret,
then tell the AI Search layer to use OpenSearch as its vector database.

## 1. Store the OpenSearch credentials as a Key

Never paste the cluster credentials into a settings field or configuration file.
Instead:

1. Make the credential value available to the site as an **environment variable**
   (for DDEV, `ddev dotenv set` then `ddev restart`).
2. Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and add a
   new key that reads from that environment variable (authentication key type,
   environment provider).

This keeps the secret out of exported configuration; only the Key's name is stored
in config.

## 2. Point AI Search at OpenSearch

OpenSearch does not have its own settings page — you select it while configuring
AI Search on a Search API server:

1. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`).
2. Add (or edit) a **server** that uses the **AI Search** backend.
3. Choose **OpenSearch** as the vector database provider.
4. Enter the connection details for your cluster:
   - the **host / URL** (and port) of your OpenSearch cluster,
   - the **credentials**, selected from the Key you created in step 1, and
   - the **index** name to use for the vectors.
5. Save, then create a Search API **index** on that server and index your content
   so the embeddings are written to OpenSearch.

## Things to check

- **Secure the cluster.** OpenSearch should require authentication and, ideally,
  TLS. Do not expose an open cluster to the network.
- **Content leaves your site to be embedded.** Indexing sends content to your
  configured AI provider to generate the embeddings (cost + data egress).
- **Respect access.** A vector index is not governed by Drupal's permissions by
  default, so restrict what you index and make sure any search you expose does not
  surface content a viewer shouldn't see.
