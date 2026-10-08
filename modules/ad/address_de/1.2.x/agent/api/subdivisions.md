<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# German subdivisions via the Address event subscriber

The entire module is one event subscriber. There is nothing to configure.

## Install / enable

```
composer require drupal/address_de   # pulls drupal/address ^1.7 || ^2.0
drush en address_de -y
```

No settings form, no permission, no config export. After enabling, any Address
field whose country is (or can be) Germany gains a state (Bundesland) dropdown
and a state line in the rendered format.

## Service

`address_de.services.yml`:

```yaml
services:
  address_de_events_subscriber:
    class: '\Drupal\address_de\EventSubscriber\AddressEventsSubscriber'
    tags:
      - { name: 'event_subscriber' }
```

## Class: `AddressEventsSubscriber`

File: `src/EventSubscriber/AddressEventsSubscriber.php`. Implements
`Symfony\Component\EventDispatcher\EventSubscriberInterface`.

`getSubscribedEvents()` registers two Address events (from
`Drupal\address\Event\AddressEvents`):

| Event constant | Method | Effect |
| --- | --- | --- |
| `AddressEvents::ADDRESS_FORMAT` | `onAddressFormat(AddressFormatEvent $event)` | Alters the DE format |
| `AddressEvents::SUBDIVISIONS` | `onSubdivisions(SubdivisionsEvent $event)` | Supplies the DE state list |

### `onAddressFormat()`

Guards on the definition's country: `isset($definition['country_code']) &&
'DE' == $definition['country_code']`. For Germany it mutates the format
definition and writes it back with `$event->setDefinition()`:

- `format` gets `"\n%administrativeArea"` appended (adds the state line).
- `administrative_area_type` = `AdministrativeAreaType::STATE`
  (`CommerceGuys\Addressing\AddressFormat\AdministrativeAreaType`) — labels the
  field "State".
- `subdivision_depth` = `1` — tells addressing there is one level of
  subdivision to load.

Non-DE definitions are left untouched.

### `onSubdivisions()`

Returns immediately unless `$event->getParents() == ['DE']` (i.e. it only acts
when the addressing library asks for Germany's top-level subdivisions). It then
builds a definitions array and calls `$event->setDefinitions()`:

```php
[
  'country_code' => 'DE',
  'parents' => ['DE'],
  'subdivisions' => [
    'BW' => ['name' => 'Baden-Württemberg', 'iso_code' => 'DE-BW'],
    'BY' => ['name' => 'Bayern',            'iso_code' => 'DE-BY'],
    // ... BE, BB, HB, HH, HE, MV, NI, NW, RP, SL, SN, ST, SH ...
    'TH' => ['name' => 'Thüringen',         'iso_code' => 'DE-TH'],
  ],
]
```

All 16 states are present with the standard two-letter subdivision key, the
German `name`, and the ISO 3166-2 `iso_code` (`DE-XX`). The list is static — no
database, remote fetch, or user-supplied data is involved.

## Verify

1. Enable the module and add/keep an Address field allowing Germany.
2. On the entity form, select Germany — a "State" select appears listing the 16
   Bundesländer.
3. Rendered German addresses show the selected state on its own line.

The addressing library caches subdivision definitions; run `drush cr` if a
change to the field or module does not appear immediately.

## Reuse pattern

To add subdivisions for another country, copy this subscriber: guard
`onAddressFormat()` on that country code (append `%administrativeArea` and set
`administrative_area_type` / `subdivision_depth` as appropriate) and have
`onSubdivisions()` return early unless `getParents()` equals `[<country_code>]`,
then supply that country's `subdivisions` list. See the Address module's own
`AddressEvents` docs for the full event contract.
