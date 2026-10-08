<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Generating custom elements

Service `custom_elements.generator` = `Drupal\custom_elements\CustomElementGenerator`.

## Entry points

- `generate(ContentEntityInterface $entity, string $viewMode, ?string $langcode = NULL, ?AccountInterface $account = NULL): CustomElement`
- `generateMultiple(array $entities, string $viewMode, …): CustomElement[]` — keyed like input.
- `generateWithCeDisplay($entity, EntityCeDisplayInterface $display, …)` /
  `generateMultipleWithCeDisplay(...)` — force a specific Custom Elements Display.
- `buildEntityContent($entities, $viewMode, $account)` — without translation resolution.
- `getEntityDefaults($entity, $viewMode)` / `getViewModeDefaults($type, $bundle, $viewMode)` —
  a bare `CustomElement` with the default tag (`{entity}-{bundle}-{view_mode}` or
  `{entity}-{view_mode}` for bundleless types) and `hook_custom_element_entity_defaults_alter`
  applied.

`generateMultiple()` resolves each entity's translation from context, then dispatches to
`doBuildEntityContent()`.

## Build-path selection (per entity type + bundle)

`doBuildEntityContent()` loads the applicable `entity_ce_display` via
`getEntityCeDisplay($type, $bundle, $viewMode)` (requested view mode → `default` view mode →
auto-created in-memory display enabling all fields from the core view display). It sets the
element tag to the display's `customElementName`, then chooses **one** path:

1. **Canvas content template** — if a `content_template` config entity exists and is enabled for
   `{type}.{bundle}.{viewMode}` (`checkContentTemplate()`), it is built and converted via
   `custom_elements.canvas_render_converter` into a `components` slot
   (`buildContentTemplateContent()`), **then** CE-display fields are additionally processed.
2. **Layout Builder** — if the CE display's `useLayoutBuilder` is TRUE *and* the core view display
   also has `layout_builder.enabled` (`checkLayoutBuilderDisplay()`): layout sections become
   nested `<drupal-layout>` elements in a `sections` slot (`buildLayoutBuilderContent()`), **then**
   CE-display fields are additionally processed.
3. **Force auto-processing** — if the display's `forceAutoProcessing` is TRUE: entity-level
   processing only (the 2.x behaviour), via `process($entity, …)`.
4. **CE-display components (default in 3.x)** — `buildEntityComponentFields()`.

Finally `hook_custom_element_entity_alter($element, $entity, $viewMode)` runs for each entity.

## Component fields and access

`buildEntityComponentFields()` iterates the CE display's components; for each it gets the
formatter via `EntityCeDisplay::getRenderer()` and, **per entity**, checks
`fieldIsAccessible($entity, $field_name, $element, $account)` before adding the field's items.
`fieldIsAccessible()` (`CustomElementsProcessorFieldUtilsTrait`) returns FALSE for a missing/empty
field and otherwise checks `$field->access('view', $account, TRUE)` and records the access result
as a cacheable dependency. Formatters receive grouped items (`prepareBuild()` then `build()`).

## The processor system (auto-processing path)

`process($data, CustomElement $element, $viewMode, $key = '')` walks tagged
`custom_elements_processor` services (sorted by priority) and calls `addToElement()` on the first
whose `supports()` matches. Shipped processors (`src/Processor/*`):

- `DefaultContentEntityProcessor` (prio -100) — content entities; iterates the core view display's
  components, checking `fieldIsAccessible()` per field.
- `DefaultFieldItemListProcessor` (-100) — field item lists; delegates to per-item processing,
  collapsing single attribute/slot results to avoid wrapper tags.
- `DefaultFieldItemProcessor` (-100) — a single field item → attributes/slots.
- `FileReferenceFieldItemListProcessor`, `MediaReferenceFieldItemProcessor`,
  `ParagraphFieldItemProcessor`, `TextFieldItemProcessor` (-50) — type-specific handling.
  Media and paragraph processors check `entityIsAccessible()` (entity-level `view` access) before
  rendering the referenced entity; `TextFieldItemProcessor` emits `$item->processed` (the
  text-format-filtered value) as a slot, plus `summary_processed` as a `*-summary` slot.

Add your own by registering a service tagged `custom_elements_processor` implementing
`CustomElementProcessorInterface` (or `…WithKeyInterface`).

## Alter hooks (`custom_elements.api.php`)

- `hook_custom_element_entity_defaults_alter(CustomElement $element, EntityInterface $entity, $view_mode)`
- `hook_custom_element_entity_alter(CustomElement $element, EntityInterface $entity, $view_mode)`

Both receive the mutable `CustomElement` (e.g. `$element->setTagPrefix('myVendor')`).
