# FlowDrop AI Provider — manual setup guide

**FlowDrop AI Provider** (`flowdrop_ai_provider`) is the join between **FlowDrop**,
the visual workflow editor, and Drupal's **AI** module. It lets the AI steps in a
FlowDrop workflow run through the AI module's provider abstraction rather than talking
to a vendor directly — so a workflow can use chat, embeddings, text‑to‑image,
translation, moderation, summarisation, re‑ranking, and the other operation types the
AI module supports, against whatever provider you have configured (a cloud API, a
local model, or an open‑source LLM).

That layering is the whole point, and it makes both modules better. FlowDrop never
needs to know about OpenAI, Anthropic, or any specific model — the **AI** module holds
the credential, the provider choice, and the operation types. A workflow written today
runs against a different model tomorrow just by changing configuration, and the
credential never appears in the workflow definition. That last part matters, because
FlowDrop workflow definitions are exported, versioned, and shareable as signed
bundles: keeping the secret in the AI module means you can share a workflow without
leaking a key. This module also plugs into the AI module's **Prompt**, **Guardrails**,
and **Chat Processor** systems, so reusable prompts, safety rules, and decoupled chat
execution are all available inside FlowDrop pipelines.

This is an integration module with **no settings page of its own** — you configure the
provider and its API key in the **AI** module, not here. See "Where the API key lives"
below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module
   with FlowDrop and the AI module.

There is **no configuration page** for this module. Everything provider‑related is
configured in the [AI](https://www.drupal.org/project/ai) module, and the workflows
themselves are built in the [FlowDrop](https://www.drupal.org/project/flowdrop)
editor.

## Where the API key lives

This module does not store credentials. The provider's API key is held by the **AI**
module, which reads it from a **Key** entity so the secret never sits in exported
configuration. On a DDEV site the recommended flow is:

1. Save the secret into DDEV's environment (never commit it):

   ```bash
   ddev dotenv set .ddev/.env --openai-api-key=<value>
   ddev restart
   ```

   The flag `--openai-api-key` becomes the environment variable `OPENAI_API_KEY`.
   Keep `.ddev/.env` out of version control.

2. Enable the **Key** module if it isn't already, then create a Key that reads that
   variable:

   ```bash
   ddev drush en key -y
   ddev drush key:save openai_api_key --label='OpenAI API Key' --key-type=authentication \
     --key-provider=env \
     --key-provider-settings='{"env_variable":"OPENAI_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

3. In **Configuration → AI**, choose your provider and point it at that Key.

## Cost — read this before you build

The same layering that keeps credentials out of workflows also hides cost. A workflow
can call a model in a loop, over a whole collection, or on a trigger that fires on
every entity save — and nothing in the visual editor makes that spend visible while
you are building it. A flow that looked reasonable can generate thousands of calls the
first time it runs against real data. The reliable control is a **provider‑side spend
limit**, set in your AI vendor's dashboard; watching the invoice after the fact is not.
Every AI node also sends data to the provider (egress), so be deliberate about what
content the workflow passes out.
