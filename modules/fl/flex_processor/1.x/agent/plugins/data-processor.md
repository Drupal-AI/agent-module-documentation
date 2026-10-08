<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The DataProcessor plugin type

## Install & enable

```bash
composer require drupal/flex_processor
drush en flex_processor -y
```

No dependencies outside core, no permissions, no Drush commands, no configuration. Enabling the
module only makes the plugin type and base classes available; you get value by writing plugins.

## Anatomy of a plugin

Discovery is annotation-based. The annotation is `Drupal\flex_processor\Annotation\DataProcessor`
(`src/Annotation/DataProcessor.php`):

| Property | Meaning |
|---|---|
| `id` | Plugin id. |
| `label` | `@Translation` label. |
| `type` | Component type the plugin handles (an entity-type id, `"field"`, `"component"`, or any custom string). |
| `bundles` | Array of bundles this plugin matches (entity bundle, field-type machine name, or component bundle). |
| `variant` | Output variant; defaults to `"default"`. Lets several plugins target the same type+bundle. |

The manager maps every plugin by `type` . `bundle` . `variant` (one entry per listed bundle), so a
plugin with `type = "node"`, `bundles = {"article"}`, `variant = "card"` answers a request for a
node/article with `['variant' => 'card']`. A missing variant falls back to the same type+bundle at
variant `default`; if nothing matches, `MissingPluginImplementationException` is thrown.

Plugins live in any module's `src/Plugin` (or a matching subnamespace) and extend one of the base
classes below. All implement `DataProcessorInterface` (`src/Plugin/DataProcessorInterface.php`):
`preProcess($component, $options)` and `process($component, $options)` — you implement `process()`,
which returns whatever structure you want (`mixed`).

## Base classes (`src/Plugin/`)

- **`DataProcessorBase`** — implements the interface + `ContainerFactoryPluginInterface`; injects
  the manager as `$this->dataProcessorManager` (call `->process()` on it to recurse). Its
  `preProcess()` just forwards to your `process()`.
- **`EntityDataProcessor`** — adds `entity.repository`; its `preProcess()` calls
  `getTranslationFromContext($entity, $options['langcode'])` before invoking `process()`, so your
  code receives the language-appropriate entity. Extend this for entity processors.
- **`FieldDataProcessor`** — its `preProcess()` receives a `FieldItemListInterface`: returns `NULL`
  when the list is empty, calls `process()` per non-empty item, then returns a single value when
  the field storage cardinality is `1` (`reset()`), otherwise the array of processed items. Extend
  this for field processors — your `process()` handles **one** field item.
- **`ComponentDataProcessor`** — an empty marker subclass of `DataProcessorBase`; extend it for
  `type = "component"` processors that handle `DataComponent` value objects.

## Minimal entity processor

```php
namespace Drupal\your_module\Plugin;

use Drupal\flex_processor\Plugin\EntityDataProcessor;

/**
 * @DataProcessor(
 *   id = "node__article__card",
 *   label = @Translation("Node: Article Card"),
 *   type = "node",
 *   bundles = { "article" },
 *   variant = "card"
 * )
 */
class ArticleCard extends EntityDataProcessor {
  public function process(mixed $entity, array $options = []): mixed {
    return [
      'title' => $entity->getTitle(),
      'summary' => $this->dataProcessorManager->process($entity->get('body')),
      'image' => $this->dataProcessorManager->process(
        $entity->get('field_media'), ['style' => 'article_card_400x300']
      ),
    ];
  }
}
```

## Built-in field processors (`src/Plugin/FieldDataProcessors/`)

These match by field **type** (the annotation `bundle`), so they cover common core fields with no
extra code. Each `process()` handles one item:

| Plugin id | Field types (`bundles`) | Returns |
|---|---|---|
| `field_boolean` | `boolean` | `$item->getValue()['value']` |
| `field_decimal` | `decimal` | `['value']` |
| `field_float` | `float` | `['value']` |
| `field_plain_text` | `string`, `string_long`, `integer`, `email` | `$item->value` |
| `field_formatted_text` | `text`, `text_long`, `text_with_summary` | `check_markup($item->value, $item->format)` (honours the text format) |
| `field_datetime` | `datetime` | `date.formatter->format()`; options `type` (default `medium`), `format`, `timezone`, `langcode`; string dates go through `strtotime()` |
| `field_list` | `list_integer`, `list_float`, `list_string` | raw value, or the allowed-value **label** when `options['format'] === 'value'` |
| `field_link` | `link` | `['label' => title, 'url' => generated url]` (via `LinkItemInterface::getUrl()`) |
| `field_file` | `file` | `['type' => 'file', 'url' => absolute file url]` (`file_url_generator`) |
| `field_image` | `image` | `['url' => ['original' + per-style], 'alt' => Xss::filter(alt), 'meta' => width/height/orientation]`; pass `options['style']` (string or array) for image-style URLs (`ImageStyle::load()->buildUrl()`) |
| `field_entity_reference` | `entity_reference`, `entity_reference_revisions` | recurses: `dataProcessorManager->process($referencedEntity, $options)` |

Note `field_image` needs core **image** and `field_link` needs core **link** at runtime only if you
process those field types; neither is a hard module dependency.

## Altering / overriding

The manager sets `alterInfo('flex_processor_processor_info')`, so implement
`hook_flex_processor_processor_info_alter(&$definitions)` to change or replace discovered plugin
definitions. Definitions are cached in the default cache backend under key
`flex_processor_processor_plugins`; run `drush cr` after adding or changing plugins.
