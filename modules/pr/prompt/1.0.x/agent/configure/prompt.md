<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Prompt

## Setup
1. Enable `prompt` plus one provider submodule (`prompt_chatgpt`, `prompt_gpt3`, or `prompt_gladia`).
2. Enter the provider API key on its settings form, e.g. ChatGPT at `/admin/config/system/prompt/chatgpt` (config key `prompt_chatgpt.settings:secret_key`, permission `administer ChatGPT settings`).
3. Create a `prompt` config entity at `/admin/config/system/prompt` (permission `administer prompt configuration`).

## Prompt entity
- Holds a role/system message, a user prompt template (token-enabled), a provider id, and a model string.
- `Drupal\prompt\Service::prompt_request($prompt_id, $entity, $debug)` assembles and sends the request; `prompt_chunk_text()` splits long input to respect model length limits.

## Applying output
- The `PromptSetFieldValue` action (`src/Plugin/Action/PromptSetFieldValue.php`) runs a prompt and writes the result to a target field — attach it to Views Bulk Operations or other action flows.

## Providers
- `prompt_chatgpt` → `https://api.openai.com/v1/chat/completions` (Bearer key).
- `prompt_gpt3` → `https://api.openai.com/v1/completions`.
- `prompt_gladia` → `https://api.gladia.io/...` text & audio endpoints.

## Cautions
- API keys live in exportable plaintext config — treat config exports as secret-bearing.
- No usage metering: each run incurs third-party API cost.
