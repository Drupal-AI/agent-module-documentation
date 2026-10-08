<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Field Translation Synchronize copies entity-reference field values from an entity's original translation into its other translations, for reference fields whose translatability was turned on after translated content already existed.

---

When you enable "Users may translate this field" on an entity-reference field that already has translated entities, the existing translations get empty reference values. This module adds a synchronize fieldset to the field settings form and a bulk admin form at Configuration » Development » Synchronize Entity Reference Fields Translations. You choose an entity type, bundle and one or more translatable entity-reference fields; a batch loads all entities of that bundle, and for each translation copies the original field value into the translation (only empty values by default, or all values when the "Synchronize non empty values too" checkbox is set) before saving the translated entity.

Security note: the admin form route `ereftras.synchronize_form` is declared with `_access: 'TRUE'` (ereftras.routing.yml), so it is reachable by any user including anonymous, and its submit handler drives a batch that mutates and saves entities site-wide. This is a broken-access-control / unauthenticated state-mutation exposure — see the security line in start.md. There is no per-field permission gate on the bulk operation.
---
- Backfill empty translated entity-reference values from the original translation.
- Bulk-synchronize a specific entity type + bundle + field set from one admin form.
- Enable field-level translation on a reference field, then populate old translations.
- Choose to fill only empty translated values (default) or overwrite all values.
- Run the synchronization as a Batch API process for large content sets.
- Fix reference fields that lost values after enabling translation late.
- Synchronize multiple reference fields of one bundle at once.
- Add a synchronize fieldset to an entity-reference field's settings form.
- Restore consistency between default-language and translated reference data.
- Target nodes, taxonomy terms or any translatable content entity with reference fields.
- Preview available bundles/fields via the form's AJAX-driven selects.
- Keep translated entities pointing at the same referenced targets as the source.
- Migrate legacy multilingual sites where reference translation was enabled late.
- Re-run synchronization after importing untranslated reference data.
- Use the `ereftras.synchronize` service programmatically from custom code.
- Limit synchronization to a single field to avoid touching unrelated data.
- Audit which bundles expose translatable entity-reference fields.
