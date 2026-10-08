# Configuration

Setting up the Azure provider is a two-part job: first store your Azure API key as
a **Key** entity, then add one or more **models** on the Azure setup form.

## Step 1 — store the Azure API key securely

The Key module lets you keep the actual secret out of your configuration and out
of version control. The recommended approach is to put the key in an environment
variable and reference it from a Key entity.

With DDEV, save the value into the container's environment:

```bash
ddev dotenv set .ddev/.env --azure-api-key=<your-azure-key>
ddev restart
```

(The flag `--azure-api-key` becomes the environment variable `AZURE_API_KEY`;
never commit `.ddev/.env`.) Then create an environment-backed Key entity:

```bash
drush key:save azure_api_key --label='Azure AI API Key' --key-type=authentication \
  --key-provider=env --key-provider-settings='{"env_variable":"AZURE_API_KEY"}' \
  --key-input=none -y
```

You can also create a Key through the UI at **Configuration → System → Keys**
using any provider whose value returns your API key.

## Step 2 — open the setup form

1. Log in as a user with the **Administer AI providers** permission.
2. Go to **Configuration → AI → Providers → Azure**, or navigate directly to
   `/admin/config/ai/providers/azure` ("Setup Azure Models").

## Step 3 — add a model

Because Azure has no predefined models, you register each one yourself. Pick an
operation type and add a model with these fields:

- **Endpoint** — the Azure **Target URI** for that deployment (the URL ending in
  `.../completions`, `.../embeddings`, and so on). The module parses the base URL
  and query parameters from this. Required.
- **Key** — the **Key** entity that holds the API key (the one you created in
  step 1). Required.
- **Type of model** (the connect header) — how the request authenticates:
  - **api-key** — the OpenAI-style `api-key` header (the usual Azure choice).
  - **authorization** — a generic `Authorization` header.
  - **other** — a custom header, whose name you then enter in **Custom Header**.
- **Custom Header** — only needed when the type is *other*; the header name to send
  the key under.
- **Custom Consumer** *(advanced)* — the value
  `2023-06-01-preview-extensions-chat-completion` swaps in a lightweight client for
  certain proxies. Leave blank unless you need it.
- **Extra headers** *(advanced)* — one `key:value` per line for additional HTTP
  headers (for example when routing through a gateway). These support token
  substitution.

You can add a model for each operation type you need: **chat**, **embeddings**,
**text_to_image**, **speech_to_text**, and **text_to_speech**.

## Where the settings are stored

- This module's own options live in the `ai_provider_azure.settings` config object.
- The **model definitions** themselves are stored by the AI module in
  `ai.settings` under `models.azure.*`. You can inspect them with:

  ```bash
  drush config:get ai.settings models
  ```

## Default generation parameters

Each operation type ships with sensible defaults — for chat, `max_tokens` (4096),
`temperature` (0–2), `top_p`, and the penalty parameters; for text-to-image, the
number of images and size (256 / 512 / 1024); for text-to-speech, the voice
(alloy, echo, fable, onyx, nova, shimmer) and response format; and for
speech-to-text, language, prompt, format and temperature. These act as the
starting values the AI module uses when it calls Azure.

## Using Azure across the site

Once a model is configured you can make Azure the default provider for a given AI
operation type in the AI module's settings, or select it explicitly wherever a
feature lets you pick a provider — chat, embeddings for search/RAG, image
generation, and audio.
