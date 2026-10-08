<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UpdateTranslations service (`synlang.service`)

`Drupal\synlang\Service\UpdateTranslations` — `src/Service/UpdateTranslations.php`. Registered as
`synlang.service` (`synlang.services.yml`) with args `@locale.storage`
(`Drupal\locale\StringStorageInterface`) and `@config.factory`. Used by both the form and the Drush
commands.

## Methods

- **`countInfo(array $data): string`** — `$data` is `source-string => (langcode => translation)`.
  Returns a summary string: `"Всего переводов <N>"` (total source strings) followed by one
  `"<langcode> - <count>"` line per language. Read-only; powers the form's "Check".
- **`updateTranslation(array $data, array $settings): string`** — `$settings` is
  `{ content: bool, languages: array<langcode, bool|int|string> }`. Builds the list of langcodes whose
  value is truthy. For each source string: `localeStorage->findString(['source' => $source])`; if not
  found **and** `content` is truthy, `createString(['source' => $source])->save()`. Then, for each
  selected langcode, `createTranslation(['lid' => $string->lid, 'language' => $langcode,
  'translation' => $translated_string])->save()` and increments a counter. Returns
  `"Вы добавили / обновили  - <count>"`.
- **`updateTranslationConfig(array $data, array $settings): string`** — `$data` is
  `config-name => (config-key => (langcode => value))`, `$settings` is `{ language: string }`. For each
  config name/key, if the key exists and the language has a value, writes it with
  `configFactory->getEditable($cfg)->set($key, $value)->save()`. Returns
  `"Вы добавили / обновили  - <count>"` (count = number of config objects touched). Reachable only via
  the `synlang:slupdate_config` Drush command.

## Source YAML format

Interface strings (form + `synlang:slupdate`):

```yaml
"Save configuration":
  ru: "Сохранить конфигурацию"
  de: "Konfiguration speichern"
"Cancel":
  ru: "Отмена"
```

Configuration translations (`synlang:slupdate_config` only):

```yaml
"system.site":
  name:
    ru: "Мой сайт"
  slogan:
    ru: "Добро пожаловать"
```

Both are decoded with `Drupal\Component\Serialization\Yaml::decode` and strictly validated: the
top level must be a mapping; each value must be a mapping; leaf language codes and translations must be
strings, or a `\RuntimeException` is thrown.

## Notes

- Translations are written through core's `locale.storage` API, so they surface via `t()`/the Locale
  UI exactly like any other interface translation.
- Existing translations for a `(lid, language)` pair are overwritten by a subsequent
  `createTranslation(...)->save()`.
