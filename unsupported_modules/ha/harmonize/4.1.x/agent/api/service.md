<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Harmonize service & extension points

## The `harmonize` service
`Drupal\harmonize\Service\Harmonize` (`src/Service/Harmonize.php`) is the entry point used across the module and from custom code to harmonize entities/objects into the `harmony` data structure. It is wired with helpers, theme manager, module handler, event dispatcher, config factory, admin route context, current route match, the `cache.harmonize` bin, language manager, file url generator and logger.

## Harmonizers
Per-type classes under `src/Harmonizer/EntityHarmonizer/` (Node, Media, File, Paragraph, TaxonomyTerm, MenuLinkContent, ImageStyle) plus Menu/Region harmonizers, assembled through `MasterHarmonizerFactory` / `HarmonizerFactory`. Each produces the normalised array exposed as `{{ harmony }}` in templates.

## Events (alter the output)
`src/Event/`: `EntityHarmonizationEvent`, `EntityFieldHarmonizationEvent`, `FormHarmonizationEvent`, `MenuHarmonizationEvent`, plus `HarmonizationEventFactory`. Subscribe to reshape harmonized data. See `harmonize.api.php` for documented hooks/events.

## Config entities & UI
- `Style` config entity — reusable field-render styles (autocomplete of entity fields via `EntityFieldsAutoCompleteController`).
- `EntitySettings` — per-bundle preprocessing config; "Manage preprocessing" tab gated by `_manage_preprocessing_access_check`.
- Entity Processing Rules forms and a Cache config form under `/admin/config/harmonize/*`.

## Twig
`HarmonizeTwigExtension` (`src/Twig/HarmonizeTwigExtension.php`) registers the functions/filters for reaching harmonized data.

## Access
Every route requires `administer site configuration`; the autocomplete controller is likewise gated. Nothing here is anonymous or public.
