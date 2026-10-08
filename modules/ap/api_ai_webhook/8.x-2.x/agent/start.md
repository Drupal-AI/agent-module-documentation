<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# api_ai_webhook (Dialogflow Webhook)

Dialogflow fulfilment webhook that dispatches a Symfony event.

- Route `api_ai_webhook.callback` POST `/api.ai/webhook`, custom auth provider `api_ai_webhook_auth` (`ApiAiAuth`), `_permission: access content`.
- Auth modes: `none` (DEFAULT — anonymous!), `basic` (HMAC of pw vs state), `headers`. Flood-limited by IP.
- Controller `ApiAiEndpointController::callback` decodes JSON, dispatches `ApiAiEvent`; you subscribe to build the response.
- Config form at `/admin/config/service/api_ai_webhook`. Submodule `chatbot_api_apiai` bridges Chatbot API.
- SECURITY: default `auth.type = none` means the endpoint is open; core module does no AI/outbound calls itself.

See [../usage.md](../usage.md).
