# Configure the amazee.ai provider

## Settings form — `ai_provider_amazeeio.settings_form`

Route path `/admin/config/ai/providers/amazeeio` (menu: **Config → AI → AI Providers →
amazee.ai Authentication**, `ai_provider_amazeeio.settings_menu`, parent `ai.admin_providers`).
Access = permission **`administer ai providers`** (defined by AI Core, not this module). Form
class `Form\AmazeeioAiConfigForm`, config object `ai_provider_amazeeio.settings`.

Unlike most providers there is **no "paste your API key" field**. The form is a multi-step
state machine (`disconnected → validation → validated → connected`) that talks to amazee.ai's
management API (`amazee_host`):

1. **Email** — enter an email; amazee.ai emails a verification code (or an anonymous free
   trial is started automatically).
2. **Verify** — enter the code; the form stores a temporary access token.
3. **Select / create a private key** — pick an existing amazee.ai private API key or create a
   new one (tableselect of the account's keys).
4. **Connect** — on connect (`saveConfiguration()`) the form writes the resolved values into
   config **and** into two Key entities, then AI Core is ready to use amazee.ai.

On connect it saves (form lines ~953-960):

| Config key | Source | Meaning |
|---|---|---|
| `host` | `litellm_api_url` of the chosen key | The LLM (LiteLLM/OpenAI-compatible) endpoint used for chat/embeddings calls. |
| `postgres_host` | `database_host` | VectorDB Postgres host. |
| `postgres_port` | `database_port` (default 5432) | VectorDB Postgres port. |
| `postgres_default_database` | `database_name` | VectorDB database name. |
| `postgres_username` | `database_username` | VectorDB Postgres user. |
| `postgres_password` | `'amazeeio_ai_database'` (Key id) | Key entity holding the DB password. |
| `api_key` | `'amazeeio_ai'` (Key id) | Key entity holding the LLM token. |

The raw LLM token is written into the `amazeeio_ai` Key entity
(`key_provider: config`, `key_value: <litellm_token>`); the DB password into `amazeeio_ai_database`.

## Config object — `ai_provider_amazeeio.settings`

`config/install/ai_provider_amazeeio.settings.yml`, schema `config/schema/ai_provider_amazeeio.schema.yml`:

| Key | Default | Meaning |
|---|---|---|
| `api_key` | `'amazeeio_ai'` | Machine name of the Key entity holding the amazee.ai LLM token. |
| `amazee_host` | `'https://api.amazee.ai'` | amazee.ai **management/trial** API host (auth, key provisioning). |
| `host` | `'https://api.amazee.ai'` | The **LLM gateway** endpoint used for chat/embeddings (overwritten on connect with the key's `litellm_api_url`). Read in `loadClient()` / `getEndpoint()`. |
| `moderation` | `false` | Run a moderation request before each request. |
| `postgres_host` | `''` | VectorDB Postgres host. |
| `postgres_port` | `5432` | VectorDB Postgres port. |
| `postgres_default_database` | `''` | VectorDB database name. |
| `postgres_username` | `''` | VectorDB Postgres user. |
| `postgres_password` | `'amazeeio_ai_database'` | Key id holding the VectorDB password. |
| `redirect_on_login` | *(unset; schema bool)* | If enabled, redirect an admin to this settings page on login until the provider is configured. |

Settings are a config object, so they export/deploy with `drush config:export`. You can edit
them directly, e.g. point at a self-hosted gateway:
`drush cset ai_provider_amazeeio.settings host https://my-litellm.example.com -y`.

## Key entities (auto-created on install)

Two Key entities ship in `config/install` and are created when the module is enabled:

- `amazeeio_ai` — "amazee.ai AI API Key" (LLM token). `key_type: authentication`,
  `key_provider: config`.
- `amazeeio_ai_database` — "amazee.ai AI Database Key" (VectorDB password).

Manage them at `/admin/config/system/keys`. Because they use the `config` provider, the
provisioned secrets live in config storage — swap to an `env`/`file` provider if you want the
secret out of the config export.

## Default models seeded on setup (`getSetupData()`)

When a key is connected, `getSetupData()` reports `key_config_name = 'api_key'` and seeds AI
Core default provider/model ids **only if that operation type has no provider yet**
(`ai.provider` → `defaultIfNone`). Seeds `chat`, `chat_with_tools`,
`chat_with_structured_response`, `chat_with_complex_json` (and `chat_with_image_vision` when
the gateway reports vision support) to the model `chat`, and `embeddings` to `embeddings`
(the gateway exposes generic model ids). If the live models list can't be fetched, nothing is
seeded.

## Make amazee.ai the site-wide default provider

Choose the provider/model per operation type at AI Core's own settings form
`ai.settings_form` → `/admin/config/ai/settings` (stored in `ai.settings`
`default_providers`). The seeding above pre-fills these; change them there or with
`drush cset ai.settings default_providers.chat.provider_id amazeeio`.

## Non-interactive provisioning (recipes)

The module ships a `ConfigAction` plugin `EnsureAmazeeAiAccess`
(`Plugin/ConfigAction/EnsureAmazeeAiAccess.php`, action id `ensureAmazeeAiAccess`) so a recipe
can provision trial access to the `amazeeio_ai` Key without walking the form.
