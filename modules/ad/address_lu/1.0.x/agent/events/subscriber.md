<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AddressEventsSubscriber — Luxembourg address format & subdivisions

## Install & enable

```bash
composer require drupal/address_lu
drush en address_lu -y
drush cr
```

Requires `address`. No config, no permissions, no sub-modules, no Drush. The data appears
automatically on any Address field once the user selects **Luxembourg**.

## Service

`address_lu.services.yml`:

```yaml
services:
  address_lu_events_subscriber:
    class: '\Drupal\address_lu\EventSubscriber\AddressEventsSubscriber'
    tags:
      - { name: 'event_subscriber' }
```

No constructor arguments; the class uses `StringTranslationTrait` and holds all data inline.

## Events (from `AddressEventsSubscriber`)

`getSubscribedEvents()` registers `onAddressFormat` on `AddressEvents::ADDRESS_FORMAT` and
`onSubdivisions` on `AddressEvents::SUBDIVISIONS`.

### `onAddressFormat(AddressFormatEvent $event)`
Only when `$definition['country_code'] == 'LU'`:

- `format = "%organization\n%givenName %familyName\n%administrativeArea-%locality\n%postalCode\n%addressLine1\n%addressLine2"`
- `subdivision_depth = 2`
- appends `AddressField::ADMINISTRATIVE_AREA` and `AddressField::LOCALITY` to `required_fields`
- `administrative_area_type = AdministrativeAreaType::CANTON`
- `$event->setDefinition($definition)`

### `onSubdivisions(SubdivisionsEvent $event)`
Matches `$event->getParents()` against `if ($parents == [...])` blocks, each calling
`$event->setDefinitions($definitions)`. Two levels:

1. `['LU']` → the 12 cantons, each `['iso_code' => 'LU-XX', 'has_children' => TRUE]`
   (Capellen `LU-CA`, Clervaux `LU-CL`, Diekirch `LU-DI`, Echternach `LU-EC`,
   Esch-sur-Alzette `LU-ES`, Grevenmacher `LU-GR`, Luxembourg `LU-LU`, Mersch `LU-ME`,
   Redange `LU-RD`, Remich `LU-RM`, Vianden `LU-VD`, Wiltz `LU-WI`).
2. `['LU', <canton>]` → that canton's localities, leaf entries `[]`.

Address walks these levels as the user selects canton → locality.

## Operating notes

- Data is inline PHP — no JSON, no cache, no file I/O. Corrections mean patching the class.
- Nothing keys off request input beyond the `$parents` array Address passes in.
- To verify: choose an Address field, set the country to Luxembourg, confirm the "Canton" select
  and its localities appear and both are required.
