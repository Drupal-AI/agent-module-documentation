# Configuration

Most of what you do with Saudi National Address happens after the data is
imported: managing that data, attaching the dependent fields, and calling the
resolver. This page covers each.

## The import / management screen

Go to **Configuration → Regional → Saudi National Address**
(`/admin/config/regional/sna`). This screen lets you import and refresh the
region/city/district reference data from the admin UI, and it is restricted to
users with the **`administer sna data`** permission — keep that to trusted
administrators, since it can seed or purge the whole dataset. The equivalent Drush
commands are `drush sna:import`, `drush sna:import --purge` and `drush sna:purge`
(see [Installation](../installation/index.md)).

## Dependent address fields

To capture Saudi addresses, attach the module's cascading entity‑reference fields
to any entity. Once in place they behave as a linked set:

- choosing a **region** filters the available **cities**;
- choosing a **city** filters the available **districts**;
- on submit, a custom selection handler rejects any child term that does not
  actually belong to the selected parent, so you cannot save a mismatched
  region/city/district combination.

The dependent selects are powered behind the scenes by the
`/sna/children/{level}/{parent}` endpoint (where `level` is `city` or `district`),
which is gated by the `access content` permission and returns only public
geographic reference data. If you enabled the optional Select2 submodule, these
selects gain search‑as‑you‑type.

## The AddressResolver service

For anything beyond form entry, call the resolver service in code:

```php
$r = \Drupal::service('saudi_national_address.address_resolver');
$address = $r->resolveByDistrictId(10100003001);   // full region → city → district hierarchy
$cities  = $r->searchCities('Riyadh', $regionId);   // typeahead search (escaped LIKE)
```

It can resolve a full hierarchy from an 11‑digit district ID, look up
regions/cities/districts by their National Address ID, navigate the hierarchy, run
typeahead searches, work with coordinates (nearest city or region, distances),
reverse‑geocode a lat/lng to a region/city/district, and validate hierarchies —
returning typed, language‑aware value objects.

## Reverse‑geocode endpoint

A dedicated HTTP route performs coordinate reverse lookup:
`GET /sna/reverse?lat=&lng=&lang=`. It is gated by the **`use sna reverse
geocode`** permission, separate from the public children endpoint, so you can
grant coordinate lookups only to the roles that need them.

## A note on translations

The term names are stored with English (default) and Arabic translations, so your
address forms and lookups can present region/city/district names in either
language via the site's language handling.
