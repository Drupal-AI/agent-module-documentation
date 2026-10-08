# Configure the amazee.ai provider

## Settings form — `ai_provider_amazeeio.settings_form`

Route path `/admin/config/ai/providers/amazeeio` (menu: **Config → AI → AI Providers →
amazee.ai Authentication**, `ai_provider_amazeeio.settings_menu`, parent `ai.admin_providers`).
Access = permission **`administer ai providers`** (defined by AI Core, not this module). Form
class `Form\AmazeeioAiConfigForm`, config object `ai_provider_amazeeio.settings`.

Unlike most providers there is **no "paste your API key" field**. The form is a multi-step
state machine (`disconnected → validation → validated → connected`, plus `confirm_disconnect`)
that talks to amazee.ai's management API (`amazee_host`):

1. **Email** (`disconnected`) — enter an email; amazee.ai emails a verification code (or an
   anonymous free trial is started automatically).
2. **Verify** (`validation`) — enter the code; the form stores a temporary access token in
   private tempstore.
3. **Select / create a private key** (`validated`) — pick an existing amazee.ai private API key
   (tableselect of the account's keys) **or** enter a key name + region and create a new one.
4. **Connect** (`submitForm` on the `validated` state) — writes config **and** Key entities,
   creates a management token, seeds AI Core defaults, then shows the dashboard.

On connect it saves (form `submitForm()`):

| Config key | Source | Meaning |
|---|---|---|
| `host` | `litellm_api_url` of the chosen key | The LLM (LiteLLM/OpenAI-compatible) endpoint used for chat/embeddings/image calls. |
| `postgres_host` | `database_host` | VectorDB Postgres host. |
| `postgres_port` | `database_port` (default 5432) | VectorDB Postgres port. |
| `postgres_default_database` | `database_name` | VectorDB database name. |
| `postgres_username` | `database_username` | VectorDB Postgres user. |
| `postgres_password` | `'amazeeio_ai_database'` (Key id) | Key entity holding the DB password. |
| `api_key` | `'amazeeio_ai'` (Key id) | Key entity holding the LLM token. |

Secrets are written into Key entities (`key_provider: config`): the LLM token into
`amazeeio_ai`, the DB password into `amazeeio_ai_database`, and a **management token**
(created via `/auth/token`) into `amazeeio_ai_management_token`. Only Key ids are stored in
config, never the raw secrets.

### Connected dashboard

When connected, the page renders a dashboard (theme `amazeeio_ai_dashboard`) instead of the
signup steps. It calls the LLM host with the LLM key to show: host health (`GET
/health/liveliness`, expects body "I'm alive!", cached 5 min), LiteLLM version (`GET
/openapi.json`), the LLM key info (`GET /key/info`), the live model list (`GET /model/info`,
cached 5 min), and — for non-trial accounts — team + key name via the management token.
Buttons: **Disconnect** (→ `confirm_disconnect` step, then clears config + deletes all three
Keys + trial state), **Check Health** (busts the health cache), **Refresh Models** (busts the
models cache). A trial-account notice invites upgrading.

## Config object — `ai_provider_amazeeio.settings`

`config/install/ai_provider_amazeeio.settings.yml`, schema `config/schema/ai_provider_amazeeio.schema.yml`:

| Key | Default | Meaning |
|---|---|---|
| `api_key` | `'amazeeio_ai'` | Machine name of the Key entity holding the amazee.ai LLM token. |
| `amazee_host` | `'https://api.amazee.ai'` | amazee.ai **management/trial** API host (auth, key provisioning). |
| `host` | `'https://api.amazee.ai'` | The **LLM gateway** endpoint used for chat/embeddings/image (overwritten on connect with the key's `litellm_api_url`). Read in `getEndpoint()` / `loadClient()`. |
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

**config_ignore integration:** `hook_config_ignore_ignored_alter()` marks the environment-
specific / secret values as ignored so they don't move between environments: `host`,
`postgres_host`, `postgres_default_database`, `postgres_username`, the two Key `key_value`s
(when they use the `config` provider), and the AI Search server's database_name. (`config_ignore`
is a dev requirement of the module and only takes effect when installed.)

## Key entities

Two Key entities ship in `config/install` and are created when the module is enabled:

- `amazeeio_ai` — "amazee.ai AI API Key" (LLM token). `key_type: authentication`,
  `key_provider: config`.
- `amazeeio_ai_database` — "amazee.ai AI Database Key" (VectorDB password).

A third, `amazeeio_ai_management_token` ("amazee.ai Management Token"), is **created
dynamically on connect** (not shipped in config/install) and used for dashboard/account calls.
Manage them at `/admin/config/system/keys`. Because they use the `config` provider, the
provisioned secrets live in config storage — swap to an `env`/`file` provider if you want the
secret out of the config export. `hook_uninstall()` deletes `amazeeio_ai` and
`amazeeio_ai_database`; Disconnect deletes all three.

## Default models seeded on setup (`getSetupData()`)

When a key is connected, `getSetupData()` reports `key_config_name = 'api_key'` and seeds AI
Core default provider/model ids **only if that operation type has no provider yet**
(`ai.provider` → `defaultIfNone`). Seeds `chat`, `chat_with_tools`,
`chat_with_structured_response`, `chat_with_complex_json`, `translate_text` (and
`chat_with_image_vision` when the gateway reports vision support) to the model `chat`;
`embeddings` to `embeddings`; and `text_to_image` to the first image-generation-capable model.
If the live models list can't be fetched, nothing is seeded.

## Make amazee.ai the site-wide default provider

Choose the provider/model per operation type at AI Core's own settings form
`ai.settings_form` → `/admin/config/ai/settings` (stored in `ai.settings`
`default_providers`). The seeding above pre-fills these; change them there or with
`drush cset ai.settings default_providers.chat.provider_id amazeeio`.

## Non-interactive provisioning (recipes)

The module ships a `ConfigAction` plugin `EnsureAmazeeAiAccess`
(`Plugin/ConfigAction/EnsureAmazeeAiAccess.php`, action id `ensureAmazeeAiAccess`) so a recipe
can provision anonymous trial access without walking the form. Provisioning is a **fallback,
not a requirement**: any failure (trial at capacity / HTTP 429 / network / malformed payload)
is logged as a warning and the install continues.
