# Configuration

Configuring OpenAI Provider is mostly about **authentication**: you create a Key
holding your OpenAI API key, select it on the provider's settings form, and
(optionally) choose OpenAI as the default provider for each AI operation. There
are only a couple of settings, but the Key step matters — the API key is never
stored in plain configuration.

## Step 1 — Create a Key for your API key

Because this module uses the **Key** module, your OpenAI API key lives in a Key
entity rather than in config. Create it first. The most secure approach keeps the
secret in an environment variable and out of version control:

```bash
drush key:save openai_api_key \
  --label='OpenAI API Key' \
  --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"OPENAI_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

You can also create a Key through the UI at **Configuration → System → Keys**
(`/admin/config/system/keys`) and paste the value there. Either way, the result is
a Key entity you'll select on the form below.

## Step 2 — Fill in the settings form

1. Log in as a user with the **Administer AI providers** permission (this
   permission is defined by AI Core).
2. Go to **Configuration → AI → AI Providers → OpenAI Authentication**, or
   navigate directly to `/admin/config/ai/providers/openai`.

The form has one required field:

- **OpenAI API Key** — a **Key** selector. Choose the Key entity you created in
  Step 1. Only the Key's id is saved in config, never the raw key.

There's also an advanced note about **moderation**: text‑based calls are run
through OpenAI's moderation model by default, and the setting stays on unless you
change it (see below).

When you **save**, the module does two useful things: it resolves your Key and
calls OpenAI to verify the credentials actually work (a live connectivity/credit
check), and it warns you if the key is only on the free tier or out of quota. It
then seeds AI Core's default provider→model map for any operation type that
doesn't already have a provider.

## Step 3 — (Optional) Set a custom host for Azure / compatible endpoints

To use an **Azure OpenAI** deployment or an **OpenAI‑compatible** service (LocalAI,
LM Studio, etc.), set the `host` value. The settings form has no host field, so
set it with Drush:

```bash
drush cset ai_provider_openai.settings host <your-host>
```

Leave it empty to use the standard `api.openai.com/v1`.

## Moderation

The `moderation` setting is **on by default**. With it on, every text‑based call
is first checked against `omni-moderation-latest`, and a flagged prompt is
rejected with an "unsafe prompt" exception. You can:

- Bypass it for a single trusted call in code (using the `skip_moderation` tag),
  or
- Turn it off globally by editing the `moderation` value in config, e.g.
  `drush cset ai_provider_openai.settings moderation 0`.

## Default models seeded on setup

When your key is saved, these AI Core defaults are set **only if that operation
type has no provider yet**:

| Operation type | Default model |
|----------------|---------------|
| chat (and vision / JSON / tools / structured variants) | `gpt-5.2` |
| text_to_image | `gpt-image-1` |
| embeddings | `text-embedding-3-small` |
| moderation | `omni-moderation-latest` |
| text_to_speech | `tts-1-hd` |
| speech_to_text | `whisper-1` |

## Step 4 — Make OpenAI the default provider

Choosing which provider and model handles each operation happens on **AI Core's**
own settings form, not here: **Configuration → AI → AI settings**
(`/admin/config/ai/settings`). The seeding above pre‑fills these, but you can
change any of them there, or with Drush, for example:

```bash
drush cset ai.settings default_providers.chat.provider_id openai
```

All of these settings are configuration objects, so they export and deploy with
`drush config:export`.
