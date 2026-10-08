<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Visibility service, subscriber & preprocess — render-time hiding

All three entry points funnel through one method:
`Drupal\layout_builder_context\Utility\Visibility::evaluate($build, array $contexts, bool $all_must_pass)`
(service id `layout_builder_context.visibility`, constructed with `@context.manager`, i.e.
`Drupal\context\ContextManager`).

## Who calls `evaluate()`

- **Blocks/components** — `EventSubscriber\BlockComponentRenderArraySubscriber::onBuildRender()`,
  subscribed to `LayoutBuilderEvents::SECTION_COMPONENT_BUILD_RENDER_ARRAY` at priority **50**.
  It reads `context_visibility` and `context_all_must_pass` off `$event->getComponent()` (a
  `SectionComponent`) and calls `evaluate($build, $contexts, $rule)`.
- **Sections/layouts** — `layout_builder_context_preprocess_layout(&$variables)` in the `.module`.
  It reads `$variables['settings']['context_visibility']` / `['context_all_must_pass']` and calls
  `evaluate($variables, …)` on the whole layout `$variables` array.
- Both callers **skip preview**: the subscriber returns early when `$event->inPreview()` is true;
  the preprocess hook runs only when `!$variables['in_preview']`. So visibility filtering happens
  only on the live/front-end render, never inside the Layout Builder UI.
- Both callers no-op when `context_visibility` is empty or not an array.

## What `evaluate()` does (`Visibility.php`)

For each `$context_id` in `$contexts`:

1. Loads the Context via `contextManager->getContext($context_id)`. **Unknown IDs are skipped**
   (the `instanceof Context` guard) — a stale/deleted Context ID simply does nothing.
2. Records the ID in `$build['#context_visibility'][]` (informational marker in the render array).
3. Computes visibility:
   `$visible = !(!$context->disabled()) || $this->contextManager->evaluateContextConditions($context);`
   Simplified this is **`$visible = $context->disabled() || evaluateContextConditions($context)`** —
   i.e. a **disabled Context always passes**, otherwise the Context's *conditions* decide. Only
   conditions are consulted; **Reactions are never invoked**.
4. Merges the Context's **cache contexts** and **cache tags** into `$build['#cache']` via
   `Cache::mergeContexts()` / `Cache::mergeTags()`, and (when `$build['content']` exists) folds the
   content's `CacheableMetadata` up into `$build`. This keeps a hidden/shown decision correctly
   cache-varied even for a disabled Context (its config cache tag still lands on the build — see the
   kernel test `VisibilityTest`).
5. **Hides** only when `!$visible && $all_must_pass`: it sets `$build['content'] = []` and
   `$build['content']['#access'] = FALSE`, so core's renderer drops the content.

## The `all_must_pass` semantics (careful)

- `context_all_must_pass = TRUE` (default): each failing, enabled Context sets `#access = FALSE`.
  Because the loop overwrites `content` per iteration, the practical effect is **AND** — any single
  enabled Context whose conditions fail hides the item.
- `context_all_must_pass = FALSE`: the hide branch never runs, so **content is never removed**,
  regardless of which Contexts fail. The in-UI help text states this: "if all Contexts fail but this
  is not required, this item will be visible." Treat FALSE as "advisory / do not hide."

## Notes

- This drives **render visibility**, not an access-control boundary. Hidden content is removed from
  the render array for that request; it is not a substitute for entity/field access. Documentation
  scenarios about "content personalization / A/B" are the intended use.
- No user- or request-supplied data is fetched, deserialized, or rendered here; there are no
  routes, no external HTTP, and no queries. Evaluation delegates entirely to the Context module.
