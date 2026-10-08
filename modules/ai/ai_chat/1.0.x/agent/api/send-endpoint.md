<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Chat — send endpoint, widget JS & threads

Source: `ai_chat.routing.yml`, `src/Controller/ChatController.php`, `js/ai_chat.js`.

## Route

```yaml
ai_chat.send_message:
  path: '/ai-chat/send'
  methods: [POST]
  defaults: { _controller: ChatController::send, _format: json }
  requirements: { _access: 'TRUE' }
```

The controller resolves which assistants the caller may use from the `role_assistants` config and
returns `403` when the caller's roles map to none — so which users can send is driven by the admin's
role→assistant mapping (see [../config/settings.md](../config/settings.md)).

## Controller `ChatController::send(Request $request)`

Dependency: `ai_assistant_api.runner` (injected in `create()` as `$this->runner`).

Flow:

1. Load `ai_chat.settings` → `role_assistants`. Empty → `{ ok: false, error: 'Not configured.' }`
   (400).
2. Build `$available_assistants` by unioning the current user's roles' `assistants`; if the user has
   `administer site configuration`, union every role's assistants too; `array_unique`. Empty →
   `{ ok: false, error: 'Access denied.' }` (403).
3. Decode the JSON request body: `message` (trimmed string), `thread_id` (string, optional),
   `assistant_id` (string, optional). Empty `message` → `400 'Empty message.'`.
4. Pick the assistant: the posted `assistant_id` **only if it is in `$available_assistants`**,
   otherwise `reset($available_assistants)` (first allowed). Load the `ai_assistant` entity; missing
   → `400 'Assistant not found.'`.
5. Run it: `runner->setAssistant($assistant)`; if `thread_id` was posted,
   `runner->setThreadsKey($thread_id)`; `runner->setUserMessage(new UserMessage($message))`;
   `$output = runner->process()`.
6. Normalise the reply: `$output->getNormalized()`; if it is an object with `getText()`, use that,
   else cast to string. Read back `runner->getThreadsKey()`.
7. Return `{ ok: true, reply, thread_id }`. Any `\Throwable` → `{ ok: false, error: <message> }`
   (500).

Notes:
- The posted `assistant_id` is validated against the caller's allowed set (step 4), so a user cannot
  invoke an assistant their roles were not granted.
- Threads are stored by `ai_assistant_api`'s runner in a **private tempstore** keyed per user
  (`AiAssistantApiRunner::getTempStore()` → `PrivateTempStoreFactory->get('ai_assistant_api')`), so a
  posted `thread_id` resolves within the current user's own tempstore namespace.

## Widget JS (`js/ai_chat.js`, `Drupal.behaviors.AiChatWidget`)

- Reads `drupalSettings.ai_chat` (`endpoint`, `assistants`, `defaultAssistant`, `primaryColor`,
  `title`); bails if absent or already initialised. Applies `--ai-chat-primary` /
  `--ai-chat-on-primary` CSS vars (`getContrastColor()` picks black/white by luminance).
- `AiChatWidget` builds a toggle button + panel (header with title, optional assistant `<select>`
  when more than one assistant, messages area, form). Toggle/close, drag-to-move, Enter-to-send
  (Shift+Enter = newline).
- Per-assistant `localStorage` keys: `ai_chat_open_<id>` (open state), `ai_chat_pos_<id>`
  (panel position, JSON `{left, top}`), `ai_chat_thread_<id>` (thread id). Switching assistant clears
  the messages pane and reloads that assistant's stored thread.
- `sendMessage(text)` POSTs `{ message, assistant_id, thread_id? }` to `endpoint` with
  `fetch(..., { method: 'POST', headers: {'Content-Type':'application/json'},
  credentials: 'same-origin' })`, shows a `...` placeholder, then on `data.ok` stores
  `data.thread_id` and appends `data.reply`.
- **Render sink** `appendMessage(role, text)`: `bubble.innerHTML = convertLinksToClickable(text)`.
  `convertLinksToClickable()` first HTML-escapes via `div.textContent = text; div.innerHTML`, then
  regex-wraps bare `https?://…` URLs in `<a target="_blank" rel="noopener noreferrer">` — so message
  text is escaped before any HTML is built, and only whitelisted URL substrings become anchors.
