<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The auto_node_translate_provider plugin type

Translation backends are annotation plugins. This is how you add another engine (DeepL, Google,
LibreTranslate, …) without patching the module. Sources: `src/Annotation/AutoNodeTranslateProvider.php`,
`src/AutoNodeTranslateProviderPluginManager.php`, `src/AutoNodeTranslateProviderInterface.php`,
`src/AutoNodeTranslateProviderPluginBase.php`, `src/Plugin/AutoNodeTranslateProvider/MyMemoryTranslationApi.php`.

## Discovery

- Manager service: `plugin.manager.auto_node_translate_provider` (extends `default_plugin_manager`).
- Namespace: `Plugin/AutoNodeTranslateProvider`.
- Annotation: `@AutoNodeTranslateProvider` with `id`, `label`, `description`.
- The `Translator` instantiates the plugin whose id equals `auto_node_translate.settings:default_api`
  and calls `->translate($text, $from, $to)` per string.

## Interface

`AutoNodeTranslateProviderInterface::translate($text, $languageFrom, $languageTo): string` — return the
translated string (return the original on failure). Langcodes arrive as full ids; providers typically
reduce to the base (`explode('-', $lang)[0]`).

## Minimal skeleton

```php
namespace Drupal\my_module\Plugin\AutoNodeTranslateProvider;

use Drupal\auto_node_translate\AutoNodeTranslateProviderPluginBase;

/**
 * @AutoNodeTranslateProvider(
 *   id = "my_provider",
 *   label = @Translation("My Provider"),
 *   description = @Translation("Translate via my API.")
 * )
 */
final class MyProvider extends AutoNodeTranslateProviderPluginBase {
  public function translate($text, $languageFrom, $languageTo): string {
    // Call your API; return $text unchanged on error.
    return $translated;
  }
}
```

For DI (http client, config, messenger), implement `ContainerFactoryPluginInterface` and a `create()`
exactly like the bundled `MyMemoryTranslationApi`. Then select **My Provider** at
`/admin/config/regional/auto-node-translate-settings` (`default_api`).

## Reference implementation: MyMemory (`auto_node_translate_mymemory`)

- Injects `config.factory`, `http_client`, `messenger`.
- Reduces langcodes to base; replaces `&nbsp;` with `%20`.
- **Chunks** text > 400 bytes recursively (MyMemory limits the query to ~500 bytes) and concatenates.
- GETs the **fixed** URL `https://api.mymemory.translated.net/get?q=<text>&langpair=<from>|<to>[&de=<email>]`
  via `http_client`; on exception, shows an error and returns the source text.
- Decodes JSON; if `quotaFinished`, warns and returns source text, else returns
  `html_entity_decode(responseData.translatedText)`.
- The host is hardcoded; only the optional `mm_email` (config `my_memory_settings:mm_email`) is
  appended. There is no operator-controlled endpoint.
