<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Autocomplete Plus — agent orientation

Decorates the core entity autocomplete matcher to append token info to suggestions.

- Version 4.0.x, core ^9||^10, depends on `drupal:token`.
- `EntityAutocompletePlusServiceProvider` replaces `entity.autocomplete_matcher` with `EntityAutocompletePlusMatcher extends EntityAutocompleteMatcher`.
- Suggestions are produced by the field's selection handler, which enforces access — no accessCheck bypass observed.
- Config route `/admin/config/content/entity_autocomplete_plus` (`administer site configuration`).
- Token suffix injected via widget third-party setting `token_string` → `#selection_settings['token_string_suffix']`.
