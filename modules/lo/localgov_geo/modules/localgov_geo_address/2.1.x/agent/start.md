<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Geo Address (localgov_geo_address) — agent index

Bundle-provider submodule of [localgov_geo](../../../../2.1.x/agent/start.md): the **point +
address** geo bundle. Config only — no routes, permissions, schema or Drush.

Key facts:
- Depends on `localgov_geo` and **`geo_entity:geo_entity_address`** (which supplies the address
  behaviour; this module supplies the LocalGov bundle configuration).
- This is the bundle the rest of the LocalGov stack references:
  - `localgov_directories_location` installs `field.storage.node.localgov_location` pointing at it;
  - Directories venue/organisation entries and events use that field.
- Records are entities, so one address can be referenced from many nodes — editors usually create
  them **inline** (Inline Entity Form) from the referencing node's edit form.
- Geocoding uses whichever provider the site configured in the Geocoder module: OpenStreetMap by
  default, or `LocalgovOsPlacesGeocoder` (Ordnance Survey Places) for UK addresses — see the
  parent module's docs.
- Remember the parent's install-time grant of **`view geo` to anonymous**: address records are
  public by default so they appear in anonymous-visible search indexes.
