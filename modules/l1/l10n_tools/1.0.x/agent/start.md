<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# L10n Tools (l10n_tools) — agent index

Maintenance tool for Drupal's **interface-translation** (`locale`) database tables. Adds one admin
form under *Configuration › Regional and language* (`/admin/config/regional/l10n_tools`) plus three
Drush commands that run the same operations from the CLI. Three operations, each backed by the
`l10n_tools.query_helper` service (`Drupal\l10n_tools\QueryHelper`): (1) **delete "equal"
translations** — `locales_target` rows whose translation string is byte-identical to its
`locales_source` string, optionally scoped to customized-only / imported-only / both;
(2) **delete "orphan" translations** — `locales_source` rows that have no matching `locales_target`
row at all (the untranslated source strings themselves); (3) **reset translation status** — clear the
`locale.translation_status` key_value collection and zero the `locale_file` timestamps +
`locale.translation_last_checked` state so core re-checks localize.drupal.org for updates. All three
are destructive DB writes with no undo; the module saves no configuration of its own.

- Depends on: core `locale`. Core: `^9 || ^10 || ^11`. Package: `Multilingual`. Version `1.0.3`.
- Settings page / `configure` route: **`l10n_tools.form`** — the form *is* the entire UI; it has no
  saved config and no config schema.
- Permission: one — **`access l10n_tools form`** (`restrict access: TRUE`) — gates the route.
- Drush: three commands (`l10n_tools:deet`, `:deot`, `:rets`). No plugin types, no libraries, no
  templates, no hooks.
- **MySQL/MariaDB only** — queries use `CONVERT(… USING utf8)` and multi-table `DELETE ls FROM …`
  syntax; on other backends each op is caught, logged to channel `l10n_tools`, and returns an error.

## What you'd do → where

- **Run a cleanup from the admin UI (list first, then delete) / what each button removes** →
  [configure/form.md](configure/form.md)
- **Run the same cleanups from the CLI (options, aliases)** → [drush/commands.md](drush/commands.md)
- **Call the cleanup logic from your own code / exact tables and SQL each method touches** →
  [api/services.md](api/services.md)

## Key facts (real machine names)

- Route: `l10n_tools.form` → `/admin/config/regional/l10n_tools`,
  `_form: \Drupal\l10n_tools\Form\L10nToolsForm`, `_permission: access l10n_tools form`. Menu link
  `l10n_tools.form` under parent `system.admin_config_regional`.
- Permission: `access l10n_tools form` (`restrict access: TRUE`).
- Service: `l10n_tools.query_helper` → `Drupal\l10n_tools\QueryHelper` (no constructor arguments).
- Drush commands — class `Drupal\l10n_tools\Commands\L10nToolsCommands`, registered via
  `drush.services.yml` (tag `drush.command`): `l10n_tools:delete-equal-translations`
  (alias `l10n_tools:deet`), `l10n_tools:delete-orphan-translations` (`l10n_tools:deot`),
  `l10n_tools:reset-translation-status` (`l10n_tools:rets`).
- Form id: `l10n_tools_form`. Submit handlers: `::deleteEqualTranslationsCallback`,
  `::deleteOrphanTranslationsCallback`, `::resetTranslationStatusCallback`; AJAX list callbacks
  `::getEqualTranslationsAjaxCallback`, `::getOrphanTranslationsAjaxCallback`. Form select
  `filterCustomized` (default `1`).
- Tables/state touched: `locales_source`, `locales_target`, `locale_file`, `key_value`
  (collection `locale.translation_status`); state key `locale.translation_last_checked`.
- No `config/schema`, no `config/install`, no plugin types.
