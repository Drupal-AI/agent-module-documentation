<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integrates the eWeLink (Sonoff / CoolKit) smart-home cloud API into Drupal so authorised users can trigger eWeLink devices from the site and every action is logged as an Activity entity.

---

eWeLink connects a Drupal site to the eWeLink cloud through the bundled `pjanisio/ewelink-api-php` PHP library (OAuth authorization-code flow against CoolKit's regional gateways). It ships an admin settings form at `/admin/config/ewelink/settings` for the API application credentials (App ID, App Secret, Redirect URL, account email/password, region) and for configuring an "Open the Door" page, a customizable page (`/open-the-door`) of one or more submit buttons that each map to a device (or a specific outlet of a multi-channel device) and send an on/off command via the library's `Devices::setDeviceStatus()`. Two helper controller routes (`/ewelink/index`, `/ewelink/after_auth`) drive the OAuth login/redirect handshake and list the account's devices. Every button press is recorded through `ewelink_activity_record()` into the module's own `ewelink_activity` content entity (fields: name, event type, related entity, description, owner, status, timestamps), which has a permission-gated admin collection at `/admin/content/ewelink_activity` and a shipped View. The module also creates an "Open the Door User" role and an "Access the Open the Door page" permission. It targets a single-purpose IoT/home-automation use case (the maintainer's "Bee Hotel" door-lock scenario) and expects site builders to add their own front-end JS (the README suggests the OnsenUI framework) on top of the pages it exposes.

---

- Control eWeLink / Sonoff smart-home devices (locks, switches, relays) directly from a Drupal site.
- Publish an "Open the Door" page (`/open-the-door`) with configurable buttons that unlock a door or trigger a device.
- Toggle a single-channel Sonoff switch on or off from a button click.
- Toggle one specific outlet on a multi-channel device (e.g. a Sonoff 4CH Pro, outlets `0`–`3`) using the `DEVICE_ID:OUTLET` device format.
- Configure how many door/device buttons to show and give each a label and target device.
- Log every device operation as an `ewelink_activity` entity for auditing and usage analytics.
- Record who operated which device and when (owner user, event type, human-readable description, created/changed timestamps).
- Review the device-operation log at the admin Activities collection (`/admin/content/ewelink_activity`) or through the shipped `ewelink_activity` View.
- Restrict who may operate devices using the "Access the Open the Door page" permission and the "Open the Door User" role.
- Assign the "Open the Door User" role manually through People (`/admin/people`) or programmatically from custom code (`hook_cron`, user-save hooks).
- Tie device access to an external condition such as an active booking window (the maintainer's "Bee Hotel" use case).
- Authenticate the site to the eWeLink cloud via the OAuth authorization-code flow from `/ewelink/index`.
- Select the eWeLink account region (United States, Europe, Asia, China) for the correct CoolKit API gateway.
- List the eWeLink account's devices with model and online/offline status once authenticated.
- Store the eWeLink OAuth application settings (App ID, App Secret, Redirect URL, email, region) in a single admin form.
- Build a custom device-control front end (e.g. with the suggested OnsenUI framework) against the pages the module exposes.
- Provide a Views-based, filterable report of device activity for site administrators.
- Extend the concept to further eWeLink device types (lights, sensors, cameras) by reusing the library's `Devices` API.
- Give facilities/reception staff a simple web button to open a physical door instead of handing out physical keys.
- Track and export device-usage history for reporting by pointing Views at the `ewelink_activity` base table.
- Centralise smart-device control and its audit trail inside an existing Drupal admin, rather than the eWeLink mobile app.
