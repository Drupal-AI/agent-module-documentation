# OpenAI Core — agent index

Base OpenAI integration: API-key settings + a reusable `openai.api` service wrapping the
`openai-php/client` library. Features live in eleven submodules. Requires the
`openai-php/client` PHP library. `configure` = `openai.api_settings`.

- **API key / org settings, config keys, model/docs routes** → [configure/settings.md](configure/settings.md)
- **The `openai.api` service methods (chat, completions, images, embeddings, moderation, …)** →
  [api/service.md](api/service.md)

Submodules (own docs under `../../modules/<name>/1.0.x/`):
- `openai_content` — node-form AI content tools → [../../modules/openai_content/1.0.x/agent/start.md](../../modules/openai_content/1.0.x/agent/start.md)
- `openai_ckeditor` — CKEditor 5 completion → [../../modules/openai_ckeditor/1.0.x/agent/start.md](../../modules/openai_ckeditor/1.0.x/agent/start.md)
- `openai_chatgpt` — ChatGPT explorer form → [../../modules/openai_chatgpt/1.0.x/agent/start.md](../../modules/openai_chatgpt/1.0.x/agent/start.md)
- `openai_prompt` — prompt/completion explorer → [../../modules/openai_prompt/1.0.x/agent/start.md](../../modules/openai_prompt/1.0.x/agent/start.md)
- `openai_dalle` — DALL·E image form → [../../modules/openai_dalle/1.0.x/agent/start.md](../../modules/openai_dalle/1.0.x/agent/start.md)
- `openai_audio` — Whisper transcription form → [../../modules/openai_audio/1.0.x/agent/start.md](../../modules/openai_audio/1.0.x/agent/start.md)
- `openai_tts` — text-to-speech form → [../../modules/openai_tts/1.0.x/agent/start.md](../../modules/openai_tts/1.0.x/agent/start.md)
- `openai_embeddings` — vector search + Milvus/Pinecone → [../../modules/openai_embeddings/1.0.x/agent/start.md](../../modules/openai_embeddings/1.0.x/agent/start.md)
- `openai_dblog` — AI log analysis → [../../modules/openai_dblog/1.0.x/agent/start.md](../../modules/openai_dblog/1.0.x/agent/start.md)
- `openai_eca` — ECA actions → [../../modules/openai_eca/1.0.x/agent/start.md](../../modules/openai_eca/1.0.x/agent/start.md)
- `openai_devel` — Devel Generate + Drush → [../../modules/openai_devel/1.0.x/agent/start.md](../../modules/openai_devel/1.0.x/agent/start.md)

Key facts:
- Config `openai.settings`: `api_key`, `api_org` (schema `openai.schema.yml`). Stored as normal
  Drupal config (plaintext); override via `settings.php`/env. No Key entity.
- `openai.client_factory` (`ClientFactory`) → `openai.client` (`OpenAI\Client`).
- `openai.api` (`\Drupal\openai\OpenAIApi`) — the wrapper you call. See api/service.md.
- `\Drupal\openai\Utility\StringHelper::prepareText($text, $removeHtmlElements, $max_length)` —
  strips `pre/code/script/iframe/drupal-media` (always) and truncates before prompting.
- `openai.event_subscriber` warns admins on admin routes when `api_key` is empty.
- Admin routes: `openai.api_settings`, `openai.models` (list models), `openai.docs`
  (redirect to platform docs) — all `administer site configuration`.
