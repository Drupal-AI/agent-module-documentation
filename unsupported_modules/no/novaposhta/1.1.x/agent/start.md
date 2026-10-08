<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NovaPoshta API (novaposhta) — agent index

Nova Poshta (Ukrainian parcel carrier) delivery integration for the **Basket** online-store
module. Package `Online store`. PHP **8.1**, core `^10 || ^11 || ^12`. License GPL-2.0-or-later.
Version dir `1.1.x` (packaged `1.1.10`).

> **Naming:** the drupal.org project is packaged **`basket_novaposhta`**; the module machine name
> is **`novaposhta`** (composer `drupal/novaposhta`). Enable with `drush en novaposhta`.

- **Settings form, config objects, schema, cron, drush** → [config/settings.md](config/settings.md)
- **The API clients (transport + facade), routes, tables** → [api/client.md](api/client.md)
- **Basket delivery + Views plugins** → [plugins/delivery.md](plugins/delivery.md)

## What it actually is

- Depends on **`basket`** and core **`views`** (info.yml `dependencies`). Not Drupal Commerce.
- Two API layers in `src/API/`: **`NovaPoshtaApi2`** (raw POST client to
  `https://api.novaposhta.ua/v2.0/json/`, ported from the lis-dev library) and
  **`NovaPoshtaAPI`** (store-facing facade adding file cache + DB reference tables). English-order
  surface in `NovaPoshtaEN` / `NovaPoshtaENForm`; admin screens in `AdminPages`; Views output in
  `NovaPoshtaView` + `ViewsAlter`.
- **Service** `NovaPoshta` (`Drupal\novaposhta\NovaPoshta`, id `NovaPoshta`) holds cron, reference
  list updates (`runUpdate`), file cache (`variableGet/variableSet`) and helpers. Hook services
  `NovaposhtaHooks` and `NovaposhtaViewsHooks` (both `autowire: true`).
- **Delivery plugins** (`@BasketDelivery`): `novaposhta` (warehouse), `novaposhta2`,
  `novaposhta_address` (courier-to-address). **Views plugins**: fields `novaposhta_en_num`,
  `novaposhta_en_cost`, `novaposhta_en_weight`, `novaposhta_en_address`, `novaposhta_en_settings`;
  filter `novaposhta_en_date`; wizard `novaposhta_en`. Bundled View `views.view.novaposhta`.

## Routes (`novaposhta.routing.yml`)

- `novaposhta.settings` — `/admin/config/development/novaposhta`, `_form NovaPoshtaSettingsForm`,
  permission **`access novaposhta settings`**.
- `novaposhta.autocomplete_cities` — `/basket/novaposhta/autocomplete/cities`, GET,
  `_access: 'TRUE'` (public checkout autocomplete), `AutocompleteController::cities`.
- `novaposhta.autocomplete_streets` — `/basket/novaposhta/autocomplete/streets/{ref}`, GET,
  `_access: 'TRUE'`, `AutocompleteController::streets`.

## Permissions, drush, tables

- Permissions (`novaposhta.permissions.yml`, both `restrict access: true`):
  **`access novaposhta settings`**, **`access novaposhta en`**.
- Drush (`drush.services.yml` → `NovaPoshtaCommands`): **`novaposhta:status_update`** (runs the cron
  routine) and **`novaposhta:list <type>`** (rebuild `area`/`city` lists).
- Tables (`novaposhta.install`): `novaposhta` (per-order chosen branch), `novaposhta_en`
  (waybills), `novaposhta_en_orders` (order↔waybill), `novaposhta_lists` (area/city reference).
- Config objects: `novaposhta.settings` (has schema), `novaposhta.en.settings`,
  `novaposhta.en.template`, `novaposhta.OptionsSeat`.

```bash
drush en novaposhta -y
drush cget novaposhta.settings
drush novaposhta:status_update       # refresh waybill statuses (also on cron)
drush novaposhta:list city           # rebuild the city reference table
```

Credentials: the carrier API key is stored in `novaposhta.settings:config.api_key`
(`NovaPoshtaSettingsForm`). Set/track it deliberately before exporting config.
