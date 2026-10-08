<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Dropsolid (ai_dropsolid) — agent index

A support bundle for Dropsolid's AI stack. It (1) **decorates the AI module's tokenizer** with an
XLM-Roberta-aware implementation, (2) adds a **token-aware text chunker + AI Search embedding
strategy**, and (3) **tags LiteLLM requests** with Dropsolid `dxp_*` feature labels.

- **Version:** 1.0.x (1.0.0-alpha3)  •  **Core:** `^10 || ^11`  •  **PHP:** `>=8.1`  •  Package AI  •  GPL-2.0-or-later
- **Depends on:** `ai_provider_dropsolidai` (which pulls in the `ai` module). Optional runtime
  companions used when present: `ai_provider_litellm` (LiteLLM host/key + tagging), `ai_search`
  (embedding-strategy plugin type), `key`, `file`.
- **Provides:** 1 config object + schema, 1 settings form/route, 3 services (+ a decorator + an
  interface alias + a logger channel), 1 embedding-strategy plugin, 1 event subscriber. **No**
  permissions, entities, or Drush commands.

## Components (from source)

- **`Tokenizer\DropsolidXlmRobertaTokenizer`** (service `ai_dropsolid.tokenizer.xlm_roberta`,
  implements `Drupal\ai\Utility\TokenizerInterface`) — counts/tokenizes text for
  `dropsolid_xlmr__xlm-roberta-base`. Modes: `lite_llm` (HTTP POST to LiteLLM
  `{host}/utils/token_counter`), `cli_sentencepiece` (`proc_open` of `spm_encode`), or character
  fallback. Reads mode from `ai_dropsolid.settings`; reads LiteLLM host/key from
  `ai_provider_litellm.settings` (host + Key entity).
- **`Tokenizer\DropsolidTokenizerDecorator`** (service `ai_dropsolid.tokenizer.decorator`,
  **decorates `ai.tokenizer`**, priority 10) — routes to the Dropsolid tokenizer only when the
  selected model is one Dropsolid supports; otherwise delegates to the inner core tokenizer.
- **`Service\TokenAwareTextChunker`** (service `ai_dropsolid.token_aware_text_chunker`, extends
  `Drupal\ai\Utility\TextChunker`, implements `TokenAwareTextChunkerInterface`) — density-probe /
  character-budget chunker; the interface is aliased to the service.
- **`Plugin\EmbeddingStrategy\TokenAwareEmbeddingStrategy`** (ai_search plugin id
  `ds_token_aware_chunks`) — extends `ai_search`'s `EmbeddingBase` and swaps its `textChunker` for
  the token-aware one.
- **`EventSubscriber\LiteLlmTagSubscriber`** — on `PreGenerateResponseEvent`, when provider is
  `litellm`, sets a single `dxp_*` tag in the request `metadata`.
- **`Form\TokenizerSettingsForm`** — the admin config form (route below).

## Routes & config

- Route **`ai_dropsolid.tokenizer_settings`** → `/admin/config/ai/dropsolid/tokenizer`,
  `_form: TokenizerSettingsForm`, **`_permission: 'administer ai'`**. Menu link under
  `ai.admin_providers` (*AI providers*).
- Config object **`ai_dropsolid.settings`** (schema in `config/schema/ai_dropsolid.schema.yml`,
  install default `tokenizer.mode: lite_llm`). CLI submode stores `tokenizer.cli.executable_name`,
  `executable_path`, `model_file` (managed file id), `model_path`.

## Solution docs

- **Tokenizer settings form, config object, modes & verification** →
  [config/settings.md](config/settings.md)
- **The tokenizer decorator + XLM-Roberta tokenizer (LiteLLM / SentencePiece / fallback)** →
  [services/tokenizer.md](services/tokenizer.md)
- **Token-aware text chunker + the `ds_token_aware_chunks` embedding strategy** →
  [services/chunker-and-embedding-strategy.md](services/chunker-and-embedding-strategy.md)
- **The LiteLLM DXP tag event subscriber** →
  [services/litellm-tagging.md](services/litellm-tagging.md)
