# Configuration

Setting up Prompt has three parts: enter your provider's API key, create a prompt
entity, and (optionally) attach its output to fields via an action.

## 1. Enter the provider API key

Each provider submodule has its own settings form where you enter its API key. For
ChatGPT, go to `/admin/config/system/prompt/chatgpt` (permission: **Administer
ChatGPT settings**) and paste your OpenAI **secret key**. The GPT-3 and Gladia
submodules have equivalent forms.

### ⚠️ A serious caution about the API key

Prompt stores provider API keys as **ordinary textfields in plain module config**
(for example, `prompt_chatgpt.settings:secret_key`). That has two consequences you
must plan for:

- **The key is exportable with your configuration.** If you run
  `drush config:export` (or use a config-sync workflow), the secret ends up in
  your exported YAML in plain text. Treat every config export as
  **secret-bearing**: never commit it to a public repository.
- To keep the key out of version control, **exclude it from config export** — for
  example with the [Config Ignore](https://www.drupal.org/project/config_ignore)
  or [Config Split](https://www.drupal.org/project/config_split) module — so the
  live value is not written to your synced config files.

This module does **not** integrate with the Key module or read the key from an
environment variable, so the plain-config storage is unavoidable — the mitigation
is to keep the exported config secret. (This limitation is one more reason to
prefer the actively-maintained [AI module](https://www.drupal.org/project/ai),
which supports Key-based secret storage.)

## 2. Create a prompt entity

Go to **Configuration → System → Prompt** (`/admin/config/system/prompt`,
permission **Administer prompt configuration**) and add a prompt. A prompt holds:

- A **role/system message** and a **user prompt template**. The template is
  **token-enabled**, so you can insert entity field values (for example the body
  of the node being processed) with tokens.
- The **provider** to send it to and the **model** string (for example a
  `gpt-3.5`/`gpt-4` model for ChatGPT).

You can **test** a prompt on its own page (`/admin/config/system/prompt/[id]`), and
**enable** or **disable** a prompt entity without deleting it so it appears (or
not) in action pipelines.

## 3. Apply the output to fields

The **Prompt: set field value** action runs a prompt and writes the result to a
target entity field. Attach it to **Views Bulk Operations** or another action
flow, or trigger it from the **ECA** module on an event such as saving an entity —
that is how you automate "summarise this field into that field" or "generate a
title from the body" without writing code.

## Things to keep in mind

- **Cost:** there is no usage metering or rate limiting — each prompt run incurs a
  third-party API call, and OpenAI's API is paid. Watch your usage.
- **Stability:** the module is not a stable release; the Gladia API in particular
  is alpha and changes can break functionality. Use with care in production.
- **Access:** admin config routes are permission-gated with no anonymous access —
  restrict **Administer prompt configuration** and the provider settings
  permissions to trusted roles.
