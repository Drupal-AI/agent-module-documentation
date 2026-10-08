# OpenAI ChatGPT Explorer (openai_chatgpt) — agent index

Adds an admin form that holds a running conversation with OpenAI's Chat endpoint (ChatGPT / `gpt-*`
models). Unlike the prompt explorer it keeps message history in form storage so replies build on the
conversation. Uses the parent `openai.api` service.

Dependency: `openai:openai`. `configure` = `openai_chatgpt.chat_form`. Defines one permission; no
config, schema, or Drush of its own.

- **The chat form (system profile, model, temperature, tokens) and conversation flow** → [configure/chat_form.md](configure/chat_form.md)
- **Who can use it** → [permissions/permissions.md](permissions/permissions.md)

Parent (shared OpenAI client/service + API-key config): [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md).

Key facts:
- Route `openai_chatgpt.chat_form` → `/admin/config/openai/chatgpt`, form
  `\Drupal\openai_chatgpt\Form\ChatGptForm` (id `openai_chatgpt_form`),
  `_permission: 'access openai chatgpt'`.
- Permission `access openai chatgpt` (`openai_chatgpt.permissions.yml`).
- `submitForm()` appends the user message, calls `openai.api` → `OpenAIApi::chat($model, $messages,
  $temperature, $max_tokens)`, stores the full `messages` array in form storage, and rebuilds; the
  AJAX callback `::getResponse` shows the last assistant reply.
- Model options from `filterModels(['gpt'])`; default `gpt-3.5-turbo`. Editable "Profile" = the
  system message.
