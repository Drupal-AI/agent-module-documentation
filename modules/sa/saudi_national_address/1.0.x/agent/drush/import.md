<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Import & resolve

## Install data
```bash
composer require yasseralsamman/saudi-national-address
drush en saudi_national_address -y
drush sna:import          # idempotent seed of regions/cities/districts
drush sna:import --purge  # wipe and re-import
drush sna:purge           # delete all SNA terms
```
Or import from **Configuration » Regional » Saudi National Address** (perm `administer sna data`).

## Resolver service (`saudi_national_address.address_resolver`)
```php
$r = \Drupal::service('saudi_national_address.address_resolver');
$address = $r->resolveByDistrictId(10100003001);  // full hierarchy
$cities  = $r->searchCities('Riyadh', $regionId); // escapeLike LIKE search
```
Smoke tests: `drush sna:resolve <districtId>`, `drush sna:reverse <lat> <lng>`.

## HTTP
- `GET /sna/children/{level}/{parent}` (`level` ∈ city|district) — dependent-select children (`access content`).
- `GET /sna/reverse?lat=&lng=&lang=` — reverse geocode (perm `use sna reverse geocode`).
