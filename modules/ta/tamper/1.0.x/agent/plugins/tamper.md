# The Tamper plugin type

Namespace `Plugin/Tamper`, interface `Drupal\tamper\TamperInterface`, base class
`Drupal\tamper\TamperBase`, discovery attribute `Drupal\tamper\Attribute\Tamper`
(legacy annotation `Annotation\Tamper` also supported), manager `plugin.manager.tamper`.

## Write one
```php
namespace Drupal\my_module\Plugin\Tamper;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\tamper\Attribute\Tamper;
use Drupal\tamper\ItemUsage;
use Drupal\tamper\TamperBase;
use Drupal\tamper\TamperableItemInterface;

#[Tamper(
  id: 'my_upper',
  label: new TranslatableMarkup('My uppercase'),
  description: new TranslatableMarkup('Uppercases a string'),
  category: new TranslatableMarkup('Text'),
  handle_multiples: FALSE,
  itemUsage: ItemUsage::IGNORED,
)]
class MyUpper extends TamperBase {
  public function tamper($data, ?TamperableItemInterface $item = NULL) {
    if (!is_string($data)) {
      throw new \Drupal\tamper\Exception\TamperException('Input must be a string');
    }
    return strtoupper($data);
  }
}
```

## Attribute keys
- `id`, `label`, `description` — required.
- `category` — optional grouping in the consuming UI.
- `handle_multiples` (bool) — TRUE if the plugin expects/returns an array itself.
- `itemUsage` — one of `ItemUsage::REQUIRED` / `OPTIONAL` / `IGNORED` (or null): whether the
  plugin needs the surrounding `TamperableItemInterface`.

## Interface contract
- `tamper($data, ?TamperableItemInterface $item = NULL)` — return the transformed value; may
  throw `TamperException`, `SkipTamperDataException`, or `SkipTamperItemException`.
- `multiple()` — TRUE when a scalar input was expanded to a list.
- Config: extend `TamperBase` and implement `defaultConfiguration()` + `buildConfigurationForm()`
  (it implements `ConfigurableInterface` + `PluginFormInterface`). `getSetting($key)` reads config.

## Built-in plugin ids (Plugin/Tamper/)
`absolute_url`, `aggregate`, `array_filter`, `cast_to_int`, `convert_boolean`, `convert_case`,
`copy`, `country_to_code`, `dateoffset`, `default_value`, `encode`, `entity_finder`, `explode`,
`find_replace`, `find_replace_multiline`, `find_replace_regex`, `hash`, `html_entity_decode`,
`html_entity_encode`, `implode`, `keyword_filter`, `math`, `number_format`, `required`,
`rewrite`, `skip_on_empty`, `sprintf`, `state_to_abbrev`, `str_len`, `str_pad`, `str_pos`,
`strip_tags`, `strtotime`, `timeoffset`, `timetodate`, `transliteration`, `trim`,
`truncate_text`, `twig`, `unique`, `url_decode`, `url_encode`, `word_count`.
