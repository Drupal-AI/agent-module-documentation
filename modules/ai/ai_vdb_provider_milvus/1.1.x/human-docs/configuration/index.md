# Configuration

The module has one settings form for the Milvus/Zilliz connection. After
configuring it, you select this provider as the vector store when you set up AI
Search.

## Open the settings form

1. Log in as a user with the **Administer AI providers** permission (the
   permission is defined by the AI module, not this one).
2. Go to **Configuration → AI → Vector Database Providers → Milvus**, or navigate
   directly to `/admin/config/ai/vdb_providers/milvus`.

## The connection settings

- **Server** (`server`) — the full base URL of your Milvus/Zilliz endpoint. For a
  local Milvus in DDEV this is `http://milvus`; for Zilliz Cloud, use the "Public
  Endpoint" URL from your Zilliz console. A trailing slash is stripped
  automatically on save.
- **Port** (`port`) — the server port. A local Milvus typically uses **19530**;
  Zilliz Cloud uses **443**.
- **API key** (`api_key`) — the **machine name of a Key entity** that holds the
  authentication secret — *not* the secret itself. This is optional: leave it empty
  for a local, unauthenticated Milvus. When set, the key's value is sent as a
  `Bearer` token. For Milvus the value should be in `username:password` form; for
  Zilliz Cloud it is your API token.

When you save, the form **pings the server** using the values you entered (through
the provider plugin) before it will accept them — a wrong host or bad credential
blocks the save with "Could not connect to the server," so you get immediate
feedback that the connection works.

## Storing the credential (Key module)

Because **API key** references a Key entity, the actual secret can live in an
environment variable or file via the Key module's providers, keeping it out of your
exported configuration.

1. First create the Key at **Configuration → System → Keys**
   (`/admin/config/system/keys`), backed by an environment variable or file, with
   the appropriate value (`username:password` for Milvus, or the API token for
   Zilliz).
2. Then return to the Milvus settings form and select that Key in the **API key**
   field.

For a local Milvus with no authentication, simply leave **API key** empty.

## Running a local Milvus with DDEV (development)

The module ships an example Docker Compose file for spinning up Milvus alongside
your DDEV project:

1. Copy
   `docs/docker-compose-examples/ddev-example.docker-compose.milvus.yaml` (from the
   module) to `.ddev/docker-compose.milvus.yaml`.
2. Run `ddev restart`.
3. Use **Server** `http://milvus` and **Port** `19530` in the settings form (no
   API key needed). The Milvus web UI is available at
   `https://<project>.ddev.site:8521`.

## Setting the connection without the UI (optional)

```bash
# Reference an existing Key entity named 'milvus_auth'
ddev drush cset ai_vdb_provider_milvus.settings server 'http://milvus' -y
ddev drush cset ai_vdb_provider_milvus.settings port 19530 -y
ddev drush cset ai_vdb_provider_milvus.settings api_key milvus_auth -y
```

Note that setting config directly this way **skips** the connection ping that the
form performs.

## Using the provider in AI Search

Once configured, go to your **AI Search** server/index setup (provided by the
`ai_search` module) and choose **Milvus** as the Vector Database backend. This
module supplies the storage; the AI and AI Search modules handle generating
embeddings and indexing your content.
