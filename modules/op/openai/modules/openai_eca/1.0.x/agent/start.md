# OpenAI ChatGPT ECA (openai_eca) — agent index

Exposes OpenAI endpoints as ECA Action plugins for no-code workflows, over the parent
`openai.api` service. Requires `eca`. Parent: [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md).

- **The six ECA actions and what each calls** → [plugins/actions.md](plugins/actions.md)

Key facts:
- Action plugins (base `\Drupal\openai_eca\Plugin\Action\OpenAIActionBase`):
  `openai_eca_execute_chat`, `openai_eca_execute_completion`, `openai_eca_execute_embedding`,
  `openai_eca_execute_moderation`, `openai_eca_execute_tts`, `openai_eca_execute_speech`.
- Uses core `@Action` plugin type (no new plugin type defined). Configure per ECA model.
- No config/permissions of its own. Requires the parent's API key.
