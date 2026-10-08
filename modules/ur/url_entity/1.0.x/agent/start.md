<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Url Entity (url_entity) — agent index

One service that resolves a URL to the entity it points at. **No dependencies, no routes, no
permissions, no config, no hooks.** `php: 7.4`. Core requirement `^9 || ^10 || ^11`.

Key facts:
- Whole module: `src/UrlEntityExtractor.php`, `src/UrlEntityExtractorInterface.php`,
  `url_entity.services.yml`, `.info.yml`, `LICENSE.txt`.
- **It is a library, not a feature.** Enabling it changes nothing user-visible; it exists so
  another module can inject the extractor service instead of writing its own path parsing.
- Resolution goes through Drupal's router rather than string-splitting the path, which is why
  it handles path aliases, language prefixes and non-node entity types that naive
  `explode('/', $path)` helpers get wrong.
- If a site has it enabled and nothing depends on it, it is dead weight — check
  `composer why drupal/url_entity` before removing.

Capabilities:
- [API — the extractor service](api/extractor.md) — service id `url_entity.extractor`, its
  four methods (`getCurrentEntity`, `getRefererEntity`, `getEntityByRoute`, `getEntityByUrl`),
  and how resolution behaves.
