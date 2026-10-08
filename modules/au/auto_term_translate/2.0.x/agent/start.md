<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto Taxonomy Term Translation (auto_term_translate) — agent index

Sub-module of **auto_node_translate** that brings its machine-translation workflow to
taxonomy terms. Adds a per-term "Automatic Translation" form and a per-vocabulary bulk
translate form. Version 2.0.x. Core `^10.2 || ^11`.

- **Requires:** `content_translation` (Drupal core) and `auto_node_translate` (`drupal/auto_node_translate:^3.0`).
- **No backend of its own:** delegates all translation to the parent's `auto_node_translate.translator`
  service and `plugin.manager.auto_node_translate_provider`. Reuses the parent's config
  `auto_node_translate.settings` (`default_api`) — that is also the `configure` route
  (`auto_node_translate.settings`). This module ships **no config, no schema, no submodules**.

## Routes
- `entity.taxonomy_term.auto_translation_add` — `taxonomy/{taxonomy_term}/auto-translate-form`,
  `_form: TranslationForm`. Registered dynamically by `Routing\AutoTermTranslateRouteSubscriber`
  (priority -210). Access requirement `_access_auto_term_translation` (custom check).
- `auto_term_translate.bulk_form` — `/vocabulary/{vocabulary}/bulk-auto-translate-form`,
  `_form: BulkTranslationForm`, requirement `_permission: "use bulk auto translate"`.

## Permissions
- `use bulk auto translate` — restrict-access; gates the bulk vocabulary form.
- Per-term route falls back (via the access check) to the parent-defined per-bundle permission
  `auto translate {bundle} taxonomy_term` when core translation access is not granted.

## Services / classes
- `Access\AutoTermTranslateAccessCheck` (`_access_auto_term_translation`) — defers to the entity
  type's `content_translation` access callback, then falls back to the per-bundle permission.
- `Routing\AutoTermTranslateRouteSubscriber` — declares the per-term route for `taxonomy_term`.
- `Form\TranslationForm` — per-term form; `autoTaxonomyTranslateTerm()` does the field-by-field
  translation and `Term::save()`.
- `Form\BulkTranslationForm extends TranslationForm` — vocabulary form; `submitForm()` loads all
  terms and runs Batch API op `translateTerms()` (1 term/step) then `finished()`.
- `Plugin\Derivative\AutoTermTranslateLocalTasks` — the "Automatic Translation" tab on terms.

## Hooks (`auto_term_translate.module`)
- `hook_entity_operation` — adds an "Auto Translate" term operation.
- `hook_menu_local_tasks_alter` — adds the "Auto Translate" tab to the vocabulary overview.
- `hook_help` — renders README (via markdown filter if present).

## Solution docs
- [Routes, forms & access](routes/translate-forms.md) — the two routes, permissions, access check,
  and how per-term vs bulk translation runs.
- [Configuration & provider](config/settings.md) — where settings live (parent module) and how the
  translation provider is selected.
