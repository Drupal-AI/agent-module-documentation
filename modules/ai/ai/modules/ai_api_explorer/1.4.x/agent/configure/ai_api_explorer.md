# configure — the explorer pages

This module has **no settings form and no config entities** (info.yml declares no
`configure:` route, and there is no `config/` directory). "Configuration" here just means
knowing the pages it exposes. Everything is gated by the `access ai prompt` permission.

## Landing page

- **`/admin/config/ai/explorers`** — route `ai_api_explorer.list_page`
  (`Controller\ExplorerSetupList::list`), menu link `ai_api_explorer.main` under
  *Configuration → AI* (`ai.admin_config_search`).
- It lists only explorers whose plugin reports `isActive() === TRUE`. If **no** provider
  supports any explorer, the page shows a "configure a provider" notice instead of the list.

## Per-explorer form routes (registered dynamically)

There is no static route per explorer. `Routing\AiApiExplorerRouteSubscriber` iterates every
`AiApiExplorer` plugin and adds a route:

- **Route name:** `ai_api_explorer.form.<plugin_id>`
- **Path:** `/admin/config/ai/explorers/<plugin_id>`
- **Form:** `Drupal\ai_api_explorer\Form\AiApiExplorerForm` (a single form class parameterized
  by the `plugin_id` route default).
- **Access:** the custom `_ai_api_explorer_access` requirement → `Access\AiApiExplorerAccessChecker`,
  which grants only when the plugin's `isActive()` **and** `hasAccess($account)` are TRUE.
- Marked `_admin_route: TRUE`.

## Explorers shipped by this module (plugin_id → title)

Each is reachable at `/admin/config/ai/explorers/<plugin_id>`:

| plugin_id | Explorer |
|---|---|
| `chat_generator` | Chat Generation |
| `embeddings_generator` | Embeddings Generation |
| `summarize_generator` | Summarize Text |
| `translation_generator` | Translate Text |
| `moderation_generator` | Moderation |
| `text_classification_generator` | Text Classification |
| `image_classification_generator` | Image Classification |
| `object_detection_generator` | Object Detection |
| `rerank_generator` | Rerank |
| `text_to_image_generator` | Text-To-Image |
| `image_to_image_generator` | Image-To-Image |
| `text_to_speech_generator` | Text-To-Speech |
| `speech_to_text_generator` | Speech-To-Text |
| `speech_to_speech_generator` | Speech-To-Speech |
| `audio_to_audio_generator` | Audio-To-Audio |
| `image_and_audio_to_video_generator` | Image-and-Audio-to-Video |
| `tools_explorer` | Tools (test FunctionCall tools) |

Which forms appear depends on the providers/operation types you have installed — an explorer
with no capable provider hides itself. Each form lets you pick provider + model + inputs, runs
a real API call (spending credits), shows the normalized response inline, and offers a
**Code Example** panel with copy-pasteable PHP. Intended for development only.
