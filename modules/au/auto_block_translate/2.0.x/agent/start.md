<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto Block Translation (auto_block_translate) — agent index

A thin sub-module of **Auto Node Translate** that brings the same machine-translation workflow to
**custom content blocks** (`block_content`). Package `Multilingual`. Depends on core
**`content_translation`** and **`auto_node_translate`** (`^3`, Composer `drupal/auto_node_translate`).
Core requirement `^10.2 || ^11`. License GPL-2.0-or-later. Version 2.0.0.

- **The translate route, form, access check, tab/operation, and how a block is translated** →
  [api/translate.md](api/translate.md)
- **Configuration & where it lives (all in the parent module)** →
  [config/settings.md](config/settings.md)

## What it actually is

- **No config, no schema, no permissions, no Drush, no plugin types of its own.** It reuses the
  parent module's translator, provider plugins, settings, and the `auto translate block_content`
  permission. `configure` in `.info.yml` points at `auto_node_translate.settings`.
- Adds one route: **`entity.block_content.auto_translation_add`** →
  `block/{block_content}/auto-translate-form`, registered dynamically by
  `AutoBlockTranslateRouteSubscriber` (priority -210, only for the `block_content` entity type).
- Surfaces that route three ways: a **local task tab** (`AutoBlockTranslateLocalTasks` deriver,
  `*.links.task.yml`), an **entity operation** ("Auto Translate") and a translation-overview
  dropdown link ("Add/Update automatic translation") — both from `auto_block_translate.module`.

## Mechanism (from source)

- `src/Form/TranslationForm.php` (`FormBase`, form id `auto_block_translate_form`): builds a
  checkbox per site language other than the block's source language, labeled *new*/*overwrite*.
  `validateForm()` errors if `auto_node_translate.settings:default_api` is empty. `submitForm()`
  calls `autoBlockTranslateBlock()` then redirects to the block canonical page.
- `autoBlockTranslateBlock()` instantiates the configured provider via
  `plugin.manager.auto_node_translate_provider`, then per selected language and per field delegates
  to the parent **`auto_node_translate.translator`** (`Translator`): text fields →
  `translateTextField()`, `link` → `translateLinkField()`, `entity_reference_revisions` →
  `translateParagraphField()` (in a second pass); other non-excluded fields are copied verbatim.
  Saves as a new revision with revision log *"Automatic translation using @api"*, current user/time.
- `src/Access/AutoBlockTranslateAccessCheck.php` (`_access_auto_block_translation`): allows if core
  content-translation's own `access_callback` allows, else falls back to
  `AccessResult::allowedIfHasPermission($account, "auto translate block_content")`.

## Security surface (public, no findings)

- The module makes **no HTTP calls, stores no keys, ships no config**. The external translation API,
  its endpoint URL, and credentials all live in the parent `auto_node_translate` module.
- The translate route is a **POST `FormBase`** (core CSRF token automatic) gated by the access check
  above — no anonymous/GET trigger path here.
