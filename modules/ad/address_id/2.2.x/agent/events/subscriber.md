<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IndonesiaEventSubscriber — Indonesian address format & subdivisions

## Install & enable

```bash
composer require drupal/address_id
drush en address_id -y
drush cr
```

Requires `address`. No config, no permissions, no sub-modules, no Drush. Enabling is the whole
setup; the data then appears automatically on any Address field when the user selects **Indonesia**.

## Service

`address_id.services.yml`:

```yaml
services:
  address_id.indonesia_subscriber:
    class: Drupal\address_id\EventSubscriber\IndonesiaEventSubscriber
    tags:
      - {name: event_subscriber}
```

No constructor arguments — the class holds all data inline.

## Events (from `IndonesiaEventSubscriber`)

`getSubscribedEvents()` registers `onAddressFormat` on `AddressEvents::ADDRESS_FORMAT` and
`onSubdivisions` on `AddressEvents::SUBDIVISIONS`.

### `onAddressFormat(AddressFormatEvent $event): void`
Only when `$definition['country_code'] == 'ID'`:

- `subdivision_depth = 3`
- `format = "%givenName %familyName\n%addressLine1\n%addressLine2\n%administrativeArea\n%locality\n%dependentLocality %postalCode"`
- appends `"locality"` and `"dependentLocality"` to `required_fields`
- `$event->setDefinition($definition)`

### `onSubdivisions(SubdivisionsEvent $event): void`
Reads `$event->getParents()` and matches it against a long chain of `if ($parents == [...])` blocks,
each building a `$definitions` array (`country_code`, `parents`, `subdivisions`) and calling
`$event->setDefinitions($definitions)`. Three levels:

1. `['ID']` → all provinces, each `['iso_code' => 'ID-XX', 'has_children' => TRUE]`
   (e.g. `Bali` → `ID-BA`, `DKI Jakarta` → `ID-JK`).
2. `['ID', <province name>]` → regencies/cities in that province (`has_children => TRUE`).
3. `['ID', <province name>, <regency/city name>]` → districts (kecamatan), leaf entries `[]`.

The Address module walks these levels as the user selects province → city/regency → district,
producing cascading dropdowns.

## Operating notes

- Because the data is inline PHP, there is **no JSON, no cache service, and no file I/O** here
  (unlike `address_md`). Adding/correcting a subdivision means patching the class.
- Nothing keys off request input beyond the `$parents` array Address passes in; no user-supplied
  path or URL is dereferenced.
- To verify: add/choose an Address field, set the country to Indonesia, and confirm the
  province/city/district selects and the required locality fields appear.
