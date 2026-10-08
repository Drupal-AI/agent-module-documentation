<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CiviMRF Core (cmrf_core) lets Drupal call a CiviCRM instance's API — remotely over CiviCRM's REST endpoint or locally in-process — through a `cmrf_core.core` service, using admin-defined connection profiles (URL + site key + API key) and connectors. Submodules expose the results to Views and Webform.

---

The mechanism is a thin persistence-and-transport layer over the upstream `civimrf/cmrf_abstract_core` library. Code obtains the `cmrf_core.core` service and calls `$core->createCall($connector, $entity, $action, $params, $options)` to build a `Call` value object, then `$core->executeCall($call)` to run it; the reply comes back with `$call->getReply()`. A **connector** (config entity `cmrf_connector`) names which module is calling and points at a **profile** (config entity `cmrf_profile`) that holds the CiviCRM APIv3 URL, APIv4 URL, `site_key` and `api_key`. A connector is either `remote` (default) — a cURL POST to the CiviCRM REST endpoint with `api_key`/`key` in the POST body, class `RemoteConnection` extending the library's `CMRF\Connection\Curl` — or `local` (only when the `civicrm` service is present, i.e. CiviCRM installed in the same Drupal) which calls `civicrm_api3()`/`civicrm_api4()` directly as the logged-in user. Both APIv3 and APIv4 are supported. Every call is persisted to the `civicrm_api_call` database table (a call log with status, request, reply, metadata, timing) via `CallFactory`; if the call's `options['cache']` is set (e.g. `'10 minutes'`), an identical prior call within its `cached_until` window is returned from that table instead of hitting CiviCRM. `hook_cache_flush()` and cron purge cached/DONE calls and honor each profile's `cache_expire_days`. The architecture is the point: CiviCRM can be installed inside Drupal (sharing DB and user table, tightly coupling the two upgrade cycles) or run elsewhere and reached over the API so the two upgrade independently — CiviMRF is what makes the decoupled deployment usable. Three deployment concerns: the API credentials are a grant over the whole CRM (donors, members, giving history) so scope the CiviCRM API user tightly; personal data crosses a network boundary on every remote call, so the transport and the processing belong in the privacy assessment; and remote calls sit on the request path, so cache aggressively and decide what a page shows when the CRM is unreachable. Version 2.1.17, core `^8 || ^9 || ^10 || ^11`. Admin UI lives under `/admin/config/cmrf` (Profiles and Connectors), gated by `administer site configuration`.

---

- Connect a Drupal site to an external CiviCRM over REST.
- Reach a CiviCRM installed in the same Drupal via the local (in-process) API.
- Make an APIv3 `Contact.get` call from custom code through `cmrf_core.core`.
- Make an APIv4 call to CiviCRM from a Drupal module.
- Cache a CiviCRM API result for N minutes to keep it off the request path.
- Configure multiple CiviCRM connection profiles (staging vs production).
- Route different modules' calls through separate named connectors.
- Build a membership list or event listing as a View from CiviCRM data (cmrf_views).
- Post a Webform submission into CiviCRM's FormProcessor (cmrf_webform).
- Pre-fill Webform fields from a CiviCRM API call (cmrf_webform default values).
- Queue a Webform submission to CiviCRM for background processing.
- Inspect, resubmit, and purge the CiviCRM API call log (cmrf_call_report).
- Test a connector's configuration from the admin UI (Entity.get probe).
- Decouple CiviCRM's upgrade cycle from Drupal's.
- Share one CiviCRM instance across several Drupal sites.
- Show a signed-in user their own membership status from the CRM.
- Register event attendance submitted through a form.
- Store CiviCRM credentials as a profile referenced by many connectors.
- Retry failed calls automatically on a schedule (retry_count/retry_interval options).
- React to call completion/failure via `hook_cmrf_core_call_done` / `hook_cmrf_core_call_failed`.
- Wrap CiviCRM calls in a service class (see the cmrf_example CiviClient).
