<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Resolution algorithm & cache model

How a rendered entity's display mode is chosen. Source: `src/Hook/EntityHooks.php`, `src/Resolver/DisplayModeResolver.php`, `src/Entity/DisplayModeSwitcherRuleStorage.php`, `src/Entity/DisplayModeSwitcherRule.php`.

## Entry points (hooks)
`EntityHooks` is an OOP hook class (`#[Hook]` attributes), service `display_mode_switcher.entity_hooks`, constructed with `DisplayModeResolverInterface`.

- `entityViewModeAlter(&$view_mode, $entity)` — `#[Hook('entity_view_mode_alter')]`. Calls `$this->resolver->resolve($entity, $view_mode)`, takes `$resolution->getDisplayMode()` as the target, stashes the resolution in `$pendingResolutions["{uuid}:{target}"]`, and sets `$view_mode = $target`.
- `entityView(&$build, $entity, $display, $view_mode)` — `#[Hook('entity_view')]`. Looks up the stash by `"{uuid}:{view_mode}"`; if found, merges its `CacheableMetadata` into `$build` (`CacheableMetadata::createFromRenderArray($build)->merge(...)->applyTo($build)`) and unsets the stash entry. If absent, returns without changes.

The stash + per-request resolver cache ensure the two hooks agree without re-evaluating conditions.

## Loading applicable rules — `DisplayModeSwitcherRuleStorage::loadApplicable()`
1. `loadByProperties(['status' => TRUE, 'entity_type' => $entity->getEntityTypeId(), 'source_display_mode' => $sourceMode])`.
2. `array_filter`: keep rules whose `getBundle() === ''` (any bundle) **or** `=== $entity->bundle()`.
3. `uasort` ascending by `getWeight()`.

## `DisplayModeResolver::doResolve()` (private; `resolve()` wraps it in a per-request cache keyed `"{type}:{id}:{sourceMode}"`)
1. Seed a `CacheableMetadata`. Add the storage entity type's **list cache tags** (invalidated on any rule create/delete).
2. Add two **scope tags** so renders cached before a rule existed still invalidate:
   - `display_mode_switcher_scope:{type}:{bundle}:{sourceMode}` (bundle-specific)
   - `display_mode_switcher_scope:{type}::{sourceMode}` (bundle-less / any-bundle)
3. `$rules = $storage->loadApplicable(...)`. For each rule in weight order:
   - **setEntity:** for every condition `instanceof DisplayModeSwitcherConditionPluginBase`, call `setEntity($entity)` — direct entity injection, no Context API.
   - **applyRuntimeContexts:** for every `ContextAwarePluginInterface` condition, fetch runtime contexts from `context.repository` and `context.handler->applyContextMapping()`. `MissingValueContextException` → skip silently (still cacheable). `ContextException` → `setCacheMaxAge(0)` and mark `missingContext = TRUE`.
   - **addCacheableDependency($rule):** called *after* contexts are applied, so the rule (which aggregates its conditions' cache metadata) contributes its own config tag plus condition contexts/tags/max-age.
   - **checkConditions:** if `!$missingContext` and all conditions pass, return `new DisplayModeResolution($rule->getTargetDisplayMode(), $cacheability)`.
4. No match → `new DisplayModeResolution($sourceMode, $cacheability)`.

`checkConditions()` is logical AND over `$condition->execute()` (honours negation); empty collection → TRUE (rule always matches). A `ContextException` during `execute()` → that condition counts as FALSE.

## `DisplayModeResolution` (value object, `final`)
Immutable; `getDisplayMode(): string` and `getCacheableMetadata(): CacheableMetadata`.

## Rule cache metadata (`DisplayModeSwitcherRule`)
- `getCacheContexts()` / `getCacheTags()` / `getCacheMaxAge()` — parent value merged with each condition's via `Cache::mergeContexts/mergeTags/mergeMaxAges`.
- `getCacheTagsToInvalidate()` — adds `display_mode_switcher_scope:{entity_type}:{bundle}:{source_display_mode}` (only when entity_type and source mode are set), mirroring the resolver's scope tags so saving/deleting a rule invalidates the right renders.

Net effect: cache metadata from **every evaluated rule** (matching or not) is accumulated, so any context change that could alter the outcome causes a cache miss.
