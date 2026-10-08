<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AddressEventsSubscriber — Moldova address format & subdivisions (JSON-backed)

## Install & enable

```bash
composer require drupal/address_md
drush en address_md -y
drush cr
```

Requires `address`. No config, no permissions, no sub-modules, no Drush. Data appears automatically
on any Address field once the user selects **Republic of Moldova (MD)**.

## Service

`address_md.services.yml`:

```yaml
services:
  address_md_events_subscriber:
    class: '\Drupal\address_md\EventSubscriber\AddressEventsSubscriber'
    arguments: ['@extension.path.resolver', '@cache.data']
    tags:
      - { name: 'event_subscriber' }
```

Constructor stores `ExtensionPathResolver $extension_path` and `CacheBackendInterface $cache`. Uses
`StringTranslationTrait`.

## Events (from `AddressEventsSubscriber`)

`getSubscribedEvents()` maps `AddressEvents::ADDRESS_FORMAT => 'onAddressFormat'` and
`AddressEvents::SUBDIVISIONS => 'onSubdivisions'`.

### `onAddressFormat(AddressFormatEvent $event)`
Only when `$definition['country_code'] == 'MD'`:

- `format = "%givenName %familyName\n%organization\n%administrativeArea-%locality\n%dependentLocality\n%postalCode\n%addressLine1\n%addressLine2"`
- `subdivision_depth = 2`
- `administrative_area_type = AdministrativeAreaType::DISTRICT`
- `$event->setDefinition($definition)`

### `onSubdivisions(SubdivisionsEvent $event)`
1. `$parents = $event->getParents()`; return early if empty.
2. `array_shift($parents)` → `$countryCode`; `$group = strtoupper($countryCode)`.
3. If there are remaining parents, extend the group key the same way the Addressing library does
   (`SubdivisionRepository::buildGroup`): append one `-` per remaining parent, then
   `hash('tiger128,3', implode('-', $parents))`.
4. Only when `$countryCode == 'MD'`:
   - `$cache_key = 'address.subdivisions.' . $group`.
   - `$filename = extensionPath->getPath('module', 'address_md') . '/json/' . $group . '.json'`.
   - If cached in `cache.data` → use it; else `@file_get_contents($filename)` →
     `json_decode(..., TRUE)` → `cache->set($cache_key, $definitions, CACHE_PERMANENT, ['subdivisions'])`.
   - `$event->setDefinitions($definitions)`.

## Bundled JSON (`json/`)

- **`MD.json`** — top level: `country_code: "MD"`, `locale: "ro"`, and `subdivisions` keyed by ISO
  code (`MD-CU` Chișinău, `MD-BA` Bălți, …), each with `iso_code/local_code/name/local_name` and
  `has_children`.
- **`MD-<hash>.json`** (e.g. `MD-019262394b3ee56b16ffb51a492d8fef.json`) — one file per district
  group, holding that district's localities. The file name is the group key computed in step 3, so
  the subscriber can locate the right leaf file without a lookup table.

## Operating notes

- The filename is built from the module's own path plus the **hashed** group key, not from raw
  request input — there is no user-controllable path segment, and the read is a local file, not a
  network fetch. `@file_get_contents` simply suppresses a warning if a group file is missing (the
  `$definitions` then stay as whatever Address provided).
- Subdivision lookups are cached permanently under the `subdivisions` tag; run `drush cr` (or
  invalidate that tag) after editing a JSON file.
- Correcting/adding localities means editing the relevant `json/*.json`, not PHP.
