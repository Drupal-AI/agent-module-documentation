# Configuration

Configuring amazee.ai is mostly a matter of walking through its authentication
form once. Behind the scenes it provisions your credentials, stores them in Key
entities, and records the endpoints it needs. This page covers the connect flow,
what gets stored, the vector-database settings, and how to make amazee.ai your
site default.

## The amazee.ai Authentication form

Go to **Configuration → AI → AI Providers → amazee.ai Authentication**
(`/admin/config/ai/providers/amazeeio`). Access requires the **Administer AI
providers** permission (defined by AI Core).

Unlike most providers, there is **no "paste your API key" field**. The form is a
multi-step flow that talks to amazee.ai's management API:

1. **Email** — enter your email. amazee.ai emails a verification code, or an
   anonymous free trial is started automatically.
2. **Verify** — enter the code. The form stores a temporary access token.
3. **Select or create a private key** — pick an existing amazee.ai private API
   key or create a new one.
4. **Connect** — on connect, the form provisions the credentials and writes them
   into config and into the two Key entities. AI Core is then ready to use
   amazee.ai.

On connect it records these values (in the `ai_provider_amazeeio.settings` config
object): the resolved **LLM gateway endpoint** (`host`, used for chat and
embeddings calls) and the **Postgres connection details** for the vector database
(`postgres_host`, `postgres_port`, `postgres_default_database`,
`postgres_username`). Only the Key ids are stored for the secrets — never the raw
token or password.

## The Key entities

Two Key entities are created when the module is enabled and filled in on connect:

- **`amazeeio_ai`** — "amazee.ai AI API Key", holding the LLM token.
- **`amazeeio_ai_database`** — "amazee.ai AI Database Key", holding the
  vector-database (Postgres) password.

Manage them at **Configuration → System → Keys**
(`/admin/config/system/keys`). By default they use the `config` key provider, so
the provisioned secrets live in config storage — switch a key to an `env` or
`file` provider if you want the secret kept out of your config export entirely.

## Other settings

The `ai_provider_amazeeio.settings` config object also holds:

- **`amazee_host`** (default `https://api.amazee.ai`) — the amazee.ai
  management/trial API host used for authentication and key provisioning. Point
  this at a self-hosted amazee.ai control plane if you run one.
- **`host`** — the LLM gateway endpoint (LiteLLM/OpenAI-compatible). It's set
  automatically on connect, but you can point it at a custom
  amazee.ai/LiteLLM-compatible endpoint.
- **`moderation`** (default off) — run a moderation request before each request.
- **`redirect_on_login`** — when enabled, redirect an admin to this settings page
  on login until the provider is configured.
- The Postgres vector-database host, port, database, and username shown above.

These are a normal config object, so they export and deploy with
`drush config:export`. You can also edit them directly, for example to point at a
self-hosted gateway:

```bash
drush cset ai_provider_amazeeio.settings host https://my-litellm.example.com -y
```

## Making amazee.ai the site default

When you connect a key, the module seeds AI Core's default provider/model map for
chat and embeddings — but **only for operation types that have no provider yet**,
so it won't override a provider you've already chosen. To review or change which
provider handles each operation type, go to AI Core's settings at **Configuration
→ AI → Settings** (`/admin/config/ai/settings`). For example, to force chat onto
amazee.ai from the CLI:

```bash
drush cset ai.settings default_providers.chat.provider_id amazeeio
```

## Non-interactive provisioning (recipes)

The module ships a config action, `ensureAmazeeAiAccess`, so a recipe can
provision trial access to the `amazeeio_ai` Key without a human walking through
the form — useful for automated/site-template setups.
