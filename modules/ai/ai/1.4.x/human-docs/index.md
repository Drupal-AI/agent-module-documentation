# AI Core — manual setup guide

**AI Core** (`ai`) is the foundation module of Drupal's AI ecosystem. It is a
**provider‑agnostic abstraction layer**: it lets Drupal code call large‑language‑
model and other AI services through one stable API, regardless of which vendor
(OpenAI, Anthropic, Ollama, Mistral, and so on) actually serves the request.
Crucially, AI Core does **not** talk to any AI vendor by itself — it defines the
contracts and plumbing, and each vendor is added by installing a separate
*provider* module. You must install at least one provider module before anything
will actually run.

The core mental model is simple: a **provider** implements one or more **operation
types** — standardized capabilities such as `chat`, `embeddings`, `text_to_image`,
`moderation`, `translate_text`, `speech_to_text`, and more. Application code asks
the central `ai.provider` service for the site's configured default provider and
model for an operation, passes a typed input object, calls the operation, and reads
a normalized output. Because the vendor is a configuration choice, swapping from
one to another is a config change, not a code change.

On top of that, AI Core provides a lot of shared machinery: **function calling**
(letting the model invoke Drupal tools), **guardrails** (reusable pre/post‑
processing policy applied to requests), reusable **prompt** entities, a
vector‑database provider abstraction (used by AI Search), a tokenizer and text
chunker, an `ai_file` entity for AI‑generated files, and events for observing and
altering every request. **API keys are stored through the required Key module**,
never in configuration or `settings.php`. AI Core is the base dependency for the
whole AI ecosystem — ai_agents, ai_search, ai_assistant_api, ai_ckeditor, and many
others — and it ships a large set of its own submodules that layer concrete
features on top.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install AI Core and its dependencies,
   enable it, add a provider module, and store your API key with the Key module.
2. [Configuration](configuration/index.md) — the main settings form, per‑provider
   configuration, default provider/model per operation, guardrails and prompts, and
   permissions.

## Where it lives in the admin menu

The main settings form is at **Configuration → AI → Settings**
(`/admin/config/ai/settings`, route `ai.settings_form`), gated by the **Administer
ai** permission. Per‑provider settings — where you select the Key and default
models — live at **Configuration → AI → Providers** (`/admin/config/ai/providers`),
gated by **Administer ai providers**.

## How to use it

1. Install AI Core, at least one **provider module** (for example
   `ai_provider_openai`), and the **Key** module (see
   [Installation](installation/index.md)).
2. Store your vendor API key as a **Key entity** — never in config.
3. On the provider's settings form, select that Key and choose default models.
4. On the AI settings form, set the **default provider and model per operation
   type** (for example a strong model for chat, a cheaper one for summarization).
5. Optionally add guardrails, reusable prompts, host allow‑lists, and enable only
   the submodules you need. See [Configuration](configuration/index.md).
