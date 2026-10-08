<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Preprocess plugin + lazy-builder service

Two classes implement the whole runtime: a Preprocess plugin that rewrites field render arrays, and
a service that is the `#lazy_builder` callback.

## Preprocess plugin — `src/Plugin/Preprocess/LazyBuilder.php`

- `@Preprocess(id = "big_pipe_paragraphs.lazy_builder", hook = "field")`, extends the Preprocess
  module's `PreprocessPluginBase`. It runs on **every** `template_preprocess_field` invocation, so
  the early-return guards matter for cost.
- `preprocess(array $variables)` guards, in order:
  1. `$element['#field_type'] !== 'entity_reference_revisions'` → return unchanged.
  2. field storage `getSetting('target_type') !== 'paragraph'` → return unchanged.
  3. `$element['#object']` not an `EntityInterface`, **or**
     `!$lazyBuilderManager->bundleEnabled($entityTypeId, $field_name, $bundle)` → return unchanged.
- If enabled, it reads `getOffset()` and `getSkipBundles()` once, then loops `$variables['items']`:
  - `$paragraph = $item['content']['#paragraph']`; `$view_mode = $item['content']['#view_mode']
    ?: 'default'`.
  - **Keep inline** (`continue`) when `$delta < $offset` **or** the paragraph bundle is in the
    skip list.
  - Otherwise replace the whole item content with:
    ```php
    $item['content'] = [
      '#lazy_builder' => ['big_pipe_paragraphs.lazy_builder:lazyBuild', [$paragraph->id(), $view_mode]],
      '#create_placeholder' => TRUE,
    ];
    ```
- Because it relies on `$item['content']['#paragraph']` existing, a template that renders the field
  via `field_paragraph | field_value` (Twig field_value) bypasses this item structure and the
  module silently does nothing — this is the README's documented caveat.

## Service — `src/LazyParagraphBuilder.php` (`big_pipe_paragraphs.lazy_builder`)

Constructed with `@entity_type.manager` + `@config.factory` (`big_pipe_paragraphs.services.yml`);
constructor caches `big_pipe_paragraphs.settings:entity_type` into `$this->config`.

- `lazyBuild(int $paragraphId, $viewMode): array` — the trusted `#lazy_builder` callback
  (`trustedCallbacks()` returns `['lazyBuild']`). Loads the paragraph via the `paragraph` storage
  and returns `paragraphViewBuilder->view($paragraph, $viewMode)`. This is what BigPipe / Dynamic
  Page Cache execute out-of-band to fill each placeholder.
- `bundleEnabled($entityTypeId, $fieldName, $bundle): bool` — `in_array($bundle,
  config[type][field]['entity_bundles'], TRUE)` (strict), FALSE when unset.
- `getOffset($entityTypeId, $fieldName): ?int` — `(int) config[...]['offset']`, or NULL when the
  (type,field) pair is absent.
- `getSkipBundles($entityTypeId, $fieldName): array` — `config[...]['skip_bundles']`, or `[]`.

## Operating notes

- **No offset configured / offset 0**: every paragraph in the field (past delta 0) is deferred.
- **View mode** is taken from the pre-built item (`#view_mode`), defaulting to `default`, and passed
  through to `lazyBuild` so the streamed render matches the display.
- Cacheability: the placeholder's content is rendered by `lazyBuild()` at flush time; the paragraph
  view builder bubbles the paragraph's own cache tags/contexts when the placeholder runs.
- The `#lazy_builder` args are `[paragraph id, view mode]` sourced from the already-built field
  render (not from the request), and the callback is reachable only through the placeholder system —
  there is no route that invokes it with caller-supplied input.
