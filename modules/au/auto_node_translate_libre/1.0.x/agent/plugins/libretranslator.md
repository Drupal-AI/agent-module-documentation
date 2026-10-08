<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin: LibreTranslator (`auto_node_translate_libre`)

`src/Plugin/AutoNodeTranslateProvider/LibreTranslator.php` — the only plugin in the module.

## Plugin type & wiring

- Annotation `@AutoNodeTranslateProvider(id="auto_node_translate_libre", label=@Translation("Libre"),
  description=…)`. The plugin **type, annotation, manager and interface are defined by the parent
  `auto_node_translate` module** (`Annotation\AutoNodeTranslateProvider`,
  `AutoNodeTranslateProviderPluginManager`, `AutoNodeTranslateProviderInterface`), which
  discovers plugins under `Plugin/AutoNodeTranslateProvider/`.
- `final class LibreTranslator extends AutoNodeTranslateProviderPluginBase implements
  ContainerFactoryPluginInterface`.
- `create()` injects three core services: `config.factory` → `$this->config`,
  `http_client` (Guzzle, PSR-18 `ClientInterface`) → `$this->httpClient`, `messenger` →
  `$this->messenger`.
- Inherited from the base: `label()` returns the plugin definition label as a string.

## `translate($text, $from, $to): string`

The single method the parent workflow calls per field value.

1. Reads config `auto_node_translate_libre.settings`; `$from`/`$to` are reduced to the primary
   subtag (`explode('-', …)[0]`). Reads `libretranslate_apikey` and
   `$url = rtrim(libretranslate_url, '/')`.
2. Guards on `modelIsAvailable($from, $to, $url)` (below). If unavailable → messenger status
   telling the editor the pair isn't available (with a link to `auto_node_translate.settings`),
   returns `$text` unchanged.
3. If available, POSTs to `{$url}/translate` with `form_params`:
   - `api_key` = configured key
   - `q` = `$text`
   - `source` = `$from`, `target` = `$to`
   - `format` = `html` if `preg_match('#(?<=<)\w+(?=[^<]*?>)#', $text)` matches a tag, else `text`
4. Decodes the JSON body; returns `$formattedData['translatedText']` when present. If the key is
   absent, messages "The translation failed for @text" and returns the original `$text`.
5. Any `\Exception` from the POST → messenger error ("LibreTranslate translator error @error …",
   with a link to the parent settings route) and returns `$text` unchanged.
6. Always ends with a "Translation Completed" status message.

## `modelIsAvailable($languageFrom, $languageTo, $url)`

- GETs `{$url}/languages`, JSON-decodes the array of language descriptors.
- Returns TRUE only if some entry has `code == $languageFrom` **and** `$languageTo` is in that
  entry's `targets` array; otherwise FALSE.
- On request exception → messenger error and returns FALSE (so `translate()` falls back to the
  original text).

## Behavioral notes

- The provider **never throws to the caller**: every failure path returns the source text, so a
  down or misconfigured LibreTranslate server leaves content untranslated rather than breaking
  the node-save/translation flow.
- HTTP uses the standard core `http_client`; requests carry Guzzle's default settings.
- Editor-facing messages use `@`-placeholders (auto-escaped by `t()`); the returned translated
  string is handed back to the parent module, which is responsible for how it is stored/rendered
  on the node.
