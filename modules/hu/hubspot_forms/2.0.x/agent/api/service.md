# Service — `hubspot_forms`

`Drupal\hubspot_forms\HubspotForms`, service id **`hubspot_forms`**. Constructor args:
`config.factory`, `http_client`, `cache.default`, `logger.factory`, `event_dispatcher`.
Const `API_ENDPOINT = 'https://api.hubapi.com/'`.

## Public methods

```php
getFormIds(): array          // ['' => 'Choose a Hubspot form', 'PORTAL::FORM' => label, …]
fetchHubspotForms(): array   // ['PORTAL::FORM' => label] — always hits the API (no cache read)
isConnected(): int           // count(fetchHubspotForms()); 0 = not connected
```

- `getFormIds()` is the option list used by the block, field widget and dialogs. It reads the
  `caching` setting: if `0`, it fetches live every call; otherwise it returns the `hubspot_forms`
  cache entry, populating it (TTL = `caching` seconds, default 10800) on a miss.
- `fetchHubspotForms()` branches on `hubspot_access_type`:
  - **Access Token** (non-empty type): `GET marketing/v3/forms/?limit=100` with
    `Authorization: Bearer <hubspot_access_token>`, paginating via `paging.next.after`. Keys built
    as `<hubspot_portal_id>::<form->id>`; forms sorted newest-first by `createdAt`.
  - **API Key** (empty type = legacy): `GET forms/v2/forms?hapikey=<hubspot_api_key>`. Keys built
    as `<form->portalId>::<form->guid>`.
  - Then dispatches `CollectFormsEvent` so other modules can add/replace forms
    (see [../hooks/events.md](../hooks/events.md)) and returns the event's forms.

## Errors & caching

- `GuzzleHttp\Exception\ClientException` / `ConnectException` are caught and logged as notices on
  the `hubspot_forms` channel; the method returns whatever it has (often empty). No exception
  surfaces to callers/UI. Request timeout is 5s.
- The cache id is `hubspot_forms`. It is deleted on settings save; otherwise invalidate with
  `\Drupal::cache()->delete('hubspot_forms')` or `drush cr`.

## Example

```php
$service = \Drupal::service('hubspot_forms');
$options = $service->getFormIds();        // for a form '#options'
if (!$service->isConnected()) { /* credentials missing/invalid */ }
```

To render a chosen form in a render array, emit the theme hook directly:

```php
[$portal_id, $form_id] = explode('::', $selected_key);
$build = ['#theme' => 'hubspot_form', '#target' => \Drupal\Component\Utility\Html::getUniqueId('hs-' . $form_id), '#portal_id' => $portal_id, '#form_id' => $form_id];
```
