<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Azure OpenAI Augmentor (augmentor_azure_openai) — agent index

Provider module for the **Augmentor** framework: registers two Augmentor plugins that call the **Azure OpenAI API** through `openai-php/client`. Version 1.0.0-beta3. Core `^9.3 || ^10 || ^11`.

- **Requires:** `augmentor:augmentor` (base framework) and the `openai-php/client` composer lib. API keys use the Key module (via Augmentor's base form).
- **Ships:** no routes, no permissions, no services, no config schema, no submodules. Configuration and the augmentor list live in the base `augmentor` module (`webservices > augmentors`, permission *Administer augmentors*).
- **Plugins provided** (`@Augmentor`):
  - `azure_openai_chat` — chat endpoint, conversational response. Class `AzureOpenAIChat`.
  - `azure_openai_completions` — completions endpoint, text completion. Class `AzureOpenAICompletions`.
- **Base class:** `AzureOpenAIBase` (extends `augmentor`'s `AugmentorBase`) — adds `base_url`, `api_version`, `prompt` config + `getClient()` + static `prepareText()`.

## Solution docs
- [plugins/chat-and-completions.md](plugins/chat-and-completions.md) — the two plugins: config keys, `execute()` flow, options, output shape.
- [config/settings.md](config/settings.md) — how an augmentor is configured (Key, base URL, API version, prompt, advanced) and how the Azure client is built.
