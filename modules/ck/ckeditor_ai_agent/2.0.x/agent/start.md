<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor AI Agent (ckeditor_ai_agent) — agent index

AI generation inside CKEditor 5, proxied server-side through the **AI** module's
configured provider. Version **2.0.0**. Core `^10.3 || ^11`, PHP `8.1+`.
Depends on `ai:ai` and `drupal:ckeditor5`. Configure at
`/admin/config/content/ckeditor-ai-agent`.

## Mechanism (verified from source)

- The CKEditor 5 plugin (`js/…/aiagent`, PHP wrapper `Plugin/CKEditor5Plugin/AiAgent`)
  runs in the browser. Its JS `AIApi.fetchAI()` (`js/…/util/ai-api.js`) POSTs to a
  **same-origin Drupal route**, not to any LLM host. The `Authorization: Bearer`
  header it sends carries an **empty** `apiKey` — no credential is ever placed in
  `drupalSettings` or the page.
- Server route `ckeditor_ai_agent.ai_chat` → `Controller/AiChatController::chat`
  (`/ckeditor-ai-agent/ai/chat`). It decodes the messages and calls the **AI module**
  (`@ai.provider`) default chat provider server-side, streaming the reply back as SSE
  (`StreamedResponse`). The provider's API key lives in the AI module / a Key entity,
  never client-side.
- `getDynamicPluginConfig()` returns `[]` when the current user lacks
  `use ckeditor ai agent`, so the AI controls are not even emitted for unprivileged users.
- The endpoint URL handed to the JS is a **fixed Drupal route** built by
  `ProxyEndpointUrlTrait::getTokenizedProxyEndpointUrl()` (route + per-session CSRF
  `?token=`). It is not admin-configurable — no arbitrary-URL / SSRF surface. Legacy
  direct-API config (`apiKey`, `endpointUrl`, `model`, `moderationKey`, …) was removed
  by update hook `9005`.

## Endpoint & access control

`/ckeditor-ai-agent/ai/chat` — `methods: [POST]`, `_permission: 'use ckeditor ai agent'`,
`_csrf_token: 'TRUE'`. **Cite this as well built:** POST-only, permission-gated, and
CSRF-protected (rare among AI proxies). A client-supplied `model` is validated with
`preg_match('~^[a-zA-Z0-9._:/-]+$~')` and only overrides the configured default; message
`role` is restricted to `system|user|assistant`. Access control is covered by a
functional test (`tests/src/Functional/AiChatProxyAccessTest.php`).

**The exposure is cost, not compromise.** Any holder of `use ckeditor ai agent` can send
arbitrary prompts through the site's provider account and pick a more expensive model than
the default. Nothing here rate-limits or budgets — grant deliberately and use provider-side
spend limits.

## Permissions

- `administer ckeditor ai agent` — global settings; **`restrict access: true`**.
- `use ckeditor ai agent` — required to reach the proxy endpoint and to see the editor
  controls. Grant to editorial roles.

## Key classes / files

- `src/Controller/AiChatController.php` — the server proxy to the AI module.
- `src/Plugin/CKEditor5Plugin/AiAgent.php` — CKEditor 5 plugin config + per-editor settings.
- `src/AiAgentConfigurationManager.php` — builds JS config, taxonomy tones/commands,
  `checkAiProvider()` (used by `hook_requirements` and the settings form status panel).
- `src/Form/AiAgentSettingsForm.php` + `Form/AiAgentFormTrait.php` — global settings form.
- `src/ProxyEndpointUrlTrait.php` — tokenized route URL builder.
- `js/ckeditor5_plugins/aiagent/src/util/ai-output-filter.js` — client-side output
  sanitizer (strips non-allowlisted tags, blocks `javascript:`/`data:`/off-domain URLs;
  anti-exfiltration, EchoLeak/CVE-2025-32711 style).

## Sub-docs

- `config/settings.md` — provider setup, global settings form, taxonomy vocabularies,
  prompt overrides, output-security domains, per-text-format enablement.
- `editor/using.md` — how editors invoke it (slash commands, toolbar buttons, keyboard
  shortcuts, streaming, URL/RAG references).
