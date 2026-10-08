<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eWeLink — routes, pages & device-control flow

All routes are in `ewelink.routing.yml`.

| Route | Path | Handler |
|-------|------|---------|
| `ewelink.settings` | `/admin/config/ewelink/settings` | Form `EwelinkConfigForm` |
| `ewelink.open_the_door` | `/open-the-door` | Form `OpenTheDoor` |
| `ewelink.index` | `/ewelink/index` | `ContainerInfoController::index` |
| `ewelink.after_auth` | `/ewelink/after_auth` | `ContainerInfoController::after_auth` |

Settings form is documented in [`../config/settings.md`](../config/settings.md).

## OAuth login / device listing — `ContainerInfoController`
`src/Controller/ContainerInfoController.php` (final, `ContainerInjectionInterface`; `create()` returns `new static()` — no injected services). Uses `pjanisio\ewelinkapiphp\{HttpClient,Constants,Utils}`.

- **`index()`** (`/ewelink/index`): builds `HttpClient` + `Token`. If `Token::checkAndRefreshToken()` is false, returns a `TrustedRedirectResponse` to the library login URL (`HttpClient::getLoginUrl()`) to start the OAuth authorization-code flow. Once authenticated it fetches `HttpClient::getDevices()->getDevicesList()` and renders a `#type => table` of device Name / Model / Online-Offline status, plus a "You are authenticated" block showing token expiry via `date.formatter`.
- **`after_auth()`** (`/ewelink/after_auth`): the OAuth redirect landing. When `code` and `region` query params are present it calls `Token::getToken()` to exchange the code; otherwise it either reports the authenticated state (token expiry) and lists devices, or, when unauthenticated, prints a link to the library login URL. This method is unfinished developer scaffolding (stray `echo`/`exit`/`die` output and several undefined-variable references such as `$token`, `$d['devs']`) — not a production-ready page; it will fatal partway through in the authenticated branch.

The actual token exchange, refresh and storage happen in the library (`Token::getToken()` POSTs `/v2/user/oauth/token`; tokens persist to `token.json` in the library's `JSON_LOG_DIR`). See [`../api/ewelink-api-php.md`](../api/ewelink-api-php.md).

## "Open the Door" page — `OpenTheDoor`
`src/Form/OpenTheDoor.php` (final, extends `FormBase`; `getFormId()` = `ewelink_open_the_door`; `create()` returns `new static()`). Uses `HttpClient` and `Devices` from the library.

- **`buildForm()`**: reads `ewelink.settings` and renders the page shell (a `box-container` with a "Click to open" box for permitted users, a login link for anonymous users, or a "Buttons are disabled. Contact admin." notice otherwise). It then appends one AJAX submit button per configured button (`for $i = 1 .. open_the_door_how_many + 1`), each with `#value` = `open_the_door_label_{i}` and `#ajax` callback `::promptCallback` targeting wrapper `box-container`.
- **`promptCallback()`**: the AJAX handler that performs the device action. It reads the clicked button label from `$form_state->getValue('op')`, looks up the device string via `$config->get('getter')['open_the_door'][$label]['id']`, splits it with `getOpeningDevice()` into `id`/`outlet`, builds `params = ['switch' => 'on', 'outlet' => …]`, and calls `Devices::setDeviceStatus($id, $params, 0)` to switch the physical device on. It updates the box markup with a "Clicked submit … <timestamp>" message and calls `ewelink_activity_record($d)` to log the action (see [`../entity/activity.md`](../entity/activity.md)).
- **`getOpeningDevice($device)`**: `explode(':', $device)` → `['id' => tmp[0], 'outlet' => tmp[1]]` (so a bare single-channel id yields a null outlet).
- `submitForm()` is empty (all work is in the AJAX callback).

## Roles & permissions created
- `config/install/user.role.ewelink_user.yml`: role `ewelink_user` ("Ewelink User") holding permission `access ewelink open-the-door`.
- `ewelink.install` → `ewelink_role_install()`: also creates role `open_the_door_user` ("Open the Door User"); `ewelink_role_uninstall()` deletes it. (The install file's docblock/logger use the name `ewelink_role`.)
