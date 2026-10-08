<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# activecampaign.api service (ActiveCampaignApi)

Service id `activecampaign.api`, class `Drupal\activecampaign\ActiveCampaignApi`
(`src/ActiveCampaignApi.php`), one argument `@config.factory` (`activecampaign.services.yml`). It is
a thin wrapper around the `activecampaign/api-php` SDK. Reused by the field widgets, the autocomplete
controller, the dashboard forms and the webform handler.

## Construction

`__construct(ConfigFactoryInterface $config_factory)` reads `activecampaign.settings`, stores
`url`, and builds the SDK client:

```
$this->activeCampaignSDK = new \ActiveCampaign($config->get('api_url'), $config->get('api_key'));
```

All calls below delegate to `$this->activeCampaignSDK->api(<endpoint>[, $data])`.

## Methods

| method | SDK endpoint | returns |
|---|---|---|
| `getForms(): array` | `form/getforms` | array of `['id'=>…, 'name'=>…]` (filters to objects with an `id`) |
| `searchForms(string $query): array` | (filters `getForms()` in PHP) | forms whose name contains `$query` (case-insensitive `strpos`) |
| `getContact(int $contact_id)` | `contact/view?…` | one contact (query built with `UrlHelper::buildQuery`, `api_output=json`) |
| `getContacts(array $filter_options=[], int $page=0, int $limit=20)` | `contact/paginator?…` | paginated contacts (`ids=all`, `sort=03D`, offset = `$page*$limit`) |
| `getLists(array $filter_options=[], int $page=0, int $limit=20)` | `list/paginator?…` | paginated lists |
| `getCampaigns(array $filter_options=[], int $page=0, int $limit=20)` | `campaign/paginator?…` | paginated campaigns |
| `syncContact(array $contact)` | `contact/sync` | create-or-update a contact from `$contact` (POST body) |
| `getFormTitle(string $value): string` | (uses `getForms()`) | the form name for a form id, or `''` |
| `createUrlToContact(int $id): Url` | — | `Url::fromUri($url . 'app/contacts/' . $id, target=blank)` |
| `createUrlToCampaign(int $id): Url` | — | `Url::fromUri($url . 'report/#/campaign/' . $id . '/overview', target=blank)` |

Notes:
- `$filter_options` is accepted but **not** applied to the query in `getContacts/getLists/getCampaigns`
  (only `ids`, `api_output`, `limit`, `offset`, and for contacts `sort` are sent).
- On API/transport failure the SDK returns a **string** error message rather than an object; callers
  (dashboards) test `is_string($response)` and route it to messenger; `syncContact()` callers test
  `$response->success` / catch `\Exception` and log.
- `syncContact()` is the only write; everything else is a read.

## Reuse example

```php
$api = \Drupal::service('activecampaign.api');
$forms = $api->getForms();
$api->syncContact(['email' => 'a@b.com', 'first_name' => 'A']);
```
