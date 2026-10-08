<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI-CIJO — journey mappings and the IntentDetector plugin type

## Journey mapping config entity — `Entity\JourneyMapping`

- `@ConfigEntityType(id = "ai_cijo_journey_mapping", config_prefix = "mapping",
  admin_permission = "administer ai cijo")`. Config names: `ai_cijo.mapping.<id>`.
- Public properties: `intent` (string), `stage` (string), `actions` (array). `config_export` =
  `id, label, intent, stage, actions`. Schema `ai_cijo.mapping.*` in `config/schema/ai_cijo.schema.yml`.
- `actions` keys: `show_blocks` (string[] block plugin IDs), `hide_blocks` (string[]),
  `view_filters` (map of `view_id` → `field_name` → value), `layout_variant` (string|null),
  `cta` (string|null).
- Handlers: `JourneyMappingListBuilder` (list columns Label/Intent/Stage),
  `AdminHtmlRouteProvider`, forms add/edit = `Form\JourneyMappingForm`, delete = core
  `EntityDeleteForm`. Routes at `/admin/structure/ai-cijo/journey-mapping[/add|/{id}|/{id}/delete]`;
  menu/action links in `ai_cijo.links.menu.yml` / `ai_cijo.links.action.yml`.

### `Form\JourneyMappingForm`

- Fields: `label`, machine-name `id` (immutable after create), `intent`, `stage`, and a `#tree`
  `orchestration_actions` details group with textareas for `hide_blocks`, `show_blocks`,
  `view_filters`, plus textfields `cta`, `layout_variant`. (Uses key `orchestration_actions`
  because `actions` is reserved by `EntityForm` for buttons.)
- `validateForm()` checks each `view_filters` line against
  `/^[^.=\s]+\.[^=\s]+=.+$/` (format `view_id.field_name=value`), erroring on bad lines.
- `save()` normalizes textareas: `textareaToBlocks()` (trim/newline-split, drop empties) and
  `textareaToViewFilters()` (split on first `=` and first `.` into `filters[view_id][field] =
  value`); empty action groups are omitted. Stores into `$entity->actions` and redirects to the
  collection.

## Orchestration — `Orchestration\OrchestrationEngine::buildState(array $ai): OrchestrationState`

- Reads `intent`/`stage` from the detection result (default `unknown`), sets them on a new
  `OrchestrationState`.
- `JourneyMapping::loadMultiple()`; for every mapping whose `intent` **and** `stage` equal the
  detected pair, aggregates: `showBlocks`/`hideBlocks` merged with `array_unique(array_merge(...))`,
  `viewFilters` merged with `array_merge_recursive`, and scalar `layoutVariant`/`cta` set by the
  last matching mapping (only when non-empty).
- `Orchestration\OrchestrationState` is a plain value object with public
  `intent, stage, showBlocks[], hideBlocks[], viewFilters[], layoutVariant, cta`. It is attached to
  the request as `ai_cijo_state` and (when explain is on) serialized to tempstore.

## IntentDetector plugin type

- Discovery: `IntentDetectorManager extends DefaultPluginManager` (dir `Plugin/IntentDetector`,
  interface `IntentDetectorInterface`, annotation `Annotation\IntentDetector` with `id` + `label`).
  Alter hook `ai_cijo_intent_detector_info`; cache key `ai_cijo_intent_detector_plugins`. Service
  `plugin.manager.ai_cijo.intent_detector`.
- Interface: `detect(array $signals): array` → normalized result with keys `intent`, `stage`,
  `confidence` (float 0–1), `explanation` (string[]). `BaseIntentDetector::normalize()` fills any
  missing keys with safe defaults (`unknown`/`unknown`/`0`/`[]`).
- Shipped plugins:
  - **`fallback`** (`FallbackIntentDetector`, label "Fallback (Heuristic-based)") — heuristics on
    the signals: path containing `pricing`/`product` → `compare`/`consideration`; referrer
    containing `google` → adds an explanation; non-anonymous roles → `return`/`retention`.
    Confidence 0.4.
  - **`openai`** (`OpenAiIntentDetector`, label "OpenAI Detector") — **a stub** that returns
    hardcoded `compare`/`consideration`/0.85; its own docblock notes a production version would call
    the OpenAI API. It makes no external call today.

### Writing a custom detector

Create `Plugin/IntentDetector/MyDetector.php` in any module with `@IntentDetector(id="...",
label=@Translation("..."))`, extend `BaseIntentDetector`, implement `detect(array $signals)`, and
return `$this->normalize([...])`. It then appears in the settings-form detector select.
