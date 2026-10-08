<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI-CIJO — settings, targeting, and the runtime pipeline

## Install / enable

- `drush en ai_cijo` (core `block` + `views` are hard deps). Disabled by default: `enabled: false`
  in `config/install/ai_cijo.settings.yml`.
- Configure at **`/admin/config/ai/ai-cijo`** (`ai_cijo.settings` route, `Form\AiCijoSettingsForm`,
  `_permission: 'administer ai cijo'`; menu link under `ai.admin_settings`).
- Three journey mappings are installed by default (`config/install/ai_cijo.mapping.*.yml`:
  `browse_awareness`, `compare_consideration`, `return_retention`), each with empty actions.

## Config object `ai_cijo.settings` (schema `config/schema/ai_cijo.schema.yml`)

- `enabled` (bool) — master switch; the subscriber returns immediately when false.
- `detector` (string) — IntentDetector plugin id; defaults to `fallback`. `AiCijoSettingsForm`
  builds the select from `IntentDetectorManager::getDefinitions()`. If the stored id has no
  definition at runtime, the subscriber falls back to `fallback`.
- `explain` (bool, default true) — when true, each evaluated request writes its result to private
  tempstore for the explain page.
- `targeting` (mapping):
  - `run_on_nodes` (bool) — evaluate node canonical pages.
  - `run_on_controllers` (bool) — evaluate any other route as a fallback match.
  - `content_types` (string[]) — allowed node bundles; empty = all bundles.
  - `url_patterns` (string[]) — wildcard patterns, one per line (e.g. `/blog/*`).

`AiCijoSettingsForm::submitForm()` normalizes the `url_patterns` textarea (split on newlines,
trim, drop empties) and the `content_types` checkboxes (drop unchecked) before saving. Content-type
options come from `NodeType::loadMultiple()`.

## Targeting logic — `EventSubscriber\RequestSubscriber::onRequest()` (`kernel.request`, priority 30)

1. Skip sub-requests (`HttpKernelInterface::MAIN_REQUEST` only).
2. Return if `!enabled`.
3. Return if `$request->isXmlHttpRequest()`.
4. Return if path starts with `/admin/ai-cijo` or `/sites/default/files/`.
5. Return if `$request->getRequestFormat() !== 'html'`.
6. Match:
   - **Node**: if `run_on_nodes` and the route `node` param is a `NodeInterface`, match when
     `content_types` is empty or contains `$node->bundle()`.
   - **URL wildcard**: else, for each `url_patterns` entry build
     `'#^' . str_replace('\*', '.*', preg_quote($pattern, '#')) . '$#'` and `preg_match` the path.
   - **Controller fallback**: else, if `run_on_controllers`, match unconditionally.
7. If matched: `signals = collector->collect()`; pick detector (fallback if missing);
   `ai = detector->detect(signals)`; `state = engine->buildState(ai)`;
   `$request->attributes->set('ai_cijo_state', $state)`.
8. If `explain`: write `['timestamp','path','data'=>$ai,'state'=>{...}]` to the current user's
   `ai_cijo` private tempstore key `last_explain`.

## Signals — `Context\VisitorSignalCollector::collect(array $override = [])`

Returns `path` (current path stack), `referrer` (`referer` header), `roles`
(`currentUser->getRoles()`), `language` (current langcode), `timestamp`. An `$override` array
replaces live values; when `override['simulated']` is truthy it also sets
`excluded_from_simulation = ['cookies','session','request headers (except referer)']`. Used by the
simulation form to run the pipeline for an arbitrary path (see api/explain.md). No PII is collected
or stored beyond these request-scoped values.

## Applying the state — hooks in `ai_cijo.module`

- `hook_block_view_alter($build, $block)`: reads `ai_cijo_state` off the current request; if the
  block's `getPluginId()` is in `$state->hideBlocks`, replaces `$build` with empty `#markup` while
  preserving cacheability (`CacheableMetadata::createFromRenderArray()` → `applyTo()`).
- `hook_views_pre_view(ViewExecutable $view)`: if `$state->viewFilters[$view->id()]` exists and the
  query plugin has `addWhere()`, calls `$view->query->addWhere(0, $field, $value)` for each
  configured field/value (guards non-SQL backends like Search API).
- `show_blocks`, `layout_variant`, and `cta` are carried on the state for themes/custom code to
  consume; the module itself does not force-render blocks or alter Layout Builder sections.
