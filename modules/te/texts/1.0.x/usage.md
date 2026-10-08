<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Texts is a key-based string-translation system: you call `getTexts('some.key', ...)` (or a Twig `|getTexts` filter, or GraphQL) instead of core's `t()`, and each key/context becomes a translatable `texts` content entity managed through a locale-style admin UI.

---

The module defines a `texts` content entity (base table `texts`, data table `texts_field_data`) with fields `key`, `context` (a `list_string` whose allowed values are the distinct contexts already in the database, defaulting to `default`), `translation` (a translatable `string_long`), and a `plural` boolean; a composite unique key on `(key, context, langcode)` guards against duplicate rows. The runtime entry point is the `texts.translator` service (`TextsTranslator`) and its convenience wrappers — the global `getTexts()` / `getTextsPlural()` functions in `texts.module`, the `TextsTranslationTrait`, and Twig filters `getTexts` / `getTextsPlural` registered by `Drupal\texts\Twig\TextsExtension`. `TextsTranslator::trans()` loads the entity for the current language by key+context via `TextsStorage::loadByKey()`; **if the key does not exist it creates and saves a new `texts` entity on the fly** using the supplied `default_translation`, so calling a key is enough to seed it. Plural strings are stored as a single field with singular and plural joined by `PoItem::DELIMITER`; placeholder substitution reuses core's `TranslatableMarkup`/`PluralTranslatableMarkup` (subclassed as `TextsTranslatableMarkup` / `TextsPluralTranslatableMarkup`). The admin surface lives at `/admin/content/texts`: a `TextsListBuilder` collection plus a bespoke locale-style overview (`TranslationFilterForm` + `TranslationEditForm`, rendered by `TextsController::translatePage`) that lets you filter by string/keys/language/context and inline-edit every language at once (this bulk form runs `locale_string_is_safe()` on submitted values). Settings at `/admin/config/regional/texts` (`SettingsForm`, config `texts.settings`) only let you hide chosen languages from the overview. CSV round-tripping is provided by `TextsExportController::export` (`/admin/config/regional/texts/export`, uses `league/csv`, `;`-delimited, one row per singular/plural form) and `TextsImportForm` (`/admin/config/regional/texts/import`, batched via a key-value store). Two Drush commands — `texts:cleanup-duplicates` and `texts:delete-duplicates` — back up and remove rows whose keys collide, renaming them with a `__duplicate_{id}` suffix that the admin UI / `TextsController::restoreDuplicate` can restore. The optional `texts_graphql` submodule (requires `graphql:graphql`) exposes `getText`, `getTextPlural`, and `getTextMultiple` Query fields plus a `textsLoader` type so a decoupled front end fetches the same strings the Drupal side uses.

---

- Replace hard-coded UI strings with key-based lookups via `getTexts('login.button')`.
- Manage a call-to-action label or disclaimer centrally instead of in templates.
- Serve frontend translations to a decoupled (React/Vue/mobile) front end over GraphQL.
- Fetch a single string with the `getText(key, default, context)` GraphQL query.
- Batch-fetch many strings for a page with `getTextMultiple`.
- Auto-seed a translation the first time a key is requested, using its `default_translation`.
- Translate UI strings into every enabled language from one inline overview form.
- Use `context` to disambiguate the same key across different areas of a site.
- Handle singular/plural wording with `getTextsPlural($count, key, singular, plural)`.
- Interpolate placeholders like `@name` in a stored string, as with `t()`.
- Render a key inside a Twig template with the `{{ 'key'|getTexts }}` filter.
- Export all strings to CSV for translation in an external tool, then re-import.
- Bulk-load a CSV of translations across all languages via the batched import form.
- Filter the overview by key, free text, language, or context.
- Hide languages you do not translate from the overview via the settings form.
- Give editors a curated string workflow separate from core's locale interface.
- Keep repeated wording consistent across content types and blocks.
- Clean up duplicate string rows with `drush texts:cleanup-duplicates`.
- Restore a mistakenly-duplicated string back to its original key from the admin UI.
- Provide translatable microcopy (form help text, tooltips) editable without a deploy.
- Add a `TextsTranslationTrait` to a service/controller to translate without the global function.
