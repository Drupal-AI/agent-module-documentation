<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & public API

## Services (`swiper_formatter.services.yml`)

| Service id | Class | Role |
|---|---|---|
| `swiper_formatter.base` | `Service\Swiper` (implements `SwiperInterface`) | builds/renders sliders; used by every formatter and the Views style |
| `swiper_formatter.dialog` | `Service\SwiperDialog` (implements `SwiperDialogInterface`) | builds the modal/dialog slide output |
| `swiper_formatter.updater` | `Service\SwiperUpdater` (autowired) | config-schema migration helper used by `swiper_formatter.post_update.php` |

## `swiper_formatter.base` (`SwiperInterface`)

Key public methods (call `\Drupal::service('swiper_formatter.base')` or inject
`@swiper_formatter.base`):

- `renderSwiper($entity, array $output, array $settings, array $theme_functions = []): array`
  — the main entry point: wraps slide render arrays in the `swiper_formatter` theme, attaches
  the Swiper JS library for `$settings['source']`, and applies options. Invokes
  `hook_swiper_formatter_settings_alter()`.
- `renderSwiperSlide($entity, array $settings, array $item): array` — one slide (`swiper_formatter_slide` theme).
- `processElements($field_definition, $entity, array $settings, array $output): array` —
  normalises formatter output into `['output' => …, 'settings' => …]` slides.
- `processSettings($field_definition, array $settings): array` — merge/resolve template + settings.
- `getSwiper(string $swiper_id): ?EntityInterface` — load a Swiper template config entity.
- `getCaption(array &$item, ?string $caption_field, ?$entity, int $delta)` — set a slide caption from a field.
- `tokenValue(string $markup, $entity): string` — run a string through Token replacement for that entity.
- `getDestination($field_definition): array` / `getImageStyle($id)` / `getViewModeOptions($type,$bundle)` /
  `getFieldDefinitions($field_definition)` / `getDisplay($entity,$view_mode)` /
  `elementId(...)` (unique DOM id) / `validateTemplates()`.

`SwiperInterface::DEFAULT_SETTINGS` = `['template' => 'default', 'caption' => NULL,
'destination' => NULL, 'swiper_access' => FALSE]` — the base formatter defaults.

## Config-entity static API (`Entity\SwiperFormatter`)

- `SwiperFormatter::getSwipers(bool $check_breakpoint = FALSE): array` — all templates keyed
  by id, each `['id','label','properties']`; pass TRUE to exclude breakpoint-only templates.
- `SwiperFormatter::getSwiperTemplates(bool $check_breakpoint = FALSE): array` — id → label map
  (for form `#options`).
- Instance: `getSwiperOptions()`, `setSwiperOptions(array)`, `isBreakpoint()`, `setSwiper(array)`.
- `preCreate()` seeds new entities from the `default` template (deep merge).

Programmatic slider from code: load/create a `swiper_formatter` template, then set the field's
formatter to one of the `swiper_formatter_*` ids on the view display, or call
`renderSwiper()` directly with your own slide render arrays.
