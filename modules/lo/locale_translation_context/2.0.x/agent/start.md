<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Locale Translation Context (locale_translation_context) — agent index

Adds a **gettext-context (`msgctxt`) filter** to Drupal core's interface-translation
UI and to `.po`/`.pot` export. Depends on core `locale`. Installed **2.0.3** (docs cover
**2.0.x**). Core requirement `^10.1 || ^11`. No config form, no custom permissions,
no config schema — it enhances existing core screens and Drush commands.

## What it actually does (mechanism)

Drupal stores a `context` column on `locales_source` and supports
`t('Order', [], ['context' => 'Commerce order'])`, but core's translation UI never lets a
translator see or filter by it. This module fills that gap in three integration points:

- **Translate screen** (`admin/config/regional/translate`, route `locale.translate_page`).
  `src/EventSubscriber/RouteSubscriber.php` re-points the route's `_controller` to
  `ContextLocaleController::translatePage()`, which renders two subclassed forms:
  - `src/Form/Translation/ContextTranslateFilterForm.php` extends core
    `TranslateFilterForm`, adding a **Context** filter (`translateFilters()`) plus a
    little inline CSS for layout.
  - `src/Form/Translation/ContextTranslateEditForm.php` extends core `TranslateEditForm`
    and overrides `translateFilterLoadStrings()` to add `$conditions['context']` before
    calling `localeStorage->getTranslations($conditions, $options)`.
  - The "In Context: …" label shown per row is **core** behavior, not this module.
- **Export screen** (`locale_translate_export_form`). `src/Hook/LocaleTranslationContextHooks.php`
  (`#[Hook('form_locale_translate_export_form_alter')]`, with a `#[LegacyHook]` bridge in
  the `.module`) adds a **Context** select and swaps the form's `::submitForm` for
  `locale_translation_context_export_form_submit()` in the `.module`, which drives a bundled
  `src/PoDatabaseReader.php` (a `PoReaderInterface`) that honors a `context` option.
- **Drush** — `src/Drush/Commands/LocaleTranslationContextCommands.php`:
  - `locale:context-export` (alias `locale-context-export`) — export filtered by `--context`.
  - a `#[CLI\Hook]` that adds `--context` to and replaces core's `locale:export`.

The Context dropdown options come from `locale_translation_context_get_context_options()`
(in the `.module`) / `ContextTranslateFilterForm::getContextOptions()`: a `SELECT DISTINCT
context FROM locales_source WHERE context IS NOT NULL`. So the list only ever offers contexts
that already exist; contexts are authored in code, not created here.

## Key facts / caveats

- **Context is set by the developer, not the translator.** The filter exposes what the code
  declared; adding a context to an existing string makes it a **new** untranslated string.
- **`.po` files carry contexts** as `msgctxt`; import/export round-trips preserve them.
- **Access** is core `translate interface` (a powerful, trusted-user permission). No new
  permissions, routes, or config are introduced.
- Note the repo also contains an **empty** `src/Commands/LocaleTranslationContextCommands.php`;
  the live command class is under `src/Drush/Commands/`.

## Files in this doc set

- `data.json` — metadata (dependencies, categories, keywords, Drush commands).
- `usage.md` — short / dense / use-case-bullets summary.
- `agent/drush/context-export.md` — the Drush export commands in detail.
- `human-docs/` — click-through guide for humans using the admin UI.
