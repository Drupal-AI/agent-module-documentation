<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Event subscribers

Registered in `acquia_cms_common.services.yml`.

| Service | Class | Event | Behavior |
| --- | --- | --- | --- |
| `acquia_cms_common.event_subscriber` | `EventSubscriber\ConfigEventsSubscriber` | `ConfigEvents::SAVE` | Reacts to config saves to keep views configuration consistent with which ACMS/related modules are available (skips during installer). |
| `acquia_cms_common.https_redirect_subscriber` | `EventSubscriber\HttpsRedirectSubscriber` | `KernelEvents::REQUEST` | When `acquia_cms_common.settings:acquia_cms_https` is true and the host is not localhost, issues a `TrustedRedirectResponse` to the HTTPS URL. Skips requests already `HTTP_X_FORWARDED_PROTO: https`. Uses 301 for cacheable methods, 308 otherwise; cache-tagged on the settings config. |
| `acquia_cms_common.telemetry` | `EventSubscriber\KernelTerminate\AcquiaCmsTelemetry` | `KernelEvents::TERMINATE` | Emits anonymized usage telemetry (see below). |
| `acquia_cms_common.route_subscriber` | `Routing\RouteSubscriber` | dynamic routes | Repoints `system.403`/`system.404` to `Controller\CustomHttp4xxController` for custom access-denied / not-found pages. |

## Telemetry (`AcquiaCmsTelemetry`)

On `KernelEvents::TERMINATE` (after the response is sent), when all of these hold:
- running on an Acquia hosting environment (`AcquiaDrupalEnvironmentDetector::isAhEnv()`),
- not CLI (`PHP_SAPI !== 'cli'`), not CI (`getenv('CI')` falsy),
- more than 24h since the last send, and the payload hash changed,

it records an event via the Drupal logger channel (which Acquia's infrastructure forwards to syslog / Sumo
Logic — there is **no direct outbound HTTP request from this class**) and stores
`acquia_cms_common.telemetry.hash` / `.timestamp` in state. Failures are swallowed unless
`acquia_connector.telemetry.loud` state is set.

Payload (`getAcquiaCmsTelemetryData()`): a hashed `user_id` (base64 hash of the site UUID), PHP & Drupal
versions, Acquia application UUID / name / environment, ACSF status, site URI + site name, starter-kit
name and wizard status, Site Studio status, install time, install profile, and the version/enabled status
of every `acquia*` / `cohesion*` / `sitestudio*` extension.
