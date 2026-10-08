<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 plugin config, key type & schema

## Install / enable

`drush en ckeditor5_deepl` (pulls in `ckeditor5` + `key`; requires `deeplcom/deepl-php` via
Composer). Then: create a key at `/admin/config/system/keys` of type **DeepL API Key**, edit a
text format at `/admin/config/content/formats`, drag the **DeepL** button onto that format's
CKEditor 5 toolbar, and a **DeepL Settings** tab appears in the plugin settings.

## The CKEditor 5 plugin

Declared in `ckeditor5_deepl.ckeditor5.yml` as `ckeditor5_deepl_integration`:
toolbar item `deeplIntegration` (label "deepl"), JS plugin `deeplIntegration.deeplIntegration`,
libraries `ckeditor5_deepl/deeplIntegration` + `admin.deeplIntegration`, PHP class
`Plugin/CKEditor5Plugin/DeeplIntegration` (extends `CKEditor5PluginDefault`, implements
`CKEditor5PluginConfigurableInterface`). `elements: false` — it inserts no new HTML elements of
its own into the format's allowed tags.

`DeeplIntegration::buildConfigurationForm()` gates the form:
- If no `deepl_api_key` key exists (`DeeplKeys::loadOneDeeplKey()`), it shows only a link to create one.
- If a key is chosen but invalid (`DeeplHelper::isValidDeeplKey()`), it shows an "invalid key" message.

Config keys stored under `settings.plugins.ckeditor5_deepl_integration.deepl`
(`DEFAULT_CONFIGURATION` const; schema `config/schema/ckeditor5_deepl.schema.yml`
→ `ckeditor5.plugin.ckeditor5_deepl_integration`):

| key | type | notes |
|-----|------|-------|
| `api_key` | string | Key entity id (`#type: key_select`, filter `type: deepl_api_key`, required) |
| `split_sentences` | string | `0` / `1` (default) / `nonewlines` — from `DeeplHelper::getSupportedSplitSentences()` |
| `preserve_formatting` | bool | default FALSE |
| `tag_handling` | string | `off` (default) / `xml` / `html` |
| `formality` | string | `default` / `more` / `less` / `prefer_more` / `prefer_less` (Pro keys only) |
| `show_formality` | bool | show the formality dropdown to editors |
| `source_languages` | sequence | selected DeepL source langs (options fetched live) |
| `target_languages` | sequence | selected DeepL target langs |

`submitConfigurationForm()` keeps only the checked language codes (skips `0`) and maps each to its
label. `getDynamicPluginConfig()` sends `show_formality`, `formality`, `source_languages`,
`target_languages` to the JS as `config.ckeditor5_deepl_integration.deepl` — **the API key is NOT
included** in the dynamic config sent to the browser. `hook_editor_js_settings_alter`
(`ckeditor5_deepl.module`) additionally injects `deepl.formalities` (label list) into each format's
editor JS settings.

## DeepL API Key key type

`Plugin/KeyType/DeeplKeyType` — `@KeyType(id = "deepl_api_key", group = "authentication",
key_value = { plugin = "text_field" })`. `generateKeyValue()` returns a 16-char random string
(placeholder). `validateKeyValue()` calls `DeeplHelper::isValidDeeplKey()` (which does a live
`getUsageStatistics()` call) — so keys are validated against DeepL when saved. Because it is a Key
entity of type `text_field`, the secret is stored/managed by the Key module (env, file, config,
etc.) rather than in this module's own config.

## Helper service (`DeeplHelper`, `ckeditor5_deepl.helper`)

Supplies form option lists (`getSupportedFormalities`, `getSupportedTagHandling`,
`getSupportedSplitSentences`), validates a key (`isValidDeeplKey`), and returns remote language
options (`getSupportedRemoteLanguagesOptions` / `getSupportedRemoteLanguages`), caching the DeepL
language list in `cache.default` under `ckeditor5_deepl:supported_remote_languages:{type}` with
tag `deepl_api` (permanent until the cache/tag is cleared).
