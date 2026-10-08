<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Client API: factory, endpoints, resources, events, hooks

## Endpoint factory service

`activecampaign_api.endpoint_factory` → `Service\EndpointFactory` (interface
`EndpointFactoryInterface`), constructed with `@http_client` (Guzzle `Client`) and `@module_handler`.

- `setActivecampaignApiAccount(ActivecampaignApiAccountInterface)` — required before use; also
  re-points any already-instantiated cached endpoints.
- `get(string $endpointClass): Endpoint` — validates the class exists and is a subclass of
  `Endpoint`, instantiates it with the http client, module handler and account, and caches it.
  Throws `\RuntimeException` if no account was set, `\InvalidArgumentException` for a bad class.
- `isConfigured(): bool` — TRUE only when an account is set with non-empty `base_url` **and**
  `api_token`.

## Base Endpoint (`src/Endpoint.php`)

Constructor takes `(string $resource, Client, ModuleHandlerInterface, account)`; sets
`url = account->getBaseUrl() . '/' . $resource`. Concrete endpoints pass their resource name via
`parent::__construct('contacts', …)` etc. All requests attach header
`Api-Token: <account->getApiToken()>` (token is **never** placed in the URL). Protected primitives:

- `getResource($id)` — GET `url/id`; `json_decode` the body; returns `NULL` on empty body or a
  404 `ClientException`; wraps other errors in `activecampaign_api\Exception`.
- `createResource($data)` — fires `alter('activecampaign_api_endpoint_createresource', …)`, POSTs
  JSON body, returns decoded object. On failure calls `reportErrorToWebhook()` then throws.
- `updateResource($id, $data)` — fires `_updateresource` alter, PUTs; throws if status ≠ 200.
- `deleteResource($id)` — DELETEs `url/id`.
- `listResources($filters, $offset=0, $limit=NULL)` — GET with `query` = filters + `offset` +
  `limit` (default 20); loops on `meta.total`, merging pages until `expected_results` are gathered.
- `post($endpoint, $data)` — POST JSON to `base_url . $endpoint` (used by `ContactLists::updateStatus`).
- `reportErrorToWebhook(...)` — if the account has a webhook URL, POSTs a payload describing the
  failed call (account id, url, method, options, error, response). **Redacts** the `Api-Token`
  header to `--hidden--` before sending, and fires `alter('activecampaign_api_report_error_to_webhook')`.

Public wrappers vary per endpoint. `Endpoint::get()`/`delete()` are generic; subclasses add typed
`get`/`create`/`update`/`list`.

## Endpoints (`src/Endpoint/*`)

| Class | Resource path | Notable methods |
|---|---|---|
| `Contacts` | `contacts` | `get`, `create`, `update`, `list(filters→filters[k])`, `getContactListMemberships` |
| `ContactLists` | `lists` | `get`, `getByName` (static cache), `list`, `updateStatus($list,$contact,$subscribe)` → POST `/contactLists` status 1/2 |
| `Tags` / `ContactTags` | `tags` / `contactTags` | tag CRUD / contact-tag links |
| `Fields` | `fields` | `get`/`list` return typed `Field` subclasses via `Field::getTypedInstance()`; `getByTitle`; `delete()` throws "Not implemented" |
| `FieldValues` / `FieldRels` | `fieldValues` / `fieldRels` | per-contact custom field values / field-list relations |
| `Accounts` / `AccountContacts` | `accounts` / `accountContacts` | organization records + contact links (`getAllByContact`) |
| `AccountCustomFieldMeta` / `AccountCustomFieldData` | `accountCustomFieldMeta` / `accountCustomFieldData` | account (org) custom field defs + values |

## Resource value objects (`src/ApiResource/*`)

Abstract `ApiResource` has a public `$id`, an `equals()` deep-compare, and static
`createFromJsonResponse()` / `createFromJsonListResponse()` that copy matching public properties from
the JSON. Key resources: `Contact` (`email`, `firstName`, `lastName`, `phone`, `fieldValues`),
`ContactList`, `ContactListMembership`, `ContactTag`, `Tag`, `Account`, `AccountContact`,
`FieldValue`, `FieldRel`. `Field` is **abstract**: `Field::getTypedInstance($json)` maps the JSON
`type` to `ApiResource\Field\<Ucfirst(type)>` (Text, Textarea, Date, Datetime, Dropdown, Listbox,
Radio, Checkbox, Hidden, Number; `FieldOptions` for option lists) and throws if the class is missing.
`AccountCustomFieldMeta` has a parallel typed hierarchy.

## Event tracking service

`activecampaign_api.event_tracking` → `Service\EventTrackingService` (ctor `@http_client`).
`track($account, string $name, string $email, ?string $data)` builds a query with the account's
`event_tracking_key` + `actid`, the event `name`, and a JSON `visit` = `{email}`, POSTs to
`event_tracking_base_url . '?' . http_build_query(...)`, and throws `Exception` unless the response is
200 with `success == 1`. (The key/actid travel in the URL query string, per ActiveCampaign's
event-tracking API design.)

## Helper functions (`activecampaign_api.module`)

- `activecampaign_api_subscribe_contact_to_list($email, $contact_list_id, $account)` — validates the
  e-mail, resolves the list, finds or creates the contact by e-mail, then `updateStatus(..., TRUE)`;
  logs contact id + e-mail.
- `activecampaign_api_get_account_by_contact(Contact $contact, $account): ?Account` — returns the org
  account linked to a contact (throws if more than one).

## Hooks & the Exception type

Alter hooks (`activecampaign_api.api.php`): `hook_activecampaign_api_endpoint_createresource_alter`,
`_updateresource_alter`, `_report_error_to_webhook_alter` — each receives `(object &$data, Endpoint
$endpoint)`. The module's own `activecampaign_api_..._report_error_to_webhook_alter` adds the request
host; `activecampaign_api_raven_filter_alter` suppresses double-reporting of already-reported
`Exception`s to Raven. `activecampaign_api\Exception` (extends `\RuntimeException`) carries a
`reported` flag (`isReported()`) and a `getResponse()` accessor for the wrapped Guzzle response.
