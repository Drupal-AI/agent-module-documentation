<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# html_transformer — API

## Transform an HTML string with all automatic plugins
```php
$html = \Drupal::service(\Drupal\html_transformer\HtmlTransformerInterface::class)
  ->transform($input_html);
```
Note: the D2.0 service `transform()` signature operates on a `Dom\HTMLDocument` and returns void (mutates in place); the README's string-in/string-out form reflects the higher-level usage. Inspect `src/HtmlTransformer.php` for the exact signature in your installed version.

## Run a specific, ordered subset of plugins
```php
$plugins = ['first_plugin', 'second_plugin'];
\Drupal::service(\Drupal\html_transformer\HtmlTransformerInterface::class)
  ->transform($document, plugins: $plugins);
```
- `plugins = NULL` → all plugins returned by `getAutomaticPluginIds()`.
- `plugins = []` → parse + serialize with **no** transformation.

## Write a plugin
```php
use Drupal\html_transformer\Attribute\HtmlTransformer;
use Drupal\html_transformer\HtmlTransformerPluginBase;

#[HtmlTransformer('example')]
final class Example extends HtmlTransformerPluginBase {
  public function transform(\DOMDocument $document): void {
    // mutate $document
  }
}
```
Implement `LoggerAwareInterface` to receive the logger passed to `transform()`.

## Migrate
A `Plugin/migrate/process/HtmlTransformer` process plugin applies transformations to field values during migration.

## UI
Enable `html_transformer_ui`, grant `use html_transformer_ui`, visit `/html-transformer/transform` to run input HTML through selected/automatic plugins and view serialized output + log (output shown escaped in disabled textareas).
