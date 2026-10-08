<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Translation block, standalone form & usage statistics

## Deepl Translation block

`Plugin/Block/DeeplTranslationBlock` — `@Block(id = "ckeditor5_deepl_deepl_translation",
admin_label = "Deepl Translation", category = "Custom")`. Place it via
`/admin/structure/block` (README suggests an admin-theme region so a translator is available on
every admin page).

- `blockForm()` configures the block instance: `api_key` (`#type: key_select`, filter
  `deepl_api_key`, required), `split_sentences`, `preserve_formatting`, `tag_handling`, `formality`,
  `show_formality`, and a `target_languages` checkbox set. `blockSubmit()` stores these into the
  block config (schema `block.settings.ckeditor5_deepl_deepl_translation`).
- `build()` renders `Form/DeeplTranslationForm` (passing the block config), adds class `hidden`, and
  attaches library `ckeditor5_deepl/deeplBlockIntegration`. `js/deeplBlockIntegration.js` adds a
  floating `#deepl_toggle_button` that toggles the block's `hidden` class.

## Standalone form

`Form/DeeplTranslationForm` (`getFormId` = `ckeditor5_deepl_deepl_tranlation`, a `FormBase`):
a textarea `text`, a `target_language` select (from the block's configured target languages), an
optional `formality` select (only when the block's `show_formality` is on), and a Translate submit
with AJAX callback `translateCallback`.

`translateCallback()`:
- Loads the API key from the **block config** (`DeeplKeys::loadApiKey($this->deeplConfig['api_key'])`).
- Builds options from block config (adds `formality` only for non-Free keys with a value).
- Calls `DeeplTranslator::translate($api_key, $text, NULL, $target, $options)`.
- Sets `text_orig['#markup'] = '<p>' . $values['text'] . '</p>'` (original) and puts the
  translation into the textarea `#value`.

## Usage statistics

Route `ckeditor5_deepl.usage` → `/admin/config/system/settings/ckeditor5-deepl/usage-statistics`,
permission **`access deepl usage`**, controller `Controller/UsageStatisticsController::__invoke()`.
It loads every `deepl_api_key` key (`key.repository->getKeysByType`), and for each renders a
`details` element with the DeepL `Usage` string (`getUsageStatistics`) and a Free/Paid label
(`isAuthKeyFreeAccount`).

## Admin menu / routes & permissions

- `ckeditor5_deepl.ui` → `/admin/config/system/settings/ckeditor5-deepl` (core
  `SystemController::systemAdminMenuBlockPage`), permission **`administer deepl integration`**;
  menu links in `ckeditor5_deepl.links.menu.yml` (parent `system.admin_config_content`).
- Permissions (`ckeditor5_deepl.permissions.yml`): `administer deepl integration`,
  `access deepl usage`, `access deepl translate` (the last is declared but not wired to any route —
  see `../api/translate-endpoint.md`).
