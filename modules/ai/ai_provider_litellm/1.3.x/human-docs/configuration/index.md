# Configuration

Configuring this provider is short: tell it where your LiteLLM instance is and
which key to authenticate with. Everything else — which models are offered, what
each can do — is discovered automatically from the proxy.

## Open the settings form

1. Log in as a user with the **administer ai providers** permission.
2. Go to **Configuration → AI → AI Providers → LiteLLM**
   (`/admin/config/ai/providers/ai_provider_litellm`).

The values are saved in the `ai_provider_litellm.settings` config object.

## Fields

- **API key** — select the **Key** entity that holds your LiteLLM API key (the
  form uses a key-select element). If you haven't created one yet, do so first —
  see [Installation](../installation/index.md) for the DDEV environment-variable +
  Key pattern that keeps the secret out of exported config.
- **Host** — the URL of your LiteLLM instance. It must be a valid URL **with no
  trailing slash** (for example `https://litellm.internal.example.com`). This can
  be a private or internal host.
- **Moderation** — whether moderation requests run through LiteLLM. Turn this off
  if you don't want LiteLLM's moderation applied before AI calls.

Click **Save**. On save, the module validates your credentials by listing models
against the proxy — if the host or key is wrong, the save fails with an error, so a
successful save means Drupal can talk to LiteLLM.

## What happens after saving

- **Model discovery** — the provider enumerates available models from the proxy
  (via `/model/info`, falling back to `/v1/models`). Each model's capability flags
  — chat, embeddings, image/audio in/out, moderation, function calling,
  tool-choice, response schema — determine which models are offered for each AI
  operation type, so you won't be shown a model for something it can't do.
- **Key status** — the settings form surfaces your key's alias, spend, maximum
  budget, and blocked status (pulled from LiteLLM's `/key/info`), so you can keep
  an eye on usage and per-key spend budgets defined in LiteLLM.
- **Availability** — LiteLLM now appears as a selectable provider across the AI
  module and its submodules (chat, embeddings/AI Search, translation, and so on).
  Choose it and a model wherever you configure an AI feature.

## Operations supported

Through LiteLLM you get chat (including tool/function calling, image-input vision,
and structured/JSON-schema responses on capable models), embeddings, moderation,
text-to-image, text-to-speech, and — new in 1.3.x — a `translate_text` operation
backed by a chat call. Rate-limit and budget-exceeded responses from LiteLLM are
mapped to the AI module's rate-limit and quota exceptions so your site can handle
them gracefully.
