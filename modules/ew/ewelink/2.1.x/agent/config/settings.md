<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eWeLink — settings form & configuration

## Route / form
- Route `ewelink.settings` → `/admin/config/ewelink/settings`, title "eWeLink Settings", requirement `_permission: 'administer site configuration'` (`ewelink.routing.yml`).
- Form `Drupal\ewelink\Form\EwelinkConfigForm` (`getFormId()` = `ewelink_settings`), extends `ConfigFormBase`; editable config = `ewelink.settings`.
- Admin menu link `ewelink.settings` under **Configuration → (Web Services group)** (`ewelink.links.menu.yml`, parent `system.admin_config_services`).

## Config object: `ewelink.settings`
Written by `EwelinkConfigForm::submitForm()`. There is **no `config/schema/`** in the module, so these keys are schema-less.

Top-level keys:
- `region` — select, one of `us` / `eu` / `as` / `cn` (default `us`).
- `appid` — eWeLink OAuth application ID (required).
- `appsecret` — eWeLink OAuth application secret (required).
- `redirecturl` — OAuth redirect URL (required).
- `email` — eWeLink account email (required).
- `password` — eWeLink account password (`#type: password`, not required).
- `open_the_door_how_many` — select 1–6, number of buttons on the Open the Door page.
- `open_the_door_label_{i}` — label for button *i*.
- `open_the_door_device_{i}` — target device for button *i*. Format: `DEVICE_ID` for single-channel, `DEVICE_ID:OUTLET` for multi-channel (outlet index, e.g. `0`–`3` on a 4CH device).
- `getter.open_the_door.{label}.id` — a mirror of each button's device string keyed by its label, written alongside the pair above; read back at click time as `$config->get('getter')['open_the_door'][$label]['id']`.

The buttons loop runs `for ($i = 1; $i <= open_the_door_how_many + 1; $i++)` in both `buildForm()` and `submitForm()`, so it always renders/saves one extra button beyond the selected count.

## How credentials reach the eWeLink cloud (important)
The credential fields above are stored into `ewelink.settings`, but each field's `#description` is the literal `@TODO: USE this instead of Constants.php`. In this release the module instantiates the library as `new HttpClient()` with **no** configuration overrides (see `OpenTheDoor.php`, `ContainerInfoController.php`). The library therefore resolves its own credentials via `pjanisio\ewelinkapiphp\Config` → `Constants.php` fallback (or an optional `config.json` in the library's `JSON_LOG_DIR`), **not** from `ewelink.settings`. See [`../api/ewelink-api-php.md`](../api/ewelink-api-php.md) for the resolution order.

Practical consequence: setting App ID / secret / region only in the Drupal form does not yet configure the API client; the working credentials are those the `pjanisio/ewelink-api-php` library reads (its `Constants.php` / `config.json`). The `region` select likewise duplicates the library's own `REGION`. Treat the Drupal form as the intended-but-not-yet-wired credential store for this pre-release.

The module does **not** implement any environment-variable / `getenv()` / dotenv / Key-entity credential mechanism — there is no such code. Do not assume one.
