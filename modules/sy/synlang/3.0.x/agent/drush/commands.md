<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Synlang Drush commands

`Drupal\synlang\Drush\Commands\SynlangCommands` — `src/Drush/Commands/SynlangCommands.php`. Registered
in `drush.services.yml` as `synlang.commands` (tag `drush.command`) with args `@language_manager` and
`@synlang.service`. Modern Drush attribute-style commands (`#[CLI\Command]`).

## `synlang:slupdate` (alias `slupdate`)

- Signature: `synlang:slupdate <url>` — `$url` is the URL of the interface-translation YAML file.
- Enables **all** enabled languages (from `language_manager->getLanguages()`) and forces
  `content = TRUE` (new source strings are created), then calls
  `UpdateTranslations::updateTranslation()`.
- Loads/validates the file with the same private `translationData()` logic as the form
  (`file_get_contents` + `Yaml::decode` + strict shape validation); catches
  `ParseException`/`\RuntimeException` and prints the message.
- Example: `drush slupdate https://example.com/translations/main.yml`

## `synlang:slupdate_config` (alias `slupdate_config`)

- Signature: `synlang:slupdate_config <url>` — `$url` is the URL of the config-translation YAML file.
- Targets the **default** language (`language_manager->getDefaultLanguage()->getId()`), builds settings
  `{ content: TRUE, language: <default> }`, and calls `UpdateTranslations::updateTranslationConfig()`,
  which writes values directly into editable config objects.
- Loads/validates with private `translationConfigData()` (three-level mapping:
  config-name → key → langcode → string). Catches `ParseException`.
- Example: `drush slupdate_config https://example.com/translations/config.yml`

## Notes

- Both commands fetch a remote URL server-side; run them only with trusted source files (CLI access is
  already an administrative/trusted context).
- Progress lines are printed in Russian (*"Обновляем переводы ..."*, *"Обновляем переводы конфигов ..."*).
