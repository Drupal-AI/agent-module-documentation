<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Synlang (synlang) — agent index

Bulk-imports **interface (locale) and configuration translations** from a remote **YAML** file into
Drupal, via an admin form or Drush. Package **Synapse**. Depends only on core **`locale`**. Core
`^11 || ^12`. License GPL-2.0-or-later. Version **3.0.7** (dir 3.0.x).

## What it actually is (from source)

- **One admin form**: `Drupal\synlang\Form\TranslateForm` (form id `synlang_translate`), route
  `synlang.translate_form` at **`/admin/config/system/synlang`**, permission
  **`administer synlang configuration`**. Menu link `synlang.translate_form` under
  *Configuration → System*. `configure:` in info.yml points here.
- **One service**: `synlang.service` = `Drupal\synlang\Service\UpdateTranslations`, constructed with
  `@locale.storage` (`StringStorageInterface`) and `@config.factory`.
- **Two Drush commands**: `Drupal\synlang\Drush\Commands\SynlangCommands` (registered in
  `drush.services.yml` as `synlang.commands`): `synlang:slupdate` (alias `slupdate`) and
  `synlang:slupdate_config` (alias `slupdate_config`).
- **One permission**: `administer synlang configuration` (`synlang.permissions.yml`).
- **No** entities, plugins, config objects, config schema, `.install`, or real hooks
  (`synlang.module` is an empty stub).

## How it works

- The form/commands fetch a URL with `file_get_contents`, decode it with `Yaml::decode`, and validate
  it into a `source-string → { langcode → translation }` map.
- `UpdateTranslations::updateTranslation()` looks up each source in `locale.storage`
  (`findString`), optionally `createString()` (when "Add new expressions"/content = Yes), then
  `createTranslation()` for each selected language. `countInfo()` powers the "Check" preview.
  `updateTranslationConfig()` writes remote values straight into config via
  `configFactory->getEditable()` (Drush `slupdate_config` only, default language).

## Solution docs

- The admin form, its fields, the Check/Update AJAX flow, route & permission →
  [config/translate-form.md](config/translate-form.md)
- The `UpdateTranslations` service API and the YAML source format →
  [api/update-translations.md](api/update-translations.md)
- The two Drush commands →
  [drush/commands.md](drush/commands.md)

## Changes vs 8.x-2.x

- Core requirement is now **`^11 || ^12`** (was `^9 || ^10 || ^11`).
- The real dependency is core **`locale`** (the prior 8.x-2.x doc's "field" dependency was wrong).
- It provides a **permission** and a **configure form** (prior doc missed these); it provides **no
  config schema** (prior doc claimed it did — there is no `config/` directory).
