# FlowDrop node processors (the workflow nodes)

Each processor is a `#[FlowDropNodeProcessor]` plugin in `src/Plugin/FlowDropNodeProcessor/`, extending
`Drupal\flowdrop\Plugin\FlowDropNodeProcessor\AbstractFlowDropNodeProcessor`. The plugin id is bare
(e.g. `chat`); FlowDrop references it namespaced as **`flowdrop_ai_provider:chat`**, and each has a
shipped node-type config entity `flowdrop_node_type.flowdrop_node_type.flowdrop_ai_provider_<id>`.

The common shape: `process(ParameterBagInterface $params): array` reads params, resolves a model, builds
the matching `drupal/ai` `*Input` object, calls `$provider->{operation}($input, $model_id, [])` on an
instance from `ai.provider` (`AiProviderPluginManager::createInstance($provider_id, [...opts])`), and
returns a plain output array. `getParameterSchema()` / `getOutputSchema()` describe the editor UI;
`validateParams()` guards required inputs. Model resolution (via `AiModelService`, see
[../api/services.md](../api/services.md)) is uniform: explicit `model` param → operation-type default →
first available model for the operation type; a node with no provider renders an `error_message` schema.

## The 19 processors

| Plugin id | Version | AI operation | Key input params → outputs | Fetches file input? |
|---|---|---|---|---|
| `chat` | 1.1.0 | `chat` (+ pseudo tiers) | `message`, `model`, `operation_type`, `temperature`, `maxTokens`, `systemPrompt` (accepts `ai_prompt:` refs), `history` → `response`, `model`, `provider`, `tokens_used`, … | no |
| `simple_chat` | 1.1.0 | `chat` | same as `chat` but `systemPrompt` is plain text (no prompt-reference resolution) | no |
| `embeddings` | 1.0.0 | `embeddings` | `text` or `texts[]` (batch), `model` → `embeddings`, … | no |
| `moderation` | 1.0.0 | `moderation` | `text`, `model` → `flagged`, `information` | no |
| `summarize` | 1.0.0 | `summarize` | `text`, `prompt`, `model` → summary | no |
| `rerank` | 1.0.0 | `rerank` | `query`, `documents[]`, `top_n`, `model` → ranked docs | no |
| `translate_text` | 1.0.0 | `translate_text` | `text`, `target_language`, `source_language`, `model` → `translated_text`, `source_language` | no |
| `text_to_image` | 1.0.0 | `text_to_image` | `prompt`, `model`, `width`, `height`, `num_images` → `images` | no |
| `image_to_image` | 1.0.0 | `image_to_image` | `image_file` **or** `image_url`, `prompt`, `strength`, `model` → `images` | yes (file/URL) |
| `image_classification` | 1.0.0 | `image_classification` | `image_file`/`image_url`, `labels[]`, `model` → `classifications` | yes (file/URL) |
| `object_detection` | 1.0.0 | `object_detection` | `image_file`/`image_url`, `model` → detections | yes (file/URL) |
| `image_to_video` | 1.0.0 | `image_to_video` | `image_file`, `model` → `video_files` | yes (file) |
| `image_and_audio_to_video` | 1.0.0 | `image_and_audio_to_video` | `image_file`, `audio_file`, `model` → `video_files` | yes (file) |
| `text_to_speech` | 1.0.0 | `text_to_speech` | `text`, `voice`, `model` → `audio_files` | no |
| `speech_to_text` | 1.0.0 | `speech_to_text` | `audio_file` **or** `audio_url`, `language`, `model` → `text`, `language` | yes (file/URL) |
| `speech_to_speech` | 1.0.0 | `speech_to_speech` | `audio_file`, `model` → `audio_files` | yes (file) |
| `audio_to_audio` | 1.0.0 | `audio_to_audio` | `audio_file`, `model` → `audio_files` | yes (file) |
| `guardrails` | 1.0.0 | — (no provider) | `text`, `guardrail_set`, `mode` (`input`/`output`) → filtered/blocked text | no |
| `session_history` | 1.0.0 | — (no provider) | `session_id`, `history_context_length`, `message_id` → `history[]`, `count` | no |

Exact param flags (configurable/connectable/required/default) and exposed outputs are in each node
type's `config/install/flowdrop_node_type.flowdrop_node_type.flowdrop_ai_provider_<id>.yml`, and update
hook `_10004` documents the authoritative parameter/output map per node type.

## Notable details

- **Chat (`chat`) — role-injection guard.** `Chat::executeChatRequest()` builds the `ChatMessage` list
  from `history`, but only replays items whose `role` is in `['user', 'assistant']` — a `system` (or
  other) role in supplied history is dropped, so untrusted history cannot inject system instructions.
  `systemPrompt` is resolved through `AiPromptResolver` (literal, or `ai_prompt:<id>`) with `{message}`
  substitution. `operation_type` may be a capability pseudo-type (e.g. `chat_with_tools`) used only to
  pick the default model.
- **File inputs go through `SecureFileLoader`.** Processors that accept an `image_file`/`audio_file`
  path or an `image_url`/`audio_url` call `flowdrop_ai_provider.secure_file_loader`
  (`loadFromFile()` / `loadFromUrl()`), which enforces path-traversal limits (Drupal stream wrappers +
  `public/private/temporary` dirs, rejects `..`), an SSRF allow-list (scheme http(s), blocks
  private/reserved IPs and cloud-metadata endpoints), a 50 MB cap and Guzzle timeouts. See
  [../api/services.md](../api/services.md). File loads throw on failure rather than passing `false` on.
- **`guardrails`** needs no AI provider; it loads an `AiGuardrailSet` (`ai.guardrail_repository`), runs
  its pre- or post-generate guardrail plugins over a `ChatInput`/`ChatOutput` and handles
  `PassResult`/`RewriteInput/OutputResult`/`StopResult` against the set's stop threshold.
- **`session_history`** needs no AI provider; it queries `flowdrop_session_message` entities for a
  session's `user`/`assistant` messages (end-anchored, `2 × history_context_length` rows, excluding the
  triggering `message_id`) and emits them in the shape a `chat` node's `history` input consumes.
- **`AiOperationAvailability`** maps an executor plugin to its AI operation type (with `simple_chat` →
  `chat`); ids that are not `drupal/ai` operation types (`guardrails`, `session_history`) are treated as
  "needs no provider" and stay available. This drives both the sidebar filter and the form warning.
