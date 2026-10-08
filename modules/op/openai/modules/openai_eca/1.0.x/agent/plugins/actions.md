# OpenAI ECA actions

These are core `@Action` plugins (not a new plugin type). Add them to an ECA model; each
wraps an `openai.api` method and typically writes its result to an ECA token for later steps.
Base class: `\Drupal\openai_eca\Plugin\Action\OpenAIActionBase`.

| Action id | Class | Wraps `openai.api->` |
|---|---|---|
| `openai_eca_execute_chat` | `Chat` | `chat()` |
| `openai_eca_execute_completion` | `Completion` | `completions()` |
| `openai_eca_execute_embedding` | `Embedding` | `embedding()` |
| `openai_eca_execute_moderation` | `Moderation` | `moderation()` (bool flag) |
| `openai_eca_execute_tts` | `TextToSpeech` | `textToSpeech()` |
| `openai_eca_execute_speech` | `SpeechToText` | `speechToText()` |

Usage:
- In an ECA model (with the `eca` + a modeller like BPMN.iO), add one of these actions after
  an event/condition. Configure its per-instance fields (prompt/input, model, etc.).
- The result is placed in an ECA token you name, so subsequent actions can use it (e.g. set a
  field, send a message).
- All calls require the parent `openai` module's API key. No module-level config here.
