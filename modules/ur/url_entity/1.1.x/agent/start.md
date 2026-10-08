<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Url Entity (url_entity) — agent index

One service that resolves a URL to the entity it points at, plus a Twig extension exposing the
same four resolvers as filters. **No module dependencies, no routes, no permissions, no config,
no hooks.** `php: 7.4`. Core requirement `^9 || ^10 || ^11`.

Key facts:
- Files: `src/UrlEntityExtractor.php`, `src/UrlEntityExtractorInterface.php`,
  `src/Twig/UrlEntityExtension.php`, `url_entity.services.yml`, `.info.yml`, `LICENSE.txt`.
- **It is a library, not a feature.** Enabling it changes nothing user-visible; it exists so
  another module can inject the extractor service (or a template can call its filters) instead of
  writing its own path parsing.
- Resolution goes through Drupal's router (`@router.no_access_checks`) rather than string-splitting
  the path, which is why it handles path aliases, language prefixes and non-node entity types that
  naive `explode('/', $path)` helpers get wrong.
- **New in 1.1.x:** the Twig extension `Drupal\url_entity\Twig\UrlEntityExtension`
  (service `url_entity.twig_extension`) registers filters `current_entity`, `referer_entity`,
  `entity_by_route`, `entity_by_url`, all backed by the same extractor.
- If a site has it enabled and nothing depends on it, it is dead weight — check
  `composer why drupal/url_entity` before removing.

Services:
- `url_entity.extractor` → `Drupal\url_entity\UrlEntityExtractor`
  (autowire type `Drupal\url_entity\UrlEntityExtractorInterface`).
- `url_entity.twig_extension` → `Drupal\url_entity\Twig\UrlEntityExtension` (tagged `twig.extension`).

Capabilities:
- [API — the extractor service](api/extractor.md) — service id `url_entity.extractor`, its
  four methods (`getCurrentEntity`, `getRefererEntity`, `getEntityByRoute`, `getEntityByUrl`),
  and how resolution behaves.
- [Twig filters](twig/filters.md) — `current_entity`, `referer_entity`, `entity_by_route`,
  `entity_by_url` and their argument shapes.
