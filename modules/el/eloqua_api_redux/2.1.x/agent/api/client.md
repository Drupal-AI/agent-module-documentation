<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API surface — client, Contact & Forms services

All three services live under `src/Service/`. Consume them from your own module via the container
service ids below. Every call ultimately goes through `EloquaApiClient::doEloquaApiRequest()`, which
returns a decoded array (or `[]` on any non-2xx / exception / missing base URL).

## `eloqua_api_redux.client` — `EloquaApiClient` (implements `EloquaApiClientInterface`)

Generic authenticated request method:

```
doEloquaApiRequest($verb, $endpoint, $body = NULL, $queryParams = NULL): array
```

- Aborts (returns `[]`) if `getBaseUrl()` yields no base URL.
- Builds a Guzzle client with `base_uri` = the resolved Eloqua base URL and headers
  `Authorization: bearer <access token>` (from `getAccessTokenByRefreshToken()`) +
  `Content-Type: application/json`. `$body` is JSON-encoded into the request body; `$queryParams`
  become the query string.
- Success statuses treated as OK: 200, 201, 204.

Also public: `getAccessTokenByAuthCode()`, `getAccessTokenByRefreshToken()`, `doTokenRequest()`,
`getBaseUrl()`, `getEloquaToken($key)` — see `config/settings.md` for the auth/token mechanics.

## `eloqua_api_redux.contact` — `Contact`

Wraps `/api/REST/2.0/data/contact(s)`; constructor takes the client.

- `createContact(array $contactArray)` — POST `/api/REST/2.0/data/contact`; `array_filter`s empties,
  returns `[]` if empty.
- `getContacts(array $queryParams = [])` — GET `/api/REST/2.0/data/contacts` (params: count, depth,
  lastUpdatedAt, orderBy, page, search, viewId). Returns `[]` when no params supplied.
- `getContactByEmail($emailAddress)` — `getContacts(['search' => $email])`, returns first
  `elements[0]` or `[]`.
- `getContactById($contactId, array $queryParams = [])` — GET `/api/REST/2.0/data/contact/{id}`.
- `updateContact($contactId, array $contact)` — PUT `/api/REST/2.0/data/contact/{id}`; requires
  `id` and `emailAddress` keys, else returns `[]`.
- `deleteContact($contactId)` — DELETE `/api/REST/2.0/data/contact/{id}`.
- `dummyContact()` — returns an empty-valued template array of all contact fields (accessedAt,
  accountId, emailAddress, firstName, lastName, … ).

## `eloqua_api_redux.forms` — `Forms`

Wraps Eloqua forms/assets; constructor takes the client.

- `createFormData($formId, array $formData)` — POST `/api/REST/2.0/data/form/{id}`;
  `array_filter`s empties then runs `cleanupFormDataForSubmission()`, which walks `fieldValues` and
  joins any array `value` (multi-select/checkbox) into a comma-separated string before submission.
- `getForm($formId, array $queryParams = [])` — GET `/api/REST/2.0/assets/form/{id}` (param: depth).
- `getForms(array $queryParams = [])` — GET `/api/REST/2.0/assets/forms` (params: count, depth,
  lastUpdatedAt, orderBy, page, search). Returns the raw client result.
- `getFieldsRaw($formId)` — reads the form and returns its `elements` of `type == 'FormField'` whose
  `displayType != 'submit'`.
- `getFieldsDummy($formId)` — same fields shaped as a `fieldValues` array of `{type, id, value:''}`
  templates ready to fill and POST via `createFormData()`.

## Extension point: auth fallback

`getAccessTokenByRefreshToken()` calls `eloqua_api_redux.auth_fallback_default`
(`EloquaAuthDefaultFallback::generateTokensByResourceOwner()`, returns FALSE by default) when both
access and refresh tokens are gone. The `eloqua_api_auth_fallback` submodule **decorates** that
service to perform a resource-owner password grant so an unattended sync can re-authenticate.
