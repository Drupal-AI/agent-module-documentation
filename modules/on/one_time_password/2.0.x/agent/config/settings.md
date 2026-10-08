<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings, force-OTP, schema

Sources: `src/Form/OneTimePasswordSettings.php`, `src/EventSubscriber/ForceOneTimePasswordSubscriber.php`,
`config/schema/one_time_password.schema.yml`, `one_time_password.routing.yml`, `one_time_password.install`.

## Config object `one_time_password.settings`

| Key | Type | Meaning |
|---|---|---|
| `force_otp` | boolean | When true, every authenticated user without 2FA is redirected to the setup form until they enable it. |

That is the only setting. Schema is `config_object` with a single `force_otp` boolean
(`config/schema/one_time_password.schema.yml`). No `config/install` file ships, so the value is unset
(falsy) by default.

## Settings form

Route `one_time_password.settings` → `/admin/config/people/one_time_password/settings`
(`_permission: 'administer one time password settings'`). `OneTimePasswordSettings` is a `ConfigFormBase`
with a single *Force all authenticated users to enable OTP* checkbox that reads/writes `force_otp`. Menu
link under *Configuration › People* (`one_time_password.links.menu.yml`, parent `user.admin_index`).
`configure` in `.info.yml` points here.

## Force-OTP enforcement — `ForceOneTimePasswordSubscriber`

`KernelEvents::REQUEST` subscriber. If `force_otp` is on and the current user is authenticated and their
`one_time_password` field is empty, it adds a warning and redirects to `one_time_password.setup_form` for
their own uid — **unless** the current route is in `IGNORE_ROUTES`:

```
one_time_password.setup_form, one_time_password.settings, user.logout, system.css_asset, system.js_asset
```

So a forced user can still reach the setup form, the settings form, log out, and load CSS/JS assets, but
every other route bounces to setup until they enrol.

## Install / requirements

`hook_install` (`one_time_password.install`) calls `UserFieldAttach::installFieldDefinition()` to install
the `one_time_password` base field storage on the user entity. `hook_requirements` (runtime) inspects the
`authentication_collector`; if any non-`cookie` authentication provider is enabled it emits a
`REQUIREMENT_WARNING` on the status report listing them, because such providers may authenticate requests
without going through the 2FA-guarded login flows (potential MFA bypass).
