<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Synlang translate form

`Drupal\synlang\Form\TranslateForm` — `src/Form/TranslateForm.php`, form id `synlang_translate`.

## Install & access

- Enable: `drush en synlang -y` (pulls in core `locale`). No config to import; no `.install` steps.
- Route `synlang.translate_form`, path **`/admin/config/system/synlang`**, title *"Synlang translate
  form"*, requirement `_permission: 'administer synlang configuration'` (`synlang.routing.yml`).
- Menu link under *Configuration → System* (`synlang.links.menu.yml`, weight 101), and it is the
  module's `configure:` link.
- Permission `administer synlang configuration` — title *"Administer Synlang"*, description *"Manage
  Synlang translation imports."* (`synlang.permissions.yml`). Not flagged `restrict access`.

## Form fields (`buildForm`)

- **`source`** (textfield, `source_container`): *"Url with data for translations"*, size 100. Default
  value is the vendor sample URL
  `https://git.synapse-studio.ru/d-org/synlang_translations/-/raw/master/main.yml`. This is the URL
  fetched for both Check and Update.
- **Check** button (`source_container.aсtions.ajax_check`): AJAX `#ajax` callback `::ajaxCheck`. Its
  result HTML is written into `<pre id='check-result'>`.
- **`content`** (radios, `update_container.content`, `#required`): *"Add new expressions"* — `1` Yes
  (default) / `0` No. Controls whether unknown source strings are created in locale storage.
- **`languages`** (tableselect, `update_container.languages`): rows are all enabled languages from
  `language_manager->getLanguages()`, columns *Code* / *Name*; all selected by default. Selects which
  languages receive translations.
- **Update** button (`update_container.aсtions.ajax_update`): AJAX callback `::ajaxUpdate`; result
  written into `<pre id='update-result'>`.

`submitForm()` is intentionally empty — all work happens in the two AJAX callbacks.

## AJAX flow

- `ajaxCheck()`: reads the `source` value, calls `translationData($file)` then
  `UpdateTranslations::countInfo()`, and returns an `AjaxResponse` with an `HtmlCommand("#check-result", …)`.
  Output is a Russian-language summary: total translations, then one line per language code with a
  count.
- `ajaxUpdate()`: reads `source`, builds settings via `translationSettings()`
  (`content` bool + `languages` bool map from the tableselect), calls
  `UpdateTranslations::updateTranslation()`, returns `HtmlCommand("#update-result", …)`.
- `translationData()` (private): requires a non-empty string URL, `file_get_contents`, `Yaml::decode`,
  and validates the decoded structure is `string => (array langcode => string)`; throws
  `\RuntimeException` on any malformed input. `ParseException`/`\RuntimeException` are caught and their
  message shown in the result `<pre>`.

## Notes

- Both AJAX actions are inside a standard Drupal `FormBase`, so requests carry the form/CSRF token.
- Some button labels and progress/summary strings are hard-coded in Russian (e.g. *"Проверяем."*,
  *"Поехали."*, *"Всего переводов"*).
- There is **no config object or schema** — the form does not persist any settings; the source URL is
  used per-request only.
