<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Autocomplete widget with mixed matching gives entity reference fields an autocomplete that lists prefix matches first and then fills the remaining suggestion slots with substring matches, so the exact thing you started typing stays at the top.

---

Core's entity reference autocomplete uses a single matching operator per field: **STARTS_WITH**, which finds "Smith" from "Smi" but misses it from "mith", or **CONTAINS**, which finds it either way but buries the exact match under everything else that happens to contain the string. This module keeps both. Its widget (`autocomplete_mixed_matching`, a subclass of core's `EntityReferenceAutocompleteWidget`) hard-codes the primary operator to **STARTS_WITH** and adds a **CONTAINS** fallback: it asks the selection handler for prefix matches first, and only if fewer than the configured match limit come back does it run a second query for substring matches and append them, de-duplicated by entity id and trimmed to the limit. The two-query fallback is made possible by a decorator of core's `entity.autocomplete_matcher` service (`AdvancedEntityAutocompleteMatcher`), which understands an extra `fallback_match_operator` selection setting; the decorator is registered site-wide but only changes behaviour for fields whose selection settings carry that extra key, which in practice means only this module's widget, so ordinary core autocomplete fields are unaffected. All matching, sorting and — importantly — **entity access filtering** are delegated to the core entity reference selection handler via `getReferenceableEntities()`; the module neither writes SQL nor relaxes the access query, so suggestions still respect what the current user may reference. To use it, edit an entity's form display (Manage form display), and for any entity reference field choose the "Autocomplete, mixed matching" widget; the widget's settings are the same as core's minus the match-operator selector, which is fixed. Requires no configuration entity, no permissions, and no dependencies beyond Drupal 10.2+/11 and PHP 8.1. Note that the CONTAINS half of the query uses a leading wildcard and cannot use a normal index, so on very large reference targets it should be benchmarked on production-sized data.

---

- Rank exact prefix matches above substring matches in a reference field.
- Find a taxonomy term by a distinctive fragment from the middle of its name.
- Improve a large author or staff lookup where names share common prefixes.
- Match a product or node by part of its title without losing the exact hit.
- Avoid empty autocomplete results when every label starts with "The" or a number.
- Keep the exact match visible instead of buried, as plain CONTAINS would bury it.
- Replace core's autocomplete widget on an entity reference field, one field at a time.
- Match a company by its second word (e.g. type "systems" to find "Acme Systems").
- Reduce failed lookups in a member or contact directory.
- Improve editorial search when curators half-remember a title.
- Match a location by a district or suburb name inside a longer place name.
- Support imprecise recall in a tag field with many terms.
- Find content referenced from a paragraph or node reference field by a mid-title phrase.
- Give a media reference field prefix-first, substring-fallback matching.
- Match an SKU or partial identifier that appears mid-string.
- Configure per field on the Manage form display screen with no site-wide change.
- Keep core's entity access filtering on suggestions while broadening the match.
- Tune the maximum number of suggestions via the widget's match-limit setting.
- Offer a friendlier autocomplete on a multilingual site (matches labels across languages).
- Drop-in upgrade for any existing entity reference autocomplete field.
