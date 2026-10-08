OpenAI Core is the base integration for the OpenAI (ChatGPT/GPT, DALL·E, Whisper, embeddings, moderation) API in Drupal: it wraps the `openai-php/client` library in a reusable `openai.api` service and API-key settings, and ships a family of submodules that build editor tools, CKEditor helpers, log analysis, embeddings search, and more on top of it.

---

The core module stores the OpenAI **API key** and **organization ID** in `openai.settings`
config (settings form `openai.api_settings` at `/admin/config/openai/settings`, permission
`administer site configuration`) and builds an `OpenAI\Client` from them via
`ClientFactory` (service `openai.client`). The main service `openai.api`
(`\Drupal\openai\OpenAIApi`) exposes typed methods over the API: `getModels()` /
`filterModels()`, `completions()`, `chat()` (both support streaming), `images()` (DALL·E),
`textToSpeech()`, `speechToText()` (Whisper), `moderation()` (returns a bool flag), and
`embedding()`. A `StringHelper::prepareText()` utility cleans HTML (always stripping
`pre/code/script/iframe/drupal-media`) and truncates text before it is sent as a prompt. An
event subscriber warns administrators on admin routes when no API key is configured. Admin
routes also list available models (`openai.models`) and redirect to OpenAI's docs
(`openai.docs`). The core module by itself only provides plumbing; the actual features come
from the eleven submodules: `openai_content` (node-form content tools), `openai_ckeditor`
(in-editor completion), `openai_chatgpt` / `openai_prompt` (explorers), `openai_dalle`,
`openai_audio` / `openai_tts` (speech), `openai_embeddings` (vector search + Milvus/Pinecone
clients), `openai_dblog` (log analysis), `openai_eca` (ECA actions), and `openai_devel`
(dev/generate). The API key is stored as normal Drupal config (override it via `settings.php`
or environment as usual); no Key entity is used.

---

- Add OpenAI/ChatGPT capabilities to a Drupal site behind one shared API service.
- Store and manage the OpenAI API key and organization ID centrally.
- Call chat/completions from custom code via the `openai.api` service.
- Generate embeddings for text programmatically.
- Run OpenAI moderation to flag disallowed content (returns a boolean).
- Generate images with DALL·E from a prompt.
- Transcribe audio to text with Whisper (`speechToText`).
- Synthesize speech from text (`textToSpeech`).
- Stream chat/completion responses to the browser.
- List and filter the OpenAI models available to your account.
- Clean and truncate HTML content before sending it as a prompt (`StringHelper::prepareText`).
- Warn admins when the API key is missing before features silently fail.
- Build editor-facing AI tools (summarize, adjust tone, suggest titles/taxonomy) via submodules.
- Add an OpenAI completion button inside CKEditor 5.
- Analyze Drupal log messages with AI (openai_dblog).
- Provide semantic/vector search backed by Milvus or Pinecone (openai_embeddings).
- Trigger OpenAI actions from ECA workflows (openai_eca).
- Prototype prompts in the ChatGPT / Prompt explorer forms.
- Generate demo content with GPT via Devel Generate (openai_devel).
- Override the API key per-environment through settings.php config overrides.
- Reuse a single OpenAI client across all AI features on the site.
