<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Intent & Journey Orchestrator (ai_cijo) — agent index

Request-time layer that **detects visitor intent + journey stage** from anonymous signals and,
per admin-defined **journey mappings**, orchestrates **block visibility, view filters, layout
variant, and CTA** — with an admin **explainability + URL-simulation** tool. Package `AI`.
Depends on core **`block`** and **`views`**. Core `^11`. GPL-2.0-or-later. Version 1.1.1.
Disabled by default; a single permission **`administer ai cijo`** gates everything.

Solution docs:
- **Settings, targeting rules, and the runtime pipeline (subscriber → detector → engine → hooks)**
  → [config/settings.md](config/settings.md)
- **Journey mapping config entity + the IntentDetector plugin type** →
  [plugins/orchestration.md](plugins/orchestration.md)
- **Explainability page and the Explain-by-URL simulation** → [api/explain.md](api/explain.md)

## What it provides (from source)

- **Config object** `ai_cijo.settings` (`enabled`, `detector`, `explain`, `targeting.*`).
- **Config entity** `ai_cijo_journey_mapping` (`config_prefix: mapping`, class
  `Entity\JourneyMapping`) — intent + stage → actions (`hide_blocks`, `show_blocks`,
  `view_filters`, `layout_variant`, `cta`). CRUD at `/admin/structure/ai-cijo/journey-mapping`.
- **Plugin type `IntentDetector`** (`@IntentDetector` annotation, `IntentDetectorManager`, dir
  `Plugin/IntentDetector`). Ships `fallback` (heuristic) and `openai` (a stub returning fixed
  values). Interface `IntentDetectorInterface::detect(array $signals): array`.
- **Services**: `ai_cijo.visitor_signal_collector` (`Context\VisitorSignalCollector`),
  `ai_cijo.orchestration_engine` (`Orchestration\OrchestrationEngine`),
  `plugin.manager.ai_cijo.intent_detector`, `ai_cijo.request_subscriber`
  (`EventSubscriber\RequestSubscriber`, `kernel.request` @30).
- **Routes** (both `_permission: 'administer ai cijo'`): `ai_cijo.explain`
  (`/admin/ai-cijo/explain`, `Controller\ExplainController`), `ai_cijo.settings`
  (`/admin/config/ai/ai-cijo`, `Form\AiCijoSettingsForm`). Plus the journey-mapping entity routes
  (`admin_permission = "administer ai cijo"`).
- **Hooks** in `ai_cijo.module`: `hook_block_view_alter()` (blanks hidden blocks),
  `hook_views_pre_view()` (injects `view_filters` via `$view->query->addWhere(0, $field, $value)`),
  `hook_theme()` (`ai_cijo_explain`). `hook_uninstall()` clears the `ai_cijo` private tempstore.
- **Value object** `Orchestration\OrchestrationState` (attached to the request as `ai_cijo_state`).
- **Library** `ai_cijo/explain` (explain page CSS/JS). Template `ai-cijo-explain.html.twig`.

## Runtime pipeline (RequestSubscriber::onRequest)

Main HTML request only → skip if `!enabled`, XHR, path under `/admin/ai-cijo` or
`/sites/default/files/`, or non-HTML → match by node/content-type, URL wildcard, or controller
fallback → `VisitorSignalCollector::collect()` (path, referrer, roles, language, timestamp) →
detector `detect()` → `OrchestrationEngine::buildState()` (aggregates matching mappings) →
`$request->attributes->set('ai_cijo_state', $state)` → if `explain`, persist to private tempstore.
