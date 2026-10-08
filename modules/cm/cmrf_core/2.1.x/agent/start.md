<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CiviMRF Core (cmrf_core) — agent index

Drupal-side abstraction for calling a **CiviCRM** instance's API (APIv3 and APIv4), either **remotely
over REST** or **locally in-process**. Version **2.1.17**, core `^8 || ^9 || ^10 || ^11`, package
CiviCRM, GPL-2.0-or-later. Depends on the upstream library `civimrf/cmrf_abstract_core` (^0.10.8),
autoloaded from the project vendor tree.

## What it is
A thin persistence-and-transport wrapper over `civimrf/cmrf_abstract_core`. Code gets the
`cmrf_core.core` service, builds a `Call`, executes it, reads the reply. Two config entities drive
everything: a **profile** (`cmrf_profile`) holds the CiviCRM URL(s) + `site_key` + `api_key`; a
**connector** (`cmrf_connector`) names the calling module and points at a profile, choosing `remote`
(cURL REST) or `local` (`civicrm_api3`/`civicrm_api4` in-process). Every call is logged to the
`civicrm_api_call` DB table and may be served from cache.

## Core mechanism (read `agent/api/making-calls.md`)
- `\Drupal::service('cmrf_core.core')->createCall($connector, $entity, $action, $params, $options, $callback, $api_version)` → `Call`.
- `$core->executeCall($call)` runs it synchronously; `$call->getReply()` returns the decoded array.
- `remote` → `RemoteConnection` (extends `CMRF\Connection\Curl`): POST to the profile URL with
  `api_key` + `key` (site key) in the body. `local` → `LocalConnection` (extends `CMRF\Connection\Local`):
  direct CiviCRM API as the current user.
- Persistence/caching in `src/CallFactory.php`; cache keyed on request hash + connector + `cached_until`.
- Purge on cache flush and cron; per-profile `cache_expire_days` and `cache_clear_failed_api_calls`.

## Configuration (read `agent/config/profiles-and-connectors.md`)
Admin UI under `/admin/config/cmrf` → **CiviMRF Profiles** and **CiviMRF Connectors**. Both entity
types use `admin_permission = "administer site configuration"`. A "Test" operation on each connector
runs `Entity.get` and prints the reply.

## Submodules (read `agent/submodules/overview.md`)
- **cmrf_views** — exposes CiviCRM API calls as Views data (datasets, relationships, field/filter/query plugins for APIv3 and APIv4).
- **cmrf_webform** — posts Webform submissions into CiviCRM (usually a FormProcessor), pre-fills fields from API calls, supports immediate or queued sending.
- **cmrf_call_report** — Views-based report of the `civicrm_api_call` log, with per-call detail, resubmit, and purge (gated by `access site reports`).
- **cmrf_example** — sample `CiviClient` service demonstrating a `Contact.get` call.

## Key source files
- `src/Core.php` — the `cmrf_core.core` service; profile/connector loading, connector registration.
- `src/Call.php` — the Call value object (APIv3/v4 request compile, status, retry, callbacks).
- `src/CallFactory.php` — DB persistence + cache lookup for the `civicrm_api_call` table.
- `src/RemoteConnection.php` / `src/LocalConnection.php` — transport selection.
- `src/Entity/CMRFProfile.php`, `src/Entity/CMRFConnector.php` — the two config entities.
- `src/Form/CMRFProfileForm.php`, `src/Form/CMRFConnectorForm.php` — admin forms.
- Library transport: `vendor/civimrf/cmrf_abstract_core/CMRF/Connection/*.php`.

## Deployment notes for agents
- The `api_key`/`site_key` grant access to the entire CRM — use the most restricted CiviCRM API user.
- Keep credentials out of committed/exported config; prefer a Key entity or environment variable for the values.
- Remote calls are synchronous and on the request path — cache with `options['cache'] => '10 minutes'`.
