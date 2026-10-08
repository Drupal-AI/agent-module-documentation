<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prompt (prompt) — agent index

**Framework that stores prompts as config entities and runs them against AI providers (ChatGPT/GPT-3/Gladia) to generate content, applied to fields via an action plugin.**

- **Version:** 1.0.x (dev-1.0.x checkout)
- **Core:** ^9.3 || ^10 || ^11
- **Depends:** token
- **Submodules:** prompt_chatgpt, prompt_gpt3, prompt_gladia
- **Config entity:** `prompt` — managed at `/admin/config/system/prompt` (configure: entity.prompt.collection)
- **Routes:** `entity.prompt.enable`, `entity.prompt.disable` (permission `administer prompt configuration`); provider settings e.g. `/admin/config/system/prompt/chatgpt` (permission `administer ChatGPT settings`)
- **Action plugin:** `PromptSetFieldValue` — writes generated output to an entity field.
- **Service:** `prompt.service` (Drupal\prompt\Service).

**Security:** admin config routes are permission-gated (`restrict access: true`); no anonymous endpoints. Note: provider API keys are stored as plaintext in module config (e.g. `prompt_chatgpt.settings:secret_key`), and prompt execution calls paid third-party APIs with no built-in cost/rate limiting.

See [configure/prompt.md](configure/prompt.md)
