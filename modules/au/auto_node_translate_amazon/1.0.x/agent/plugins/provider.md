<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AmazonTranslator provider plugin

`Drupal\auto_node_translate_amazon\Plugin\AutoNodeTranslateProvider\AmazonTranslator` implements the
`AutoNodeTranslateProvider` plugin type defined by the parent `auto_node_translate` module. This
module defines no plugin type of its own — it only supplies one backend for the parent's type.
Source: `src/Plugin/AutoNodeTranslateProvider/AmazonTranslator.php`.

## Annotation & base class

```php
/**
 * @AutoNodeTranslateProvider(
 *   id = "auto_node_translate_amazon",
 *   label = @Translation("Amazon"),
 *   description = @Translation("Amazon translation provider for auto node translate.")
 * )
 */
final class AmazonTranslator extends AutoNodeTranslateProviderPluginBase
  implements ContainerFactoryPluginInterface
```

- Discovered by the parent's `plugin.manager.auto_node_translate_provider`; the label **Amazon**
  appears in the parent's `default_api` provider selector.
- Injects `config.factory` and `messenger` through `create()`.

## Client construction (`__construct`)

Reads `auto_node_translate_amazon.settings` and builds one `Aws\Translate\TranslateClient` (from
`aws/aws-sdk-php`) per plugin instance:

```php
$options = [
  'version' => 'latest',
  'region'  => $config->get('amazon_translate_region'),
  'credentials' => [
    'key'    => $config->get('amazon_translate_key'),
    'secret' => $config->get('amazon_translate_secret'),
  ],
];
$this->translateClient = new TranslateClient($options);
```

The transport is the official AWS SDK's default HTTP handler (standard AWS endpoints).

## `translate($text, $languageFrom, $languageTo): string`

- Calls `$this->translateClient->translateText([...])` with `SourceLanguageCode => $languageFrom`,
  `TargetLanguageCode => $languageTo`, `Text => $text`; returns `$result['TranslatedText']`.
- Langcodes are passed through **as-is** — unlike some sibling providers it does not reduce
  `en-US` to `en`, so the codes must be ones AWS Translate accepts.
- On `Aws\Exception\AwsException` it adds a messenger error `Error @code: @message` and returns the
  original `$text` unchanged (the string is left untranslated; the exception does not bubble up).
- Runs `usleep(750)` (~0.75 ms) after each call as light spacing between requests.

The parent `Translator` invokes this once per translatable string on a node, so a single node
translation results in many `translateText` calls.

## Adding another provider

To add a different engine, implement the parent's plugin type rather than patching this module. See
[../../../../auto_node_translate/3.0.x/agent/plugins/provider.md](../../../../auto_node_translate/3.0.x/agent/plugins/provider.md).
