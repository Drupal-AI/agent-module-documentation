<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Texts (texts) — agent index

Key-based string translation. Instead of core's `t()`/locale, you call `getTexts('some.key', $args, $options)` and each `key` + `context` becomes a translatable `texts` **content entity** (not configuration — the old docs were wrong). Ships pluralization, placeholders, contexts, a locale-style overview UI, CSV import/export, Drush cleanup commands, Twig filters, and an optional `texts_graphql` submodule for decoupled front ends. Core `^8 || ^9 || ^10 || ^11`; depends on `content_translation` + `locale`.

## What you'd do → where

- **Translate a key at runtime** → global `getTexts()` / `getTextsPlural()` in `texts.module`, or the `texts.translator` service (`src/TextsTranslator.php`, `trans()` / `formatPlural()` / `translateMultiple()`), or `TextsTranslationTrait`.
- **Render a key in a template** → Twig filters `getTexts` / `getTextsPlural` (`src/Twig/TextsExtension.php`).
- **Manage/edit strings** → collection `/admin/content/texts` (`TextsListBuilder`); bulk multilingual overview via `TextsController::translatePage` → `Form/Overview/TranslationFilterForm` + `TranslationEditForm`; single-entity add/edit `Form/TextsForm`.
- **Configure** → `/admin/config/regional/texts` (`Form/SettingsForm`, config `texts.settings`) — only hides languages from the overview.
- **Import / export CSV** → `Controller/TextsExportController::export` (`/admin/config/regional/texts/export`), `Form/TextsImportForm` (`/admin/config/regional/texts/import`, batched, `league/csv`).
- **De-duplicate rows** → Drush `texts:cleanup-duplicates`, `texts:delete-duplicates` (`src/Drush/Commands/TextsCommands.php`); restore via `TextsController::restoreDuplicate` (`/admin/content/texts/{texts}/restore`).
- **Decoupled fetch** → `texts_graphql` submodule: Query fields `getText` / `getTextPlural` / `getTextMultiple` + `textsLoader` (`modules/texts_graphql/src/Plugin/GraphQL/SchemaExtension/TextsExtension.php`).

## Key facts (real names)

- **Entity:** `texts` (`src/Entity/Texts.php`), base table `texts`, data table `texts_field_data`, `translatable = TRUE`, `admin_permission = "access string translation overview"`. Fields: `key` (string, required, indexed), `context` (`list_string`, allowed values from `TextsContext::getStaticContextOptions`, default `default`), `translation` (`string_long`, translatable, required), `plural` (boolean), `created`, `changed`.
- **Uniqueness:** composite unique key `texts__key_context_langcode` on `(key, context, langcode)` added in `TextsContentEntityStorageSchema` + `texts_update_10001/10002`.
- **Services:** `texts.translator`, `texts.contexts`, `texts.twig_extension`, `texts.drush_commands`.
- **Storage:** `TextsStorage::loadByKey($key, $context)`, `loadMultipleByKey($keys)`.
- **Permissions** (`texts.permissions.yml`): `access string translation overview` (entity admin perm), `create/edit/delete/view string translation`, `administer texts configuration` (restricted — settings/import/export routes).
- **Access handler:** `TextsAccessControlHandler` maps view/update/delete/create to those permissions.
- **Auto-create semantics:** `TextsTranslator::trans()` **creates and saves a new entity** for an unknown key using `options['default_translation']`; the GraphQL Query resolvers and Twig filters both go through this path.
- **Plural encoding:** singular/plural joined by `\Drupal\Component\Gettext\PoItem::DELIMITER` in one `translation` value; `plural` flag marks it.
