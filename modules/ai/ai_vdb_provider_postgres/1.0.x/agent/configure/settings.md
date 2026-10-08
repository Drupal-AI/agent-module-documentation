# Configure the Postgres connection (configure)

There are **two layers** of configuration: (1) a single global connection to the Postgres server,
set on this module's own settings form; (2) per-**Search API server** settings (which database,
collection/table, similarity metric, index strategy) set on the AI Search backend when you pick
`Postgres vector DB` as the VDB provider. There is no per-index config beyond that.

## Global connection — `ai_vdb_provider_postgres.settings`

Form: `Drupal\ai_vdb_provider_postgres\Form\PostgresConfigForm` (form id
`ai_vdb_provider_postgres_settings`). Route `ai_vdb_provider_postgres.settings_form`,
path `/admin/config/ai/vdb_providers/postgres`, requirement `_permission: 'administer ai providers'`
(a permission defined by the **ai** module, not here). Menu link
`ai_vdb_provider_postgres.settings_menu` under parent `ai.admin_vdb_providers`.

Config object `ai_vdb_provider_postgres.settings` (schema `config/schema/…schema.yml`):

| Key | Type | Form element | Meaning |
|---|---|---|---|
| `host` | string (required) | `textfield` | Postgres host. `submitForm()` `rtrim`s a trailing `/`. |
| `port` | integer | `textfield` | Server port; empty ⇒ code defaults to `5432`. `validateForm()` requires numeric. |
| `username` | string (required) | `textfield` | DB user. |
| `password` | string (required) | **`key_select`** | Stores a **Key entity id**, not the secret (see below). |
| `default_database` | string (required) | `textfield` | Database used when a search server does not override it. |

`config/install/ai_vdb_provider_postgres.settings.yml` ships empty defaults (`host: ''`, `port: null`,
`username: ''`, `password: ''`, `default_database: ''`) — the module is inert until configured.

### Password / credential handling

The password field is `'#type' => 'key_select'` and `submitForm()` persists whatever the Key module
returns — a **Key entity id**. The plaintext is never written to this module's config. At runtime
`PostgresProvider::getConnectionData()` resolves it via `keyRepository->getKey($id)->getKeyValue()`
only in memory; `validateForm()` resolves it the same way to run the live connection test
(`PostgresProvider::ping()`). Requires the **key** module (a hard dependency). Store the DB password
in a Key (env/file/config provider) and select it here.

### Connection test

`validateForm()` builds a throwaway provider via `setCustomConfig([...])` and calls `ping()`; a
failure sets a form error `Could not connect to the server.` This is where a missing pgvector
extension or bad credentials surface. Note the host is **not** URL-validated (the `filter_var`
check is commented out).

## Per-server settings (AI Search backend)

When you create a Search API server with backend `search_api_ai_search` and choose
`Postgres vector DB`, these live in `search_api.server.<id>` under
`backend_config.database_settings`:

| Setting | Meaning |
|---|---|
| `database_name` | Postgres database to connect to (overrides `default_database`). |
| `collection` | The main table name for this server's vectors. |
| `metric` | Similarity metric (`VdbSimilarityMetrics`: cosine / L2 / inner product). |
| `vector_index_strategy` | `none` \| `hnsw` \| `ivfflat` (`Enum\VectorIndexStrategy`). Added to the form by `PostgresProvider::buildSettingsForm()`; `#required`. |

`backend_config.database` must equal `postgres` for this provider's hooks/subscribers to act.

### How the index strategy is actually applied — `VectorIndexConfigSubscriber`

`Drupal\ai_vdb_provider_postgres\EventSubscriber\VectorIndexConfigSubscriber` subscribes to
`ConfigEvents::SAVE` (priority **-10**, so the upstream ai_search subscriber that creates the
collection runs first). On save of a `search_api.server.*` config whose `backend` is
`search_api_ai_search` and `database` is `postgres`, it reads `collection` / `database_name` /
`vector_index_strategy` / `metric`, confirms the collection table exists
(`getCollections()`), then calls `PostgresPgvectorClient::ensureVectorIndex()` — which drops and
recreates the pgvector index (`hnsw`/`ivfflat`) or drops it (`none`). The class docblock notes this
is a workaround: ai_search does **not** call `AiVdbProviderInterface::submitSettingsForm()`, so the
strategy has to be applied at config-save time. `PostgresProvider::submitSettingsForm()` also calls
`ensureVectorIndex()` and adds a status message when the strategy changes.
