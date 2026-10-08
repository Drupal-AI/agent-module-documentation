<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Builder service, delivery value objects, and cache invalidation

## `responsive_video_style.builder` (`src/ResponsiveVideoBuilder.php`)

The core service. Constructor args (see `responsive_video_style.services.yml`): `entity_type.manager`,
`breakpoint.manager`, `plugin.manager.video_provider`, `file_url_generator`, the module logger,
`video_style.delivery_builder`, `video_style.preparation`, `video_style.media_source_resolver`.

Three public entry points, all returning a `Drupal\video_style\ValueObject\VideoDelivery`:

- **`buildForMedia(MediaInterface $media, ResponsiveVideoStyleInterface $style, AccountInterface $account, array $context = []): VideoDelivery`**
  — resolves the Media source/File through Video Style's `MediaSourceResolver` (this is the
  access-aware entry point: pass the viewing account), then composes portable delivery. Returns an
  empty-but-cacheable delivery when the source has no file. Use this for access-checked, consumer-
  facing delivery.
- **`buildDelivery(FileInterface $file, ResponsiveVideoStyleInterface $style, array $attributes = [], array $context = []): VideoDelivery`**
  — composes **portable native delivery without preparing assets** and **without rendering Twig or
  calling provider HTTP**. It assumes an already-authorized File (no access check of its own), so
  callers must resolve access first (that is what `buildForMedia()` does). Read-only mode
  (`_delivery_read_only = TRUE`) uses the base `deliveryBuilder->build()`. Canonicalizes local source
  URLs to absolute, and adds top-level + per-variant `structured_sources`.
- **`buildRenderData(FileInterface $file, ResponsiveVideoStyleInterface $style, array $base_video_attributes = [], array $context = []): array`**
  — the HTML path used by the formatter. Explicitly `preparation->prepare()`s each selected Video
  style first (so queue-backed providers can schedule derivative/poster work), composes with
  `_delivery_read_only = FALSE` (uses `deliveryBuilder->buildForRendering()`), and returns the
  delivery array plus a `cacheability` key.

### Composition (`compose()`)

Loads the style's Video styles, instantiates each provider (`plugin.manager.video_provider`), and
resolves a single **render mode** and **responsive strategy** across them. If a constituent provider
throws during init, it is dropped from the active set but retained as an **unsupported** per-style
delivery with `max-age 0`, so healthy constituents keep composing while the aggregate stays
uncacheable (1.1.x resilience). Returns `[]` when the strategy/render-mode don't resolve or don't
match the configured strategy. Branches:

- `native` + `source` → `sources` (ordered `buildSources()`), `poster_url`
  (`buildSourcePosterUrl()`, fallback styles first then mapped), `cache_tags`.
- `native` + `variant` → `variants` (`buildVariants()`: per-breakpoint `<video>` descriptors with
  playback attributes + optional poster; original file appended as final fallback variant).
- non-`native` (`provider_rendered`) → only valid for `variant`; `buildRenderedVariants()` collects
  each provider's `buildProviderElement()` render array as `content`.

### Returned `VideoDelivery` shape (`toArray()`)

Keys include `strategy`, `render_mode`, `sources`/`variants`, `poster_url`, `style_id`, `supported`
(true only when all constituents are native + supported), `playback` (video tag attributes),
`fallback_text`, `cache_tags`, a `deliveries` map keyed `styleId:breakpointPluginId|fallback`, and
`structured_sources` (records of `url`, `mime_type`, `codecs`, `media_query`, `width`, `height`,
`duration` — projected from derivative metadata, **not** parsed from the HTML `type` string).
Intrinsic `width`/`height`/`duration` are nullable; original-fallback measurements are reused from
constituent snapshots (`originalMetadata()`). Memoization (`resolveDelivery()`) is scoped to one
composition + breakpoint context and keyed by style+breakpoint, never reused across Media/accounts.

## `responsive_video_style.support` (`ResponsiveVideoStyleSupport`)

Helper service used by the config entity (which is not container-instantiated): `sortMappings()`
(orders mappings by breakpoint weight then style weight, drops empties) and `calculateDependencies()`
(config deps on the breakpoint group's providers and every referenced Video style).

## Delivery cache-tag invalidation (`ResponsiveVideoDeliveryConfigSubscriber`)

`src/EventSubscriber/ResponsiveVideoDeliveryConfigSubscriber.php` (`@internal`, service
`responsive_video_style.delivery_config_subscriber`). Subscribes to config `SAVE`/`DELETE`/`RENAME`
and the three `ConfigCollectionEvents` equivalents. For any config name starting with
`responsive_video_style.responsive_video_style.` (and the old name on rename) it invalidates the
single provider-independent tag `Drupal\video_style\Cache\VideoDeliveryCacheTags::DELIVERY`
(`video_style_delivery`). This covers entity saves **and** direct Config API writes (including Drush)
and translated config overrides, and does **not** require the API submodule. The signal is broad and
may fire more than once per operation; it is not proof a surrounding transaction committed.

## Dependencies / version coupling

Requires `drupal/video_style:^1.1.3`. The delivery contract (`VideoDelivery`, `VideoDerivative`,
`VideoPoster`, `VideoMetadata`, `MediaSourceResolver`, `VideoDeliveryCacheTags`, provider strategy/
render-mode constants) is owned by Video Style; release Video Style first. Private front-end
integration is out of scope for this project. The optional `responsive_video_style_api` submodule
exposes selected styles over REST and JSON:API — not documented here.
