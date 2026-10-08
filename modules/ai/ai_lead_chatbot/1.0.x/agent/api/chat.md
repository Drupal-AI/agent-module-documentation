<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chat endpoints, controller, service & widget

## Endpoints (`ai_lead_chatbot.routing.yml`)

- `ai_lead_chatbot.chat_start` — `GET /chat/start` → `ChatbotController::start()`. Returns
  `{"reply": <greeting>}`. The greeting comes from `ChatbotService::getGreeting()`:
  `"Hello! Welcome to {business_name}. I'm here to help you. What service are you interested in?"`.
- `ai_lead_chatbot.chat` — `POST /chat` → `ChatbotController::chat()`. Body is JSON
  `{session_id, message}`; missing either field returns HTTP 400. Returns
  `{"reply": …, "done": bool, "lead": {service,name,contact}}`.

Both endpoints are open-access so the visitor-facing widget (served on public pages) can reach
them. The admin config and leads routes are permission-gated (see the other docs).

## Controller (`src/Controller/ChatbotController.php`)

`chat()` decodes the JSON body, runs both `session_id` and `message` through
`Xss::filter()` (`ChatbotController.php:77-78`), then calls
`$this->chatbotService->processMessage($session_id, $message)` and returns the result as
`JsonResponse`.

## Service (`src/Service/ChatbotService.php`)

Service id `ai_lead_chatbot.chatbot_service`; args `@config.factory`, `@entity_type.manager`,
`@tempstore.private`, `@http_client`, `@logger.factory`.

`processMessage($session_id, $message)`:
1. Loads/creates per-session state from **private tempstore** collection `ai_lead_chatbot`
   (keyed by the caller-supplied `session_id`): `messages[]`, `lead{service,name,contact}`,
   `completed`.
2. If `completed`, returns a closing message with `done = TRUE` (no further OpenAI call).
3. Appends the user message and calls `callOpenAi($session)`.
4. Parses the model's JSON reply (`{message, extracted, complete}`); updates `lead` from
   `extracted.*`. `extracted.contact` must pass `validateContact()` (a valid email via
   `FILTER_VALIDATE_EMAIL`, or 7–15 digits after stripping non-digits) or it is dropped.
5. When `complete` is truthy, marks the session completed and, if all of service/name/contact
   are present, calls `saveLead()` to persist a `chatbot_lead` entity.
6. Stores updated session back to tempstore; returns `{reply, done, lead}`.

`callOpenAi(array $session)`:
- Reads the API key from `Settings::get('ai_lead_chatbot_openai_api_key')` (settings.php); if
  absent, logs an error and returns NULL.
- Builds a system prompt from `business_name`, `tone`, the formatted `faq`, fixed
  data-collection guidelines, a required JSON response schema, and the current lead state, then
  merges the running `messages`.
- POSTs to `https://api.openai.com/v1/chat/completions` via the injected Guzzle `@http_client`
  (default TLS verification), with `Authorization: Bearer <key>`, `model`, `messages`,
  `temperature`, `max_tokens`, `response_format={type: json_object}`, `timeout: 30`. Returns
  `choices[0].message.content` or NULL on exception.

`saveLead(array $lead_data, $session_id)`: `entityTypeManager->getStorage('chatbot_lead')
->create([...])->save()`, storing name/contact/service/session_id. Logs on success/failure.

## Widget (client)

`js/chatbot-widget.js` (library `ai_lead_chatbot/chatbot_widget`, deps `core/drupal`,
`core/drupalSettings`) injects a floating button + window, generates a client-side
`session_id` (`'session_' + Math.random().toString(36)…`), fetches `GET baseUrl+chat/start`
for the greeting, and POSTs `{session_id, message}` to `baseUrl+chat`. Replies are inserted
into the DOM with `textContent` (not innerHTML). When a response has `done: true`, the input
is disabled. `ChatbotWidgetBlock` (`src/Plugin/Block/ChatbotWidgetBlock.php`, block id
`ai_lead_chatbot_widget`) only attaches the library; `hook_page_attachments()` auto-attaches
it on non-admin pages when `enable_widget` is TRUE.
