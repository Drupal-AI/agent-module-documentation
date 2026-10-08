# OpenAI Prompt Completion Explorer (openai_prompt) — agent index

Adds an admin form to send a single prompt to OpenAI's (legacy) completions endpoint and read the
answer back — a ChatGPT-like scratchpad for `text-*` models. Uses the parent `openai.api` service.

Dependency: `openai:openai`. `configure` = `openai_prompt.prompt_form`. Defines one permission; no
config, schema, or Drush of its own.

- **The prompt form (model, temperature, tokens) and how a response is fetched** → [configure/prompt_form.md](configure/prompt_form.md)
- **Who can use it** → [permissions/permissions.md](permissions/permissions.md)

Parent (shared OpenAI client/service + API-key config): [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md).

Key facts:
- Route `openai_prompt.prompt_form` → `/admin/config/openai/openai-prompt`, form
  `\Drupal\openai_prompt\Form\PromptForm` (id `openai_prompt_prompt`),
  `_permission: 'access openai prompt'`.
- Permission `access openai prompt` (`openai_prompt.permissions.yml`).
- AJAX callback `::getResponse` calls `openai.api` → `OpenAIApi::completions($model, $prompt,
  $temperature, $max_tokens)` and writes the answer into a read-only textarea.
- Model options from `filterModels(['text'])`; default `text-davinci-003`. (Legacy completions
  endpoint / text models.)
- Menu link under the OpenAI admin group.
