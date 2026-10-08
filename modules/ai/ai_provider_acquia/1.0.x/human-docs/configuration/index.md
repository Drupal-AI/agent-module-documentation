# Configuration

Configuring this provider is mostly about giving it two things — the **gateway
host** and the **API key** — as secrets, then confirming the connection on its
settings form.

## Supply the credentials (as environment variables)

Both values are read from the environment, so they stay out of exported
configuration:

- **Gateway host** — from `settings.php` (`Settings::get('acquia_ai_gateway_url')`)
  or the `AI_GATEWAY_URL` environment variable.
- **API key** — resolved through the **Key** module under the fixed key name
  `ai_provider_acquia`. A bundled resolver (`AcquiaAIEnvKeyResolver`) surfaces the
  `AI_GATEWAY_API_KEY` environment variable as that Key value, so the secret lives
  in the environment.

Acquia usually pre-provisions these values. Following this project's conventions,
set the environment variables with DDEV's dotenv command and restart so the web
container picks them up:

```bash
ddev dotenv set .ddev/.env --ai-gateway-url=<gateway-url> --ai-gateway-api-key=<api-key>
ddev restart
```

(The flags become the `AI_GATEWAY_URL` and `AI_GATEWAY_API_KEY` variables; never
commit `.ddev/.env`.) If your setup prefers an explicit Key entity, you can also
create one manually named `ai_provider_acquia` backed by the env provider.

## Open the settings form

1. Log in as a user with the **Administer AI providers** permission.
2. Go to **Configuration → AI → Providers → Acquia**
   (`/admin/config/ai/providers/acquia`).

If either the host or the key is missing, the form shows an error and nothing
actionable — so make sure both environment values are set and the container has
been restarted first.

## What the form shows and does

On load it contacts the gateway and displays your key alias, **spend**, **budget**,
and **blocked** status, plus a per-model **capability table**. On save it maps the
discovered models to AI operation types (chat, embeddings, and so on) as the
provider defaults, then returns you to the AI settings form. From there you can
fine-tune which model backs each operation.

## Security notes

The client uses Drupal's core HTTP client with **normal TLS verification** (no
disabled certificate checks) and authenticates with an `Authorization: Bearer`
header rather than a query-string secret. Keeping the key in the environment/Key
module means it is never written into configuration you export or commit.
