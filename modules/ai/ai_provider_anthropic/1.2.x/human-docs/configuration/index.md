# Configuration

Getting Claude working is a short chain: create a Key that holds your Anthropic
API key, select it on the provider's settings form, decide how to handle
moderation, and then tell AI Core to use Anthropic as its default provider.

## Open the settings form

1. Log in as a user with the **Administer AI providers** permission (this
   permission is defined by AI Core, not this module).
2. Go to **Configuration → AI → AI Providers → Anthropic Authentication**, or
   navigate directly to `/admin/config/ai/providers/anthropic`.

The settings are saved to the exportable `ai_provider_anthropic.settings` config
object.

## The form fields

### Anthropic API Key

A **Key** selector. Choose the Key entity that holds your Anthropic API key (get a
key at `https://console.anthropic.com/settings/keys`; create the Key entity first
if you haven't — see [Installation](../installation/index.md)). Only the Key's
machine name is stored in configuration — never the raw key.

### Enable OpenAI Moderation

A checkbox. Anthropic has **no native moderation endpoint**, so if you want prompts
screened before they run, this option routes each Anthropic prompt through
OpenAI's moderation first. It is only selectable when the **OpenAI provider**
(`ai_provider_openai`) is enabled and usable **and** the **AI External
Moderation** module (`ai_external_moderation`) is enabled. When you save it on, the
module wires an entry into the external‑moderation settings that runs Anthropic's
prompts through OpenAI's moderation model; saving it off removes that entry.

### No Moderation Needed

A checkbox acknowledgement. If OpenAI moderation is *off*, you must tick this to
confirm you understand that running Anthropic without moderation risks getting the
account banned — **the form will not save otherwise**.

That's the whole form. There is no field on it for the API host, model, or
version — those are config‑only (see below).

## Config‑only settings (no form field)

These live in `ai_provider_anthropic.settings` and are edited with Drush if you
need them:

- **`host`** — override the API endpoint to route through a proxy or an
  Anthropic‑compatible host. Empty means the default
  `https://api.anthropic.com/v1`. Set with
  `drush cset ai_provider_anthropic.settings host <host>`.
- **`models_cache_ttl`** — how long (in seconds) to cache the fetched model list.
  Defaults to 86400 (24 hours) when unset.
- **`version`** — the Anthropic API version stored in config (default `20240229`).

## Default models seeded when you save the key

When you save your key, the module seeds AI Core defaults — but **only for
operation types that don't already have a provider**. Model ids are resolved from
the live model list, falling back to pinned ids:

| Operation type | Default Claude model |
|----------------|----------------------|
| Chat, chat with image vision | Claude Sonnet 4.5 (`claude-sonnet-4-5-20250929`) |
| Chat with complex JSON, chat with tools, chat with structured response | Claude Opus 4.5 (`claude-opus-4-5-20251101`) |

Because the model list is fetched live from Anthropic and cached, newly released
Claude models appear in the selects automatically.

## Make Anthropic the site‑wide default

Choosing the provider per operation type happens on **AI Core's** own settings
form, not this one:

1. Go to **Configuration → AI → Settings** (`/admin/config/ai/settings`).
2. For each operation type (chat, and so on), select **Anthropic** and the Claude
   model you want. The seeding above pre‑fills these, so you may only need to
   confirm them.

You can also set a default from the command line, for example:

```bash
drush cset ai.settings default_providers.chat.provider_id anthropic -y
```

## Per‑model tuning

Chat settings such as **max_tokens** (default 4096), **temperature**, **top_p**,
and **top_k** are tuned per model on the AI settings UI. Note that for Claude 4.x
and newer models the provider automatically drops `top_p`, because Anthropic's API
rejects sending `temperature` and `top_p` together — so don't rely on setting both
for those models. Low‑credit errors from Anthropic surface as a typed quota
exception so your site can handle them gracefully.
