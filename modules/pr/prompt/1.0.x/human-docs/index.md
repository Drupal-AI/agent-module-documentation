# Prompt — manual setup guide

**Prompt** (`prompt`) is a configuration-driven framework for **generating content
by sending prompts to AI providers**. You store reusable prompt configurations as
`prompt` config entities — each holding a template (with token support), a target
provider and model, and a mapping to a destination field — and then run them to
generate content. Provider integration lives in submodules: **Prompt ChatGPT**
(OpenAI chat completions), **Prompt GPT-3** (OpenAI legacy completions), and
**Prompt Gladia** (Gladia text and audio transcription).

Typical uses include auto-categorising content, generating titles or summaries
from a body field, translating or rewriting copy, transcribing uploaded audio, and
spelling correction. It pairs well with the **ECA** module, which can trigger a
prompt on an event (such as saving an entity) and act on the result — no code
required. A `Prompt: set field value` action writes the generated output to an
entity field, so prompts can also run through Views Bulk Operations or other action
pipelines.

> **⚠️ This module is deprecated and no longer maintained.** It was created in late
> 2022, before Drupal had good AI tooling. The community's actively-maintained
> replacement is the [**AI** module](https://www.drupal.org/project/ai), which
> supports many providers (OpenAI, Anthropic, Gemini, Ollama, and more) and far
> more integrations. **Use the AI module for new projects**, and plan a migration
> if you currently rely on Prompt. No new features, bug fixes, or compatibility
> updates will be added here.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   base module plus a provider submodule.
2. [Configuration](configuration/index.md) — enter the provider API key, create a
   prompt entity, and apply its output to fields.

## Where it lives in the admin menu

Prompt entities are managed at **Configuration → System → Prompt**
(`/admin/config/system/prompt`), gated by the **Administer prompt configuration**
permission. Each provider submodule adds its own settings page — for example
ChatGPT at `/admin/config/system/prompt/chatgpt`.
