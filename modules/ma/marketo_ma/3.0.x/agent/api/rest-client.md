<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST client & lead flow — marketo_ma

## Client wiring (marketo_ma.services.yml)
- `marketo_ma.rest.config` (`Rest\Config`) — extends `NecLimDul\MarketoRest\Configuration`; supplies
  `baseUrl` = `https://{munchkin.account_id}.mktorest.com`, `clientId`, `clientSecret` (from secrets).
- `marketo_ma.rest.client` — a `GuzzleHttp\Client` built by
  `NecLimDul\MarketoRest\ClientFactory::createOauthClient($config)`. OAuth `client_credentials` grant;
  access token cached (`AccessTokenCacheHandler`), added as an Authorization header, retried on auth error.
  TLS verification is Guzzle default (**on**) — the module does not disable it.
- `marketo_ma.rest.lead.leads` / `.activities` — `NecLimDul\MarketoRest\Hacks\API\LeadsApi` / `ActivitiesApi`.
- `marketo_ma.api_client` (`Service\MarketoMaApiClient`) — Drupal-facing wrapper over those APIs.

## MarketoMaApiClient (src/Service/MarketoMaApiClient.php)
- `getFields()` — `describeUsingGET2()`; returns rest/soap field metadata (soap name kept for Munchkin).
- `getActivityTypes()` — activity type catalogue.
- `getLeadById($id)` / `getLeadByEmail($email)` — lookup, mapped to `Drupal\marketo_ma\Lead`.
- `getLeadActivity(Lead, $typeIds)` — paged activities (3-month paging token window).
- `syncLead(Lead, $key='email')` — `pushToMarketoUsingPOST`; if the lead carries a `_mkto_trk` cookie,
  also `associateLeadUsingPOST(id, cookie)`. Returns the Marketo lead id.
- `submitForm($formId, $fields, $cookie, $extra)` — Forms 2.0 `submitFormUsingPOST`. Retries without
  `company`/`industry` on Marketo reason 1021; logs missing-field reason 1006; throws `SkippedException`
  on skip, `ProcessingException` on protocol error. `$extra` maps to `VisitorData` (page_url, query,
  lead_client_ip_address, user_agent).
- `deleteLead()`, `addLeadsToList()` (stub/incomplete), `addLeadToListByEmail()`.

## MarketoMaService (src/Service/MarketoMaService.php) — the worker
- `updateLead(Lead)` — fires `hook_marketo_ma_lead_alter`, then:
  - if the lead has a form id → `postForm()` (Forms 2.0 submit);
  - elif `tracking_method == api_client` → `syncLead()` now, or queue to `marketo_ma_lead` if
    `rest.batch_requests`; then resets tempstore user data;
  - else (munchkin) → stash the lead in `PageAttachment` tempstore for client-side `associateLead`.
- `postForm()`, `getMarketoFields()`, `getEnabledFields()`, `getAvailableFields()`, `resetMarketoFields()`.

## Lead value object (src/Lead.php)
Array-backed field bag. `getEmail()` (checks `email`/`Email`), `id()`, `get()/set()`, `data()`,
`getFormId()/setFormId()`, `getProgramName()/setProgramName()`, `getCookie()/setCookie()` (the `_mkto_trk`
tracking cookie).

## Munchkin service (src/Service/MarketoMaMunchkin.php)
`getAccountId()`, `getInitParams()`, `getLibrary()`, `isConfigured()`. `getAction(ACTION_ASSOCIATE_LEAD,
$lead)` returns `['action','data'=>$lead->data(),'hash'=>sha1(munchkinApiKey . email)]` — the private key
signs the action server-side and only the hash reaches the page (standard Munchkin `associateLead`, which
Marketo has deprecated).

## Queue worker
`Plugin/QueueWorker/MarketoMaLead` (id `marketo_ma_lead`, cron 60s) → `apiClient->syncLead($lead)`.

## Hooks (marketo_ma.api.php)
- `hook_marketo_ma_lead_alter(Lead $lead)` — mutate a lead before submission.
- `hook_marketo_ma_lead_FIELDNAME_alter(&$data)` — per-field alter (documented; marked @todo).

## Legacy client (marketo_ma_legacy_client)
`MarketoMaLegacyClientServiceProvider::alter()` rebinds `marketo_ma.api_client` to
`Service\MarketoMaApiLegacyClient` (wraps the old `CSD\Marketo\Client`). Unmaintained, PHP 8 incompatible;
only enable for old integrations.
