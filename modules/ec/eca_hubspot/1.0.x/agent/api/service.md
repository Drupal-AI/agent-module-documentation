<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HubSpotService (eca_hubspot.hubspot)

`src/Service/HubSpotService.php` — the single wrapper every action uses. Service id
`eca_hubspot.hubspot`; constructor args `@hubspot_api.manager` (`\Drupal\hubspot_api\ManagerInterface`),
`@logger.factory` (channel `eca_hubspot`), `@token`. Uses `DateTimeFormattingTrait`.

## Client acquisition (credentials are external)

`getClient(): ?Discovery` calls `hubspotManager->getHandler()` and returns the SDK
`\HubSpot\Discovery\Discovery` client, or NULL (logged) on exception. **All authentication, the
access token, and the HTTP/TLS transport come from the `hubspot_api` module** and the underlying
`hubspot/api-client` SDK — this module never builds an HTTP client, sets TLS options, or handles the
token itself. Every method starts by fetching the client and bailing out with NULL/FALSE if it is
unavailable.

## Per-object CRUD methods

For each object type the service calls the matching SDK basic API:
- Contacts → `$client->crm()->contacts()->basicApi()` — `create` (`SimplePublicObjectInputForCreate`),
  `update`, `getById`, `archive`. `getContact()` uses `idProperty = 'email'` when the input passes
  `FILTER_VALIDATE_EMAIL`, treating a 404 as "not found" (returns NULL, not an error).
- Companies → `$client->crm()->companies()->basicApi()`. `getCompany()` treats an input containing
  `.` and non-numeric as a domain and resolves it via `searchCompanies([... domain EQ ...], '', 1)`.
- Deals → `$client->crm()->deals()->basicApi()`; create passes `associations` built by
  `formatAssociations()`; update adds associations afterward via `createAssociations()`. `getDeal()`
  can include `['contacts','companies']`.
- Leads / Notes / Tasks → generic `$client->crm()->objects()->basicApi()` (or `objects()->notes()`
  / `objects()->tasks()`), object name `'leads'`. `createNote()` injects `hs_timestamp` (ISO `c`) if
  missing. `createTask()` creates first, then associates using the returned id.
- Tickets → `$client->crm()->tickets()->basicApi()`; `getTicket()` can include
  `['contacts','companies','deals']`.

Create returns the formatted object; delete returns bool (archive). Method list: `createContact/
updateContact/getContact/deleteContact/searchContacts`, and the same quintet for company, deal, lead,
ticket, note, task.

## Search — `performSearch()`

`performSearch($object_type, $filters, $sort_by, $limit)` maps the object type to an SDK namespace
via a **fixed** `namespace_map` (contacts→Contacts, companies→Companies, deals→Deals, tickets→Tickets,
leads/notes/tasks→Objects) and constructs `\HubSpot\Client\Crm\{Namespace}\Model\{Filter,FilterGroup,
PublicObjectSearchRequest}`. Each filter sets `propertyName`, `operator`, and `value`/`values`/
`highValue`. leads/notes/tasks go through `objects()->searchApi()->doSearch($type, $req)`; others via
`$client->crm()->$type()->searchApi()->doSearch($req)`. Returns `['total' => …, 'results' => [...]]`
with each result run through `formatObjectResponse()`.

## Associations — v4 API

- `associateObjects()` / `disassociateObjects()` — `$client->crm()->associations()->v4()->basicApi()
  ->create|archive(...)` with `associationCategory: HUBSPOT_DEFINED` and a numeric `associationTypeId`.
- `getAssociations()` — `v4()->basicApi()->getPage(...)`, returns the list of `toObjectId`s.
- `getAssociationTypeId($from, $to)` — static lookup table of HubSpot-defined type ids (e.g.
  `deal|contact => 3`, `contact|company => 1`), defaulting to `1`.
- `formatAssociations()` / `createAssociations()` — turn `[toType => ids]` maps into SDK association
  payloads; `createAssociations()` logs a debug line per association (object types + ids, no secrets).

## Pipelines & response shaping

- `listPipelines($type)` / `getPipeline($type, $id)` — `$client->crm()->pipelines()->pipelinesApi()
  ->getAll|getById(...)`; flatten each pipeline to `{id, label, displayOrder, stages[]}` where a stage
  is `{id, label, displayOrder, metadata}`.
- `formatObjectResponse($response)` — normalizes any SDK object to `{id, properties(), created_at,
  updated_at, associations?}`, converting `\DateTime` to ISO `c` and objects to arrays via
  `json_decode(json_encode(...), TRUE)`. Non-objects → `[]`.
- `handleApiException(\Exception, $op)` — logs `error` with the operation name and
  `$e->getMessage()` to the `eca_hubspot` channel.

## DateTimeFormattingTrait

`src/DateTimeFormattingTrait.php` — `formatDateTimeForApi($datetime, $timezone = null): ?int` returns
a HubSpot Unix timestamp in **milliseconds**: passes through numeric ms (> 9999999999), multiplies
seconds by 1000, or parses `\DateTime`/`\DateTimeInterface`/strings/`['date'=>…]` arrays.
`parseStringDateTime()` tries `new \DateTime()` then Drupal's `D, d M Y - H:i` / `d M Y - H:i`
formats; timezone defaults to `system.date` `timezone.default`. Parse failures log and return NULL.
