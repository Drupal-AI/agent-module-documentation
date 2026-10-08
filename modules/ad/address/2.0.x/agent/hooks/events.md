# Address events

Address has **no `.api.php` / alter hooks**. Instead it dispatches three
Symfony events (constants on `Drupal\address\Event\AddressEvents`). Subscribe with
a tagged `event_subscriber` service.

| Constant | Event value | Event class | Purpose |
|---|---|---|---|
| `ADDRESS_FORMAT` | `address.address_format` | `AddressFormatEvent` | Alter a country's address format definition |
| `AVAILABLE_COUNTRIES` | `address.available_countries` | `AvailableCountriesEvent` | Alter the list of countries offered on a field |
| `SUBDIVISIONS` | `address.subdivisions` | `SubdivisionsEvent` | Add/replace custom subdivisions for a parent path |

```php
use Drupal\address\Event\AddressEvents;
use Drupal\address\Event\AvailableCountriesEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MySubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [AddressEvents::AVAILABLE_COUNTRIES => 'onCountries'];
  }
  public function onCountries(AvailableCountriesEvent $event): void {
    $countries = $event->getAvailableCountries();       // codes
    $field = $event->getFieldDefinition();              // FieldDefinitionInterface
    $event->setAvailableCountries(['US' => 'US', 'CA' => 'CA']);
  }
}
```

- `AddressFormatEvent`: `getDefinition()` / `setDefinition(array)`.
- `SubdivisionsEvent`: `getParents()` (country + parent codes), `getDefinitions()` /
  `setDefinitions(array)`. See the shipped `address_test` GreatBritain subscriber for a
  worked example.
