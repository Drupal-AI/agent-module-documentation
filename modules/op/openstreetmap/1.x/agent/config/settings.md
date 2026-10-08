<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OSM Settings — the Overpass interpreter endpoint

## Install & enable

```bash
composer require drupal/openstreetmap   # pulls drupal/geofield ^1
drush en openstreetmap -y
```

Only module dependency is **`geofield`** (`openstreetmap.info.yml`); `composer.json` also requires
`ext-pdo`. No map library is bundled.

## The one setting

Route **`osm.settings`** → `/admin/config/osm` (menu: *Configuration*, link `osm.settings`),
form `Drupal\openstreetmap\Form\OSMSettingsForm` (a `ConfigFormBase`), route permission
**`administer osm_node`**.

- Field `endpoint` (textfield, "Interpreter Endpoint") → written to config object
  **`openstreetmap.settings`**, key **`endpoint`**, by `submitForm()`
  (`configFactory->getEditable('openstreetmap.settings')->set('endpoint', …)->save()`).
- This is the URL of an **Overpass API interpreter** (e.g.
  `https://overpass-api.de/api/interpreter`). Every OSM fetch in the module GETs this URL.
- If `endpoint` is empty, `Overpass::query()` throws
  `"OpenStreetMap Overpass API endpoint not configured"`.

## No config schema

The module ships **no `config/schema/*` and no `config/install/*`**
(`provides_config_schema = false`). The `openstreetmap.settings` object is created on first form
save and holds only `endpoint`. Strict config-schema tooling will flag it as schema-less.

## Config-set equivalent

```bash
drush cset openstreetmap.settings endpoint 'https://overpass-api.de/api/interpreter' -y
```

## Notes

- The endpoint is **site-wide and admin-only** — it is not taken from a request parameter. Pick a
  public instance you are allowed to use, or a self-hosted Overpass, and respect its usage policy
  (the service sets a 25s request timeout).
- The Overpass **query text** (what is sent to that endpoint) comes from admin forms / saved query
  entities, not the endpoint field. See [../api/overpass.md](../api/overpass.md).
