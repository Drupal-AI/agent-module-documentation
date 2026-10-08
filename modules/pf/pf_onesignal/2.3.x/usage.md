<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Push Framework OneSignal registers OneSignal as a delivery channel for the Push Framework, sending mobile push notifications to a user's registered devices.
---
The channel plugin (`OneSignal`) collects a user's active device player-ids from the `onesignal_device` entity and POSTs a notification to `https://onesignal.com/api/v1/notifications` using the app id and REST auth key from `pf_onesignal.settings`, over HTTPS with a retry-up-to-3-attempts policy; the target entity's canonical URL is included as `targetUrl`. Devices are created via the `/onesignal/register` endpoint, whose controller (`Register`) requires an **authenticated** user (`_custom_access` returning forbidden for anonymous), parses a JSON body, and creates/updates a device row scoped to the current user's uid. A "My devices" personal tab (`/user/{user}/devices`) is gated by the core personal-contact-tab access check, and a settings form lives at `/admin/config/system/push_framework/onesignal` behind `administer site configuration`.

The module also serves the Apple App Site Association file at `/apple-app-site-association` and `/.well-known/apple-app-site-association` with `_access: 'TRUE'` — these are public-by-design universal-link manifests, not a finding. TLS is not disabled and the auth key is stored in config and sent as an `Authorization: Basic` header. Typical setup: enable the module (requires Push Framework), enter the OneSignal App ID and REST API auth key on the settings form, wire your mobile app's OneSignal SDK to POST device info to `/onesignal/register`, and enable the OneSignal channel in Push Framework.
---
- Deliver Push Framework notifications through OneSignal.
- Register a user's mobile device player-id via `/onesignal/register`.
- Update device metadata (OS, model, language, app version) on re-registration.
- Store the OneSignal App ID and REST auth key on the settings form.
- Let users view their registered devices on the `/user/{user}/devices` tab.
- Send localized headings/contents (with an English fallback) per notification.
- Include the target content's canonical URL as `targetUrl` in the push payload.
- Retry failed sends up to three attempts before marking failed.
- Serve the Apple App Site Association manifest for universal links.
- Scope device registrations to the authenticated user's account.
- Deactivate a device (status) to stop targeting it.
- Integrate a native app's OneSignal SDK with the Drupal backend.
- Restrict channel configuration to `administer site configuration` holders.
- Use the provided `my_devices` view to list devices.
- Combine with other Push Framework channels for multi-channel delivery.
- Enable/disable the OneSignal channel from Push Framework settings.
- Send only to users who have at least one active registered device.
- Keep push credentials in config (consider overriding via settings for secrets).
- Log OneSignal API/JSON errors to the `onesignal` logger channel.