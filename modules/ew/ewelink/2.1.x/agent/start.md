<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eWeLink (ewelink) — agent index

Integrates the eWeLink / Sonoff (CoolKit) smart-home cloud API into Drupal to trigger devices from the site and log each action. Wraps the bundled `pjanisio/ewelink-api-php` (`^3`) PHP library which performs the OAuth authorization-code flow and device control.

- **Version documented:** 2.1.0-rc2 (pre-release). `core_version_requirement: ^10 || ^11`. License GPL-2.0-or-later. PHP `>=7.4`.
- **Composer:** `drupal/ewelink`; requires `pjanisio/ewelink-api-php: ^3`.
- **Declared module deps:** none in `ewelink.info.yml`. Runtime it relies on core `views`, `node`, `user` (shipped View + `related_entity` node reference + Activity owner); enable `views` for the shipped config to import.

## What it provides
- **Content entity** `ewelink_activity` (`Drupal\ewelink\Entity\ewelinkActivity`) — the device-action log. Fields: `user_id` (owner), `name`, `event_type` (list), `related_entity` (node ref), `description`, `status`, `created`, `changed`. Admin routes under `/admin/content/ewelink_activity`. See [`agent/entity/activity.md`](entity/activity.md).
- **Permissions** (`ewelink.permissions.yml`): `access ewelink open-the-door`, `administer activity entities`, `view/add/edit/delete activity entities`. Entity access via `Drupal\ewelink\ewelinkActivityAccessControlHandler`.
- **Role + config** shipped in `config/install/`: role `ewelink_user` (label "Ewelink User", holds `access ewelink open-the-door`) and View `ewelink_activity`. `ewelink.install` (`ewelink_role_install()`) additionally creates a role `open_the_door_user`.
- **Settings form** `Drupal\ewelink\Form\EwelinkConfigForm` at route `ewelink.settings` (`/admin/config/ewelink/settings`), config object `ewelink.settings`. See [`agent/config/settings.md`](config/settings.md).
- **Routes / pages** (`ewelink.routing.yml`): `ewelink.open_the_door` (`/open-the-door`, form `OpenTheDoor`), `ewelink.index` (`/ewelink/index`), `ewelink.after_auth` (`/ewelink/after_auth`), plus `ewelink.settings`. See [`agent/routes/pages.md`](routes/pages.md).
- **Library integration**: all cloud calls go through `pjanisio\ewelinkapiphp\HttpClient` / `Token` / `Devices`. See [`agent/api/ewelink-api-php.md`](api/ewelink-api-php.md).
- **Helper**: `ewelink_activity_record($data)` in `ewelink.module` creates an `ewelink_activity` from a device action.
- No Drush commands. No config schema (`config/schema/` absent). No plugin types.

## Notes for agents
- `ewelink.libraries.yml` declares a `main` library referencing `assets/css/*` and `assets/js/ewelink.js`, but **no `assets/` directory ships** and nothing attaches the library — it is effectively dead.
- The settings form fields for credentials carry literal `@TODO: USE this instead of Constants.php` descriptions; see the config doc for how credentials actually reach the library.

## Solution docs
- [`config/settings.md`](config/settings.md) — settings form, `ewelink.settings` keys, credential mechanism, "Open the Door" button config.
- [`entity/activity.md`](entity/activity.md) — the `ewelink_activity` entity, fields, permissions, list builder, View, `ewelink_activity_record()`.
- [`routes/pages.md`](routes/pages.md) — routes, controllers/forms, OAuth login/redirect flow, device-control click path.
- [`api/ewelink-api-php.md`](api/ewelink-api-php.md) — the `pjanisio/ewelink-api-php` library: HttpClient/Token/Devices, gateways, config resolution.
