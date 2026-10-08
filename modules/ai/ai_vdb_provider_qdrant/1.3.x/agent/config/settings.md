<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Connection settings & config form

## Install / enable

`composer require drupal/ai_vdb_provider_qdrant` then `drush en ai_vdb_provider_qdrant`. Pulls in `ai`,
`ai_search`, `key`, `search_api` and needs the PHP `curl` extension. You also need a reachable Qdrant
server (a docker-compose example ships at `docs/docker-compose-examples/qdrant-docker-compose.yml`;
Qdrant's default port is 6333).

## Config object

- **Name:** `ai_vdb_provider_qdrant.settings` (defined in `QdrantConfigForm::CONFIG_NAME`).
- **Install defaults** (`config/install/ai_vdb_provider_qdrant.settings.yml`): `host: ""`, `port: null`.
- **Schema** (`config/schema/ai_vdb_provider_qdrant.schema.yml`): `host` (string, required), `port`
  (integer, optional). Note: the schema does not declare `api_key`, though the form saves it.

Keys written by the form:

| Key | Meaning |
| --- | --- |
| `host` | Qdrant server host. Saved with any trailing `/` stripped. If it has no `http://`/`https://` scheme, the client prepends `http://` at connection time. |
| `port` | Server port. Defaults to `6333` when empty (see `QdrantProvider::getConnectionData()`). |
| `api_key` | The **machine name of a Key entity** (not the raw secret) selected via the `key_select` element. Optional. |

## Route, form, menu

- Route **`ai_vdb_provider_qdrant.settings_form`** → `/admin/config/ai/vdb_providers/qdrant`, form
  `\Drupal\ai_vdb_provider_qdrant\Form\QdrantConfigForm`, requirement `_permission: 'administer ai
  providers'`.
- Menu link `ai_vdb_provider_qdrant.settings_menu` ("Qdrant Configuration") under parent
  `ai.admin_vdb_providers`.
- `configure:` in info.yml points at the same route.

## Form behaviour (`QdrantConfigForm`)

- `buildForm()` renders three fields: `host` (textfield, **required**), `port` (textfield, default
  `6333`), `api_key` (**`key_select`**, optional — description says "used to authenticate with the Qdrant
  server (optional)").
- `validateForm()` requires `port` to be numeric if set, resolves the selected Key to its value via
  `keyRepository->getKey($apiKey)->getKeyValue()`, then instantiates the `qdrant` provider, calls
  `setCustomConfig([host, port, api_key])` and **`ping()`s the server** — a failed ping sets a "Could not
  connect to the server." error, so bad connections are rejected on save. (A commented-out block shows a
  disabled `FILTER_VALIDATE_URL` host check.)
- `submitForm()` saves `host` (trailing slash trimmed), `port`, and the `api_key` Key machine name.

## API key handling

The API key is never stored inline: the form persists the **Key entity id**, and
`QdrantProvider::getConnectionData()` looks it up at runtime through `keyRepository` and reads
`getKeyValue()`. Create the key first (Key module — e.g. an env-provider key), then select it here.
`QdrantClient::makeHttpRequest()` sends it as the `Api-Key` request header only when non-empty.

## Operating it

1. Configure host/port/key here and save (the ping must succeed).
2. Add a Search API server at `/admin/config/search/search-api/add-server` using the **AI Search**
   backend and the **Qdrant vector DB** provider; pick the similarity metric there.
3. Add an index on that server and configure fields per AI Search docs; the collection is created
   automatically on first indexing.
