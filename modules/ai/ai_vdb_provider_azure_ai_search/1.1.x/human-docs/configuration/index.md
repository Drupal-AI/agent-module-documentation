# Configuration

Setting this up is a two-part job: store your Azure credential as a secret, then
tell the AI Search layer to use Azure AI Search as its vector database.

## 1. Store the Azure API key as a Key

Never paste the Azure key into a settings field or configuration file. Instead:

1. Make the key value available to the site as an **environment variable** (the
   recommended approach — for DDEV, `ddev dotenv set` then `ddev restart`).
2. Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and add a
   new key that reads from that environment variable (authentication key type,
   environment provider).

This keeps the secret out of exported configuration; only the Key's name is stored
in config.

## 2. Point AI Search at Azure

Azure AI Search does not have its own settings page — you select it while
configuring AI Search on a Search API server:

1. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`).
2. Add (or edit) a **server** that uses the **AI Search** backend.
3. Choose **Azure AI Search** as the vector database provider.
4. Enter the connection details for your Azure service:
   - the **endpoint URL** of your Azure AI Search service (the HTTPS address from
     the Azure portal), and
   - the **API key**, selected from the Key you created in step 1.
   - the **index** name to use in Azure for the vectors.
5. Save, then create a Search API **index** on that server and index your content
   so the embeddings are written to Azure.

## Things to check

- **Use HTTPS.** The Azure endpoint is a public network address; always use the
  `https://…` form.
- **Data leaves your site.** The content you index and its embeddings are sent to
  Azure. Confirm that is acceptable for the data in question.
- **Respect access.** A vector index is not governed by Drupal's permissions by
  default, so restrict what you index and make sure any search you expose does not
  surface content a viewer shouldn't see.
