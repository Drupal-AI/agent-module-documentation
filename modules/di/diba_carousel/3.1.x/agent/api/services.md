<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services and interfaces

The block plugin is thin; the work lives in four services (each with an interface), declared in
`diba_carousel.services.yml`. All are injected into `DibaCarousel::create()`. You can reuse them
from your own code via `\Drupal::service('diba_carousel.<id>')`.

## `diba_carousel.options_provider` — `CarouselOptionsProvider`
`src/Service/CarouselOptionsProvider.php` (interface `CarouselOptionsProviderInterface`). Discovers
the choices shown in the settings form. Key methods:
- `getEntityTypes()` — every `ContentEntityType` with a `field_ui_base_route` (fieldable types).
- `getFields($entity_type, $grouped)` — field storage definitions as `label (name)` options,
  optionally grouped by field type (memoised per entity type in `$fieldStorageDefinitions`).
- `getFieldsByType(array $types, $entity)` / `getImageFields($entity)` — filter fields by type;
  `getImageFields()` also includes entity-reference fields targeting image media bundles.
- `getImageStyles()` / `getResponsiveImageStyles()` — id⇒id option lists (responsive returns
  `[]` unless `responsive_image` is enabled).
- `getPublishingOptions($entity_type)` — `status` / `promote` / `sticky`, plus every
  `custom_publishing_option` entity label when the node type is `node` and `custom_pub` is on.
- `getEntityTypeBundles($entity)` / `getValidBundles(array $bundles, $entity)` — bundle option
  list and a validator that drops non-existent bundles (used before adding the query condition).

## `diba_carousel.query_builder` — `CarouselQueryBuilder`
`src/Service/CarouselQueryBuilder.php` (interface `CarouselQueryBuilderInterface`). One public
method, `getQueriedEntities(array $config, ?EntityInterface $context_entity = NULL): array`,
builds and runs the entity query and returns loaded entities. See
[../blocks/diba_carousel.md](../blocks/diba_carousel.md) for the condition/order/limit logic and
the `[query:...]` / `[argument:...]` token resolution (via `request_stack` and `path.current`).
It executes with `accessCheck(FALSE)`; per-entity `view` access is enforced downstream in the
slide builder.

## `diba_carousel.slide_builder` — `CarouselSlideBuilder`
`src/Service/CarouselSlideBuilder.php` (interface `CarouselSlideBuilderInterface`). Turns queried
entities into render-ready slide arrays.
- `getItems(array $config, array $entities)` — filters by `$entity->access('view')`, resolves the
  current-language translation, and fans out per `image_multi_strategy` (`first`/`last`/`rand`/
  `all`).
- `composeSlide(array $config, $entity, int $image_num = 0)` — builds one slide:
  - **title**: `strip_tags((string) $entity->{title_field}->value)`.
  - **description**: entity-reference field → comma-joined referenced-entity labels; otherwise the
    field `->value`. When `description_allow_html` is on and the item has a text `format`, it is
    rendered via a `#type => processed_text` element (`renderer->renderInIsolation()`), so the
    field's own text format applies; with no format it is run through `Xss::filterAdmin()`. When
    off, `strip_tags()` is applied. The result is then optionally truncated on a word boundary
    (`Unicode::truncate`, `Html::normalize` for HTML), trimmed, low-char-stripped
    (`filter_var(..., FILTER_UNSAFE_RAW, FILTER_FLAG_STRIP_LOW)`), normalised to UTF-8
    (`Unicode::convertToUtf8`), and given an optional "See more" canonical link.
  - **image**: `resolveImageFieldUri()` reads the file uri from an image field item or a media
    reference (via the media source's `source_field`); falls back to the field's `default_image`
    uuid. Applies a responsive image style (`#theme => responsive_image`) when configured and
    `responsive_image` is enabled, else a regular `image_style` (building the derivative on demand
    with `createDerivative()`); width/height come from `image.factory`.
  - **url / url_image**: `getSlideUrl()` — see [../blocks/diba_carousel.md](../blocks/diba_carousel.md).

## `diba_carousel.form_builder` — `CarouselFormBuilder`
`src/Service/CarouselFormBuilder.php` (interface `CarouselFormBuilderInterface`). Builds the
grouped block settings form.
- `buildSettingsForm(array $form, array $config, array $defaults, string $entity_type_for_form)` —
  assembles the `diba_carousel_settings` fieldset with **Content selection and ordering**,
  **Slide fields**, **Carousel styling** and a nested **Class attributes** details group, using
  the options provider for every select. `#states` show conditional fields (operators, image
  strategy/styles, description sub-options, more-link text).
- `getConfigFieldMap()` — maps each flat config key to its nested form path; `DibaCarousel::blockSubmit()`
  iterates it to persist values, so form and config never drift.
