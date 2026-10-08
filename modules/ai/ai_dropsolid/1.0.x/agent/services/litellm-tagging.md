<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LiteLLM DXP tag event subscriber

## Service

`ai_dropsolid.litellm_tag_subscriber` → `EventSubscriber\LiteLlmTagSubscriber` (tagged
`event_subscriber`). Subscribes to `Drupal\ai\Event\PreGenerateResponseEvent::EVENT_NAME` with
`onPreGenerateResponse` at priority **0**.

## What it does

On every pre-generate AI event it **short-circuits unless the provider is `litellm`**
(`$event->getProviderId() !== 'litellm'` → return). For LiteLLM requests it computes one
Dropsolid DXP tag and writes it into the request `metadata.tags`:

- `generateDxpTag($event)`:
  1. If any existing tag already starts (case-insensitive) with `dxp_`, keep the **last** such tag.
  2. Else map a known operational tag to a DXP tag (`$tagMappings`): `ai_api_explorer` →
     `dxp_ai_api_explorer`, `ai_search`/`ai_search_block` → `dxp_ai_search`, `ai_assistant_api` →
     `dxp_ai_assistant`, `ai_agents` → `dxp_ai_agents`, `ai_translate` → `dxp_ai_translation`,
     `ai_ckeditor` → `dxp_ai_content_creation`.
  3. Else map the **operation type** (`$event->getOperationType()`): `chat` → `dxp_ai_chat`,
     `embeddings` → `dxp_ai_embeddings`, `completion` → `dxp_ai_completion`, `search` →
     `dxp_ai_search`, `analysis` → `dxp_ai_analysis`.
  4. Else `null`.
- If a tag is produced, `metadata['tags'] = [$dxpTag]` (a single-element array, replacing any prior
  tags); if `null`, `tags` is removed. Empty `metadata` is unset from the configuration. The updated
  configuration is written back with `$event->setConfiguration($configuration)`.

## Effect

Requests routed through the LiteLLM provider carry exactly one `dxp_*` tag reflecting the feature or
operation, so LiteLLM-side usage/reporting can attribute AI calls to Dropsolid DXP features. No
configuration, route, or permission is involved; the subscriber is always active but only acts on
`litellm`-provider events.
