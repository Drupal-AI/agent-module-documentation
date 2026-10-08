<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings form & config object

## Install / enable

`drush en ai_lead_chatbot`. No composer requirements beyond core `^11`; depends on core
`system` and `user`. Install defaults ship in `config/install/ai_lead_chatbot.settings.yml`.

## OpenAI API key (settings.php, not config)

The key is **not** stored in config. `ChatbotService::callOpenAi()` reads it with
`Settings::get('ai_lead_chatbot_openai_api_key')` (`src/Service/ChatbotService.php:225`).
Set it in `settings.php`:

```php
$settings['ai_lead_chatbot_openai_api_key'] = 'sk-...';
```

If unset, `callOpenAi()` logs an error and returns NULL, and the chat replies with a generic
"having trouble processing your message" fallback.

## Config form

`ChatbotConfigForm` (`src/Form/ChatbotConfigForm.php`), route `ai_lead_chatbot.config` at
`/admin/config/services/ai-lead-chatbot`, permission `administer AI Lead Chatbot`
(`restrict access: true`). Menu link under Configuration → Services (`links.menu.yml`).
Editable config object: `ai_lead_chatbot.settings`.

## Config keys (`config/schema/ai_lead_chatbot.schema.yml`)

| Key | Type | Default (install yml) | Meaning |
|-----|------|-----------------------|---------|
| `business_name` | string | `Your Business` | Injected into greeting and system prompt. |
| `tone` | string | `friendly` | One of friendly / professional / casual / formal; sets prompt tone. |
| `faq` | text | 3 sample Q lines | FAQ knowledge base; `Question? \| Answer` per line (pipe-separated). Lines without a `\|` are treated as a question with no answer. |
| `openai_model` | string | `gpt-4o-mini` | Model passed to the completions API. |
| `openai_temperature` | float | `0.7` | Sampling temperature (form range 0–2). |
| `openai_max_tokens` | integer | `150` | Response length cap (form range 50–1000; code default fallback 200). |
| `enable_widget` | boolean | `true` | Auto-attach the widget to non-admin pages. |

Note: install default `openai_max_tokens` is `150`, but `ChatbotConfigForm` shows a default of
`150` while `callOpenAi()` falls back to `200` only when the key is entirely unset.

## Widget attachment

`hook_page_attachments()` (`ai_lead_chatbot.module`) attaches library
`ai_lead_chatbot/chatbot_widget` on every route that is **not** admin and does not start with
`system.`, but only when `enable_widget` is TRUE. Independently, placing the
`ai_lead_chatbot_widget` block (`ChatbotWidgetBlock`) always attaches the library where the
block renders, regardless of `enable_widget`.

## FAQ formatting into the prompt

`callOpenAi()` splits `faq` on newlines; a line containing `|` is emitted as `Q: … / A: …`,
otherwise as a question with an "[No answer provided…]" instruction. The assembled system
prompt also embeds `business_name`, `tone`, and the running lead state, and instructs the
model to reply as a JSON object `{message, extracted:{service,name,contact}, complete}`.
