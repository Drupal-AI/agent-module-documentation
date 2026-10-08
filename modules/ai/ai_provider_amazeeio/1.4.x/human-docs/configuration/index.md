# Configuration

Unlike most AI providers, amazee.ai doesn't ask you to paste an API key. Its
settings form is a short **connect / signup flow** that talks to amazee.ai's
management API, provisions your credentials, and stores them in **Key** entities for
you.

## Open the settings form

1. Log in as a user with the **Administer AI providers** permission.
2. Go to **Configuration → AI → AI Providers → amazee.ai**
   (`/admin/config/ai/providers/amazeeio`).

## The connect flow

The form is a small state machine — you'll move through these steps:

1. **Email** — enter an email address. amazee.ai emails you a verification code (or
   starts an anonymous free trial automatically).
2. **Verify** — enter the code you received. A temporary access token is held in
   your session while you finish.
3. **Select or create a private key** — pick an existing amazee.ai private API key,
   or enter a name and **region** to create a new one. The region is where your AI
   workloads and data will be processed (Germany, UK, Switzerland, US, Australia,
   and others on request) — choose it according to your data-sovereignty needs.
4. **Connect** — the module writes its configuration and creates the Key entities,
   provisions a management token, and seeds the AI module's default model choices.

On connect, the module fills in the LLM gateway endpoint and the vector-database
(Postgres) connection details from the key you chose, and stores the secrets in Key
entities rather than in plain configuration.

## The connected dashboard

Once connected, the settings page becomes a **dashboard** instead of the signup
steps. It shows the host health, the LiteLLM version, your key info, and the live
list of available models (for non-trial accounts it also shows your team and key
name). Three buttons let you manage the connection:

- **Disconnect** — clears the configuration and deletes the three Key entities
  (after a confirmation step).
- **Check Health** — re-checks the gateway (busting a short cache).
- **Refresh Models** — re-fetches the available model list.

Trial accounts see a notice inviting an upgrade.

## The Key entities it creates

The module manages its secrets through Key entities, which you can see at
**Configuration → System → Keys** (`/admin/config/system/keys`):

- **amazee.ai AI API Key** (`amazeeio_ai`) — the LLM token.
- **amazee.ai AI Database Key** (`amazeeio_ai_database`) — the vector-database
  (Postgres) password.
- **amazee.ai Management Token** (`amazeeio_ai_management_token`) — created
  dynamically on connect, for dashboard/account calls.

By default these use the **config** key provider, meaning the provisioned secrets
live in config storage. If you want the secrets kept out of your configuration
export, switch a Key to an `env` or `file` provider after connecting. (The module
also integrates with `config_ignore`, when installed, to keep the environment-
specific and secret values from moving between environments.)

## Advanced config keys

The connection details are stored in the `ai_provider_amazeeio.settings` config
object and export with `drush config:export`. Most are set for you on connect, but
you can edit them directly — for example to point at a self-hosted LiteLLM gateway:

```bash
drush cset ai_provider_amazeeio.settings host https://my-litellm.example.com -y
```

Other keys include the amazee.ai management host (`amazee_host`), the Postgres
vector-database connection (`postgres_host`, `postgres_port`,
`postgres_default_database`, `postgres_username`), an optional pre-request
`moderation` toggle, and `redirect_on_login` (nudge an admin to this page on login
until the provider is configured).

## Make amazee.ai your default AI provider

Connecting seeds the AI module's defaults automatically (for chat, embeddings,
translation, and — if the gateway supports it — vision and text-to-image). To
review or change which provider/model is used per operation type, go to the AI
module's own settings at **Configuration → AI → Settings**
(`/admin/config/ai/settings`), or set it via Drush, e.g.
`drush cset ai.settings default_providers.chat.provider_id amazeeio`.

## A note on cost

amazee.ai is free for the first 30 days and a **paid, metered subscription**
thereafter. Every chat, embedding, image-generation, and translation request
consumes your allowance, so bear ongoing cost in mind when you wire it into
automated or high-volume features.

## Non-interactive setup (recipes)

For automated installs, the module ships a config action
(`ensureAmazeeAiAccess`) that a recipe can use to provision anonymous trial access
without walking the form. Provisioning is best-effort — if the trial is at capacity
or a network error occurs, the install logs a warning and continues rather than
failing.
