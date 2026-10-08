<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `chatbot_lead` content entity

## Definition

`src/Entity/ChatbotLead.php` — `@ContentEntityType(id = "chatbot_lead")`, base table
`chatbot_lead`, extends `ContentEntityBase`. Handlers: core `EntityViewBuilder`,
`ChatbotLeadListBuilder` (list), `EntityViewsData` (Views integration), core content-entity
default/delete forms, core `EntityAccessControlHandler`, and `AdminHtmlRouteProvider`.
`admin_permission = "manage chatbot leads"`. Entity keys: `id`, `uuid`.

## Base fields (`baseFieldDefinitions()`)

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `name` | string (max 255) | yes | Lead's name. Display + form configurable. |
| `contact` | string (max 255) | yes | Email or phone. |
| `service` | string (max 255) | yes | Service the lead asked about. |
| `session_id` | string (max 255) | no | Chat session id the lead came from. View-only display. |
| `created` | created | — | Timestamp set on creation. |

Values are written by `ChatbotService::saveLead()` (`create([...])->save()`) using the
model-extracted `name` / `contact` / `service` plus the request `session_id`. A lead is only
saved when all three of service, name, and contact are present and the conversation is marked
complete.

## Routes & permissions

- **Collection list**: route `ai_lead_chatbot.leads`, path `/admin/content/ai-chatbot-leads`
  (`_entity_list: 'chatbot_lead'`), permission `view chatbot leads`. Also linked from the
  entity annotation `links.collection` and a local task/menu link under Content.
- **Canonical / delete**: `/admin/content/chatbot-lead/{chatbot_lead}` and
  `/admin/content/chatbot-lead/{chatbot_lead}/delete`, provided by `AdminHtmlRouteProvider`,
  gated by the entity `admin_permission` = `manage chatbot leads`.

## List builder

`ChatbotLeadListBuilder` (`src/Entity/ChatbotLeadListBuilder.php`) adds columns ID, Name,
Contact, Service, Created (formatted with `date.formatter` `short`). Row cells are plain
render-array string values (`$entity->get('name')->value`, etc.), which core's table theme
escapes on output.

## Permissions (`ai_lead_chatbot.permissions.yml`)

- `administer AI Lead Chatbot` — configure the module (`restrict access: true`).
- `view chatbot leads` — access the leads collection list.
- `manage chatbot leads` — create/edit/delete lead entities (the entity `admin_permission`).

Because leads are a content entity with `EntityViewsData`, they can be surfaced in custom
Views for reporting/export.
