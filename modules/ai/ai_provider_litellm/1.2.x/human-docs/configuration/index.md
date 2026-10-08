# Configuration

Configure the provider at **Configuration → AI → Providers → LiteLLM**
(`/admin/config/ai/providers/ai_provider_litellm`), which requires the
**Administer AI providers** permission. All settings are stored in the
`ai_provider_litellm.settings` config object.

## Settings, field by field

| Field | Setting key | What it does |
|-------|-------------|--------------|
| **Host** | `host` | The base URL of your LiteLLM proxy, e.g. `https://litellm.internal`. It must be a valid URL and must **not** end in a trailing slash. |
| **API key** | `api_key` | The **machine name of a Key entity** (chosen from a key‑select dropdown), not the raw token. The actual value is resolved from the Key module at request time. |
| **Moderation** | `moderation` | On by default. When on, an OpenAI‑compatible moderation request is sent before each call. Turn it off only if LiteLLM already performs its own moderation. |

### The API key comes from a Key entity

This module never stores the raw token in its own config — it stores the *name* of
a **Key** entity and looks the value up through the Key module. Create that key
first (see [Installation](../installation/index.md#store-your-litellm-api-key-first)
for the recommended env‑backed approach), then pick it here. This keeps the secret
out of exported configuration and lets you vary it per environment.

## What happens when you save

Saving **validates the connection**: the module resolves the key, builds a client,
and lists the models from your proxy. The save is blocked if the key or host is
missing, the key doesn't work, the proxy can't be reached, or the model list comes
back empty. (One special case: a 500 response whose body begins with *"LLM Model
List not loaded in."* is treated as a warning, and the save proceeds.)

When both host and key are set, the form also shows a **Key details** table pulled
from your proxy — the key alias, key name, current spend, max budget, and whether
the key is blocked — so you can confirm you're pointed at the right key and see its
budget status at a glance.

## Models and operation types

You don't list models by hand. The provider **auto‑discovers** them from your
LiteLLM proxy and reads each model's capability flags (chat, embeddings, image and
audio input/output, moderation, and so on). Those flags decide which models are
offered for each AI operation type. The supported operation types are:

- `chat`
- `embeddings`
- `moderation`
- `text_to_image`
- `text_to_speech`
- `audio_to_audio`
- `image_and_audio_to_video`

Under the hood, LiteLLM rate‑limit / "Too Many Requests" responses are mapped to
the AI module's rate‑limit exception, and "budget has been exceeded" responses map
to its quota exception — so the AI module can handle those conditions gracefully.

## Using it

Once configured and validated, LiteLLM appears as a selectable provider wherever
the AI module lets you choose one — for chat, embeddings (for AI Search / vector
stores), moderation, image and audio generation, and the rest. Because LiteLLM
routes to the actual backing model, you can swap or load‑balance models on the
LiteLLM side without changing anything in Drupal.
