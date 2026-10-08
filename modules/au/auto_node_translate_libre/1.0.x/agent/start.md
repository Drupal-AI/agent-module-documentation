<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto Node Translate Libre (auto_node_translate_libre) — agent index

A **provider plugin** for the **Auto Node Translate** module: it translates node field text
through a configurable **LibreTranslate** HTTP API. Package `Multilingual`. Core
`^10.2 || ^11`. License GPL-2.0-or-later. Version 1.0.0. Composer requires
**`drupal/auto_node_translate:^3.0`**; info.yml declares the module dependency
`auto_node_translate:auto_node_translate`.

- **The settings form, config object, endpoint URL / API key, and the translate mechanism** →
  [config/settings.md](config/settings.md)
- **The provider plugin (`LibreTranslator`) — how `translate()` and `modelIsAvailable()` work** →
  [plugins/libretranslator.md](plugins/libretranslator.md)

## What it actually is

- **One plugin**: `LibreTranslator` (id **`auto_node_translate_libre`**, label *"Libre"*), in
  `src/Plugin/AutoNodeTranslateProvider/LibreTranslator.php`. It implements the
  `@AutoNodeTranslateProvider` plugin type **defined by the parent module** (annotation
  `Drupal\auto_node_translate\Annotation\AutoNodeTranslateProvider`) — this module does **not**
  define a plugin type, only an instance. Extends
  `AutoNodeTranslateProviderPluginBase`, implements `ContainerFactoryPluginInterface`.
- **One settings form**: `SettingsForm` (`src/Form/SettingsForm.php`), a `ConfigFormBase` at
  route **`auto_node_translate_libre.settings`** → path **`/admin/config/regional/libre`**,
  permission **`administer site configuration`** (`auto_node_translate_libre.routing.yml`). A
  menu link (`auto_node_translate_libre.links.menu.yml`) places it under the parent's
  `auto_node_translate.translators` menu.
- **Config object**: `auto_node_translate_libre.settings` with two keys —
  `libretranslate_url`, `libretranslate_apikey`. No `config/install`, **no `config/schema`**
  (so `provides_config_schema` is false).
- **No** routes beyond the settings form, **no** permissions of its own, **no** services,
  **no** hooks, **no** entities, **no** Drush, **no** submodules, **no** JS/CSS libraries.

## Mechanism (from source)

- The parent module's translation workflow calls `LibreTranslator::translate($text, $from, $to)`.
  It trims regional subtags (`explode('-', $from)[0]`), reads `libretranslate_url` +
  `libretranslate_apikey` from config, and calls `modelIsAvailable()`.
- `modelIsAvailable()` GETs `{url}/languages`, decodes the JSON language list, and returns TRUE
  only if `$from`'s entry lists `$to` in its `targets`.
- On success `translate()` POSTs `form_params` `{api_key, q:text, source, target, format}` to
  `{url}/translate` via the core `http_client` (Guzzle) and returns
  `$response…['translatedText']`. `format` is `html` when the text contains a tag
  (`preg_match('#(?<=<)\w+…#')`), else `text`.
- On any exception (both calls) it messenger-reports the error and **returns the untranslated
  original text** — translation degrades to a no-op, never a fatal.
