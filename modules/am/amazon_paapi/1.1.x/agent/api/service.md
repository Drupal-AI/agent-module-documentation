<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `amazon_paapi.amazon_paapi` service and SDK client

Class `Drupal\amazon_paapi\AmazonPaapi` (`src/AmazonPaapi.php`), registered in
`amazon_paapi.services.yml` as `amazon_paapi.amazon_paapi` with **no constructor arguments** (it
uses `LoggerChannelTrait` and pulls config statically via `\Drupal::config()`).

## Getting the SDK client

```php
/** @var \Drupal\amazon_paapi\AmazonPaapi $svc */
$svc = \Drupal::service('amazon_paapi.amazon_paapi');
$api = $svc->getApi();            // Amazon\...\v1\api\DefaultApi, credentials pre-filled
// $api = $svc->getApi($myGuzzleClient);  // optional: inject your own ClientInterface
```

`getApi(?ClientInterface $client = NULL)` builds an SDK `Configuration`, calls
`setAccessKey/ setSecretKey/ setHost/ setRegion` from the resolved settings, defaults `$client` to
a plain `new GuzzleHttp\Client()` when none is passed, and returns
`new DefaultApi($client, $config)`. Note: the **partner tag is NOT set on the client** — you set it
per request via `$request->setPartnerTag(AmazonPaapi::getPartnerTag())`.

## Using the trait

Instead of the service name, mix in `Drupal\amazon_paapi\AmazonPaapiTrait` and call
`$this->getAmazonPaapi()` (lazy-loads and memoizes the service). `TestAsinForm` is the in-tree
example.

## Credential resolution (static helpers)

Five getters return the resolved value or `FALSE`: `getAccessKey()`, `getAccessSecret()`,
`getHost()`, `getRegion()`, `getPartnerTag()`. All delegate to `getSetting($key)`, which:

1. Maps the settings key to its env-var name via `getEnvVariable()` and returns
   `getenv($ENV)` **if that env var is non-empty** — env wins.
2. Otherwise returns `\Drupal::config('amazon_paapi.settings')->get($key)`.
3. Otherwise returns `FALSE`.

Settings-key ↔ env-var map (constants on the class):

| settings key      | env var                       |
|-------------------|-------------------------------|
| `access_key`      | `AMAZON_PAAPI_ACCESS_KEY`     |
| `access_secret`   | `AMAZON_PAAPI_ACCESS_SECRET`  |
| `host`            | `AMAZON_PAAPI_HOST`           |
| `region`          | `AMAZON_PAAPI_REGION`         |
| `partner_tag`     | `AMAZON_PAAPI_PARTNER_TAG`    |

Helpers: `getAvailableSettingsKeys()` reflects every `SETTINGS_*` constant; `getEnvVariable($key)`
returns the mapped env name or `FALSE`; `isSetInEnv($key)` is `!empty(getenv(env))`.

## Signing, host and TLS (from source)

The module never signs or opens sockets itself — that is entirely inside the SDK. The SDK's
`Configuration::setHost()` prepends `https://` to whatever host string you configure, and its
`DefaultApi` sends the SigV4-signed request through the Guzzle client you (or the module's default
`new Client()`) provide. `createHttpClientOption()` in the SDK sets only a debug stream, never any
`verify`/SSL option, so TLS verification stays at Guzzle's secure default. The `host` value comes
from config/env, not from request input.

## Writing a request (GetItems example)

Follow `TestAsinForm::fetchProductData()`:

```php
use Amazon\ProductAdvertisingAPI\v1\com\amazon\paapi5\v1\GetItemsRequest;
use Amazon\ProductAdvertisingAPI\v1\com\amazon\paapi5\v1\GetItemsResource;
use Amazon\ProductAdvertisingAPI\v1\com\amazon\paapi5\v1\PartnerType;

$request = new GetItemsRequest();
$request->setItemIds([$asin]);
$request->setPartnerTag(AmazonPaapi::getPartnerTag());
$request->setPartnerType(PartnerType::ASSOCIATES);
$request->setResources([
  GetItemsResource::ITEM_INFOTITLE,
  GetItemsResource::OFFERSLISTINGSPRICE,
  GetItemsResource::IMAGESPRIMARYLARGE,
  // ...any GetItemsResource constants you need
]);

try {
  $response = $this->getAmazonPaapi()->getApi()->getItems($request);
  $item = $response->getItemsResult()?->getItems()[0] ?? NULL;
  // $item->getASIN(), $item->getItemInfo()->getTitle()->getDisplayValue(),
  // $item->getDetailPageURL(), $item->getOffers()->getListings()[0]->getPrice()->getDisplayAmount()
}
catch (\Exception $e) {
  $messages = $this->getAmazonPaapi()->logException($e); // string[]; logs by default
}
```

For `SearchItems`, `GetVariations` and `GetBrowseNodes` use the matching request/resource classes
from the SDK — the module adds nothing on top. See the SDK's `Sample*Api.php` files.

## Error logging

`logException(\Exception $e, $log = TRUE)` returns a `string[]` of human-readable lines. For an SDK
`ApiException` it collects the HTTP status code, message, and each nested
`ProductAdvertisingAPIClientException` error's code/message (falling back to the raw response body);
otherwise just `$e->getMessage()`. When `$log` is TRUE it writes the joined lines (`<BR>`-separated)
to the `amazon_paapi` logger channel at `error` level. It logs error text only — not credentials.
