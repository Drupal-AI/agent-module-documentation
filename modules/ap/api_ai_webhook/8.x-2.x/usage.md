<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
- What: a fulfilment webhook at `/api.ai/webhook` that parses Dialogflow request JSON and dispatches an `ApiAiEvent` for modules to answer.
- When: you build a Dialogflow agent and want Drupal to power webhook fulfilment responses.

---

- Requires the `gambry/dialogflow-webhook` library (Composer); optional `chatbot_api` integration submodule `chatbot_api_apiai`.
- Configure authentication at `/admin/config/service/api_ai_webhook` (route `api_ai_webhook.api_ai_webhook_config`, `access administration pages`).

---

- Endpoint route `api_ai_webhook.callback` is POST-only, `_permission: 'access content'`, with a custom `_auth: api_ai_webhook_auth` provider.
- Auth provider `ApiAiAuth` supports three modes selected in config: `none`, `basic`, and `headers`.
- IMPORTANT: the default auth type is `none`, which authenticates every request as the anonymous user (see security note).
- `basic` mode compares username to config and an HMAC (`Crypt::hmacBase64` with the site hash salt) of the password stored in state.
- `headers` mode requires a configured set of header name/value pairs to all match.
- Failed attempts are rate-limited through the core `flood` service keyed by IP.
- Controller `ApiAiEndpointController::callback` decodes the JSON body into a `WebhookRequest` and dispatches `ApiAiEvent`.
- Subscribe to `ApiAiEvent::NAME` to populate the `WebhookResponse`; the controller returns it as JSON.
- Invalid payloads are logged via `watchdog_exception` and return HTTP 500.
- Use the `chatbot_api_apiai` submodule to bridge to the Chatbot API intent/response framework.
- Register your own event subscriber to answer specific intents.
- Set auth to `basic` or `headers` in production so the endpoint is not open.
- The endpoint itself performs no AI calls or outbound requests; it only routes events.
- Store the basic-auth password via the module so it is HMAC'd with the hash salt in state.
- Test with a Dialogflow-shaped JSON POST to `/api.ai/webhook`.
- Version 8.x-2.x supports Drupal 8/9/10.
