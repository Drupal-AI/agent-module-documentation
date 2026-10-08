# Extend — custom normalizers & overriding the link manager

HAL has no plugin type. You extend it the Symfony-serializer way: register a tagged
`normalizer` service for the `hal_json` format, or decorate `hal.link_manager`.

## Add a normalizer for the `hal_json` format

Extend `Drupal\hal\Normalizer\NormalizerBase` (its `$format` is already `['hal_json']`) and
tag the service `normalizer`. Set a `priority` higher than the generic normalizer you want to
beat (the generic entity/field/field_item normalizers use priority `10`; specific ones like
timestamp/file/entity_reference_revisions use `20`).

```php
// src/Normalizer/MyFieldItemNormalizer.php
namespace Drupal\my_module\Normalizer;

use Drupal\hal\Normalizer\NormalizerBase;

class MyFieldItemNormalizer extends NormalizerBase {

  protected $supportedInterfaceOrClass = \Drupal\my_module\Plugin\Field\FieldType\MyItem::class;

  public function normalize($object, $format = NULL, array $context = []) { /* ... */ }

  public function denormalize($data, $type, $format = NULL, array $context = []) { /* ... */ }
}
```

```yaml
# my_module.services.yml
services:
  serializer.normalizer.my_item.hal:
    class: Drupal\my_module\Normalizer\MyFieldItemNormalizer
    tags:
      - { name: normalizer, priority: 30 }
```

The core `serializer` picks the highest-priority normalizer whose `supportsNormalization()`
matches the object **and** the `hal_json` format.

## Override / decorate the link manager

`hal.link_manager` and its `type` / `relation` delegates are plain services — swap them by
decoration when you need custom type/relation URI logic:

```yaml
services:
  my_module.link_manager:
    class: Drupal\my_module\LinkManager\MyLinkManager
    decorates: hal.link_manager
    arguments: ['@my_module.link_manager.inner']
```

Implement `Drupal\hal\LinkManager\LinkManagerInterface` (i.e. both `TypeLinkManagerInterface`
and `RelationLinkManagerInterface`, plus `ConfigurableLinkManagerInterface::setLinkDomain()`).
For small URI tweaks prefer the alter hooks instead — see [../hooks/hal.md](../hooks/hal.md).

## Relation to core `serialization` / `rest`

HAL sits on top of core `serialization`: its `JsonEncoder` and `NormalizerBase` subclass the
serialization equivalents and only change the format id to `hal_json`. To expose the format
over HTTP, enable `rest` and declare `hal_json` in the relevant `rest_resource_config`
(REST resource) or Views REST export serializer settings.
