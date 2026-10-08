<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Lead Chatbot (ai_lead_chatbot) — agent index

An OpenAI-backed chat widget that converses with site visitors, extracts lead details
(service interest, name, phone/email), and stores completed leads as `chatbot_lead`
content entities. Package *Artificial Intelligence (AI)*. Core `^11`. License
GPL-2.0-or-later. Version `1.0.0-rc12`. Depends only on core `system` and `user`.

- **Configuration form, config object, schema keys, and the OpenAI key** →
  [config/settings.md](config/settings.md)
- **The `chatbot_lead` entity, its fields, list builder, and admin routes/permissions** →
  [entities/chatbot_lead.md](entities/chatbot_lead.md)
- **The chat endpoints, controller, service, widget block, and OpenAI call flow** →
  [api/chat.md](api/chat.md)

## What it provides (from source)

- **Content entity** `chatbot_lead` (`src/Entity/ChatbotLead.php`), base table `chatbot_lead`,
  fields `name`, `contact`, `service`, `session_id`, `created`; list builder
  `ChatbotLeadListBuilder`; admin route provider. `admin_permission = "manage chatbot leads"`.
- **Service** `ai_lead_chatbot.chatbot_service` (`ChatbotService`) — builds the system prompt,
  calls OpenAI, tracks per-session state in private tempstore, and saves leads.
- **Controller** `ChatbotController` — `start()` returns a greeting, `chat()` processes a
  POSTed message and returns the bot reply as JSON.
- **Block** `ai_lead_chatbot_widget` (`ChatbotWidgetBlock`) — attaches the widget library.
- **Config form** `ChatbotConfigForm` writing config object `ai_lead_chatbot.settings`
  (schema in `config/schema/ai_lead_chatbot.schema.yml`).
- **Library** `ai_lead_chatbot/chatbot_widget` (`js/chatbot-widget.js`, `css/chatbot-widget.css`);
  auto-attached to non-admin pages by `hook_page_attachments()` when `enable_widget` is on.
- **Permissions** (`ai_lead_chatbot.permissions.yml`): `administer AI Lead Chatbot`,
  `view chatbot leads`, `manage chatbot leads`.

## Routes (`ai_lead_chatbot.routing.yml`)

| Route | Path | Method | Access |
|-------|------|--------|--------|
| `ai_lead_chatbot.chat_start` | `/chat/start` | GET | open (serves widget greeting to visitors) |
| `ai_lead_chatbot.chat` | `/chat` | POST | open (serves widget messages from visitors) |
| `ai_lead_chatbot.config` | `/admin/config/services/ai-lead-chatbot` | — | `administer AI Lead Chatbot` |
| `ai_lead_chatbot.leads` | `/admin/content/ai-chatbot-leads` | — | `view chatbot leads` |

Entity routes (`AdminHtmlRouteProvider`): canonical / delete-form under
`/admin/content/chatbot-lead/{chatbot_lead}` gated by the entity `manage chatbot leads` permission.
