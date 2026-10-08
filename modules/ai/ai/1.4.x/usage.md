AI Core (the `ai` module) is a provider-agnostic abstraction layer that lets Drupal code call large-language-model and other AI services through one stable API, no matter which vendor (OpenAI, Anthropic, Ollama, Mistral, …) actually serves the request.

---

AI Core does not talk to any AI vendor by itself — it defines the contracts and the plumbing that provider modules plug into. It ships an `AiProvider` plugin type (each installed provider module supplies one) and a set of `OperationType` plugins that standardise the shape of every capability: `chat`, `embeddings`, `text_to_image`, `moderation`, `translate_text`, `speech_to_text`, and a dozen more. Application code asks the central `ai.provider` service for the site's configured default provider+model for an operation, builds a typed input object (e.g. `ChatInput` with `ChatMessage` items), calls the operation method (`->chat($input, $model_id)`), and reads a normalised output object — so swapping vendors is a config change, not a code change. On top of that it provides function-calling (`FunctionCall`/`FunctionGroup` plugins let the LLM invoke Drupal tools), guardrails (`ai_guardrail` / `ai_guardrail_set` config entities that pre- and post-process requests), reusable prompt entities (`ai_prompt` / `ai_prompt_type`), a vector-database provider abstraction (`AiVdbProvider`, consumed by AI Search), a tokenizer and text chunker, an `ai_file` entity for AI-generated files, and events (`PreGenerateResponseEvent`, `PostGenerateResponseEvent`, streaming events) for observing and altering every request. API keys are stored via the required Key module, never in config. It is the base dependency for the whole AI ecosystem (ai_agents, ai_search, ai_assistant_api, ai_ckeditor, etc.) and its many submodules layer concrete features on top.

---

- Add LLM chat to a custom module without hard-coding a vendor, via the `ai.provider` service and `ChatInput`.
- Switch the whole site from OpenAI to Anthropic (or Ollama for local dev) by changing the default provider in config — no code edits.
- Generate text embeddings for semantic search or RAG using the `embeddings` operation type.
- Set a different default provider/model per operation type (cheap model for summarization, strong model for chat).
- Send a quick prompt from the command line for debugging with `drush ai:chat "..."`.
- Stream a chat response token-by-token to the browser for a live "typing" UX.
- Give the model tools it can call (function calling) by writing `FunctionCall` plugins that run Drupal logic.
- Group related tools into a `FunctionGroup` an agent can be granted wholesale.
- Enforce content policy on every AI request with reusable guardrail sets (e.g. restrict responses to a topic, block PII).
- Store and reuse standard prompts as `ai_prompt` config entities instead of scattering prompt strings in code.
- Moderate user-supplied text through the `moderation` operation before acting on it.
- Translate field content programmatically via the `translate_text` operation type.
- Transcribe uploaded audio with `speech_to_text`, or synthesize speech with `text_to_speech`.
- Generate images from a prompt (`text_to_image`) and persist them as `ai_file` entities.
- Classify or tag content automatically using `text_classification` / `image_classification`.
- Count tokens and estimate cost before a call with the `ai.tokenizer` service.
- Chunk long documents into model-sized pieces with the `ai.text_chunker` service before embedding.
- Back AI Search with a pluggable vector database by implementing/selecting an `AiVdbProvider`.
- Centralize AI API keys through the Key module so secrets stay out of exported config.
- Observe or alter every request site-wide by subscribing to `PreGenerateResponseEvent` / `PostGenerateResponseEvent`.
- Restrict which outbound hosts AI providers may call via the `allowed_hosts` setting for security.
- Turn on prompt logging to audit exactly what was sent to the LLM.
- Build an interactive request tester for site builders using the AI API Explorer submodule.
- Provide the base layer that ai_agents, ai_assistant_api, ai_ckeditor and other modules depend on.
- Normalize responses from wildly different vendor SDKs into one predictable output object.
- Add a new AI vendor to Drupal by writing a single `AiProvider` plugin against the operation-type interfaces.
- Convert data between formats for AI consumption with `AiDataTypeConverter` plugins.
- Give agents short-term conversational memory via `AiShortTermMemory` plugins.
