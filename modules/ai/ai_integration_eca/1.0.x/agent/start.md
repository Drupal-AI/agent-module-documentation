# AI Integration - ECA — agent index

Exposes AI-module operations as **ECA actions** (Chat, Embedding, Moderation, Speech-to-Text,
Text-to-Speech) usable in no-code ECA models. No config UI/route of its own (`configure` null),
no permissions, no Drush, no config schema — actions are configured inside ECA. Depends on `ai`,
`eca`, core `file`. Replaces the old `ai_eca`.

- **The five ECA actions, their config fields (Model / Token input / Token result / config YAML /
  Prompt / Schema) and execution behaviour** → [configure/actions.md](configure/actions.md)
- **Adding your own AI-operation action (subclass `AiActionBase`/`AiConfigActionBase`) + the
  provider-validator service** → [extend/action.md](extend/action.md)

Submodules (own docs):
- `ai_integration_eca_agents` → [modules/ai_integration_eca_agents/1.0.x/agent/start.md](../../modules/ai_integration_eca_agents/1.0.x/agent/start.md)
- `ai_integration_eca_automators` → [modules/ai_integration_eca_automators/1.0.x/agent/start.md](../../modules/ai_integration_eca_automators/1.0.x/agent/start.md)

Key facts:
- Actions (`src/Plugin/Action/`): `ai_integration_eca_execute_chat`, `..._embedding`,
  `..._moderation`, `..._stt`, `..._tts`.
- `AiActionBase` → config `model` (provider__model), `token_input`, `token_result`.
  `AiConfigActionBase` adds `config` (YAML, validated via `ai_integration_eca.provider_validator`).
  Chat adds `prompt` (token-replaced) + `schema` (structured JSON output).
- Results are written to the ECA result token; used by later ECA steps. TTS writes
  `public://audio.mp3` and stores its URL; STT reads the input token as a filepath.
- Only ECA-admin users configure these (ordinary ECA actions inside an ECA model).
