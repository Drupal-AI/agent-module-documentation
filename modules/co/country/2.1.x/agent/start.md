<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Country — agent index

Adds a `country` field type storing a 2-letter ISO 3166 code, resolved to a name via core's
`country_manager`. Configured entirely through the Field UI — **no admin settings page**
(`configure: null`), no permissions, no Drush. Depends on core `field`.

- **Add/configure a country field — widgets, formatters, `selectable_countries` setting** →
  [configure/field.md](configure/field.md)
- **Programmatic use — the `country` form element, `country.field.manager` service, token** →
  [api/api.md](api/api.md)
- **Views filter/sort, Facets processor, Feeds target** →
  [integrations/integrations.md](integrations/integrations.md)

Quick reference:
- Field type id `country`; stored value = ISO alpha-2 code (`value`, length 2).
- Default widget `country_default` (select); also `country_autocomplete` (text + autocomplete).
- Default formatter `country_default` (name); also `country_iso_code` (raw code).
- Field/storage setting `selectable_countries` (sequence of ISO codes) limits choices.
- Views filter + sort id `country_item`; Facets processor id `country_name`; Feeds target id `country`.
- Token `[<entity>:<field>:country_original_name]` → the country name.
- Service `country.field.manager`; autocomplete route `country.autocomplete`.
