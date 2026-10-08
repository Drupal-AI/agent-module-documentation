# Endpoint plugins (`@Endpoint`)

Every Trustpilot API endpoint is an annotation plugin. The plugin type:

- Manager service: `trustpilot_api.endpoint_plugin_manager` (`EndpointPluginManager extends
  DefaultPluginManager`); discovery dir `Plugin/TrustpilotApi/Endpoint`, alter hook
  `trustpilot_api_endpoint_info`, cache key `trustpilot_api_endpoint`.
- Annotation: `Drupal\trustpilot_api\Annotation\Endpoint` (`@Endpoint`).
- Interface: `EndpointPluginInterface`; base class: `EndpointPluginBase` (injects
  `config.factory` → `trustpilot_api.settings`).

Most endpoints are **annotation-only** — no method bodies — because `EndpointPluginBase` does all the
work from the annotation. `EndpointPluginInterface` also defines the auth constants
`ENDPOINT_AUTH_TYPE_KEY = 'key'` and `ENDPOINT_AUTH_TYPE_OAUTH = 'oauth'`.

## Annotation properties

| Prop | Default | Purpose |
|---|---|---|
| `id` | — | Plugin machine id (used with `createInstance()`). |
| `name` | — | Human label (`@Translation`). |
| `path` | — | Path appended to base URI. `[placeholder]` tokens are substituted from `requiredParams`. |
| `method` | `GET` | HTTP method; `POST` sends `$params` as the JSON body. |
| `authType` | `key` | `key` (apiKey header only) or `oauth` (adds `?token=`; needs full private creds). |
| `documentationUrl` | `''` | Link shown on the Test forms. |
| `requiredParams` | `{}` | Param keys that must be present; missing → `EndpointRequiredOptionsMissing`. |
| `defaultRequestParams` | `{}` | Default param values (empty ones are filtered out before the request). |
| `headers` | `{}` | Extra per-endpoint request headers. |

Path substitution and param handling live in `EndpointPluginBase`: `getRequestPath()` (strtr of
`[key]` tokens), `setRequestParams()` (merges defaults, fills `businessUnitId` from config, filters
empties), `canPerformRequest()` (all required params present).

## Add a custom endpoint

Drop a class in `modules/custom/mymod/src/Plugin/TrustpilotApi/Endpoint/MyThing.php`:

```php
namespace Drupal\mymod\Plugin\TrustpilotApi\Endpoint;

use Drupal\trustpilot_api\EndpointPluginBase;

/**
 * @Endpoint(
 *   id = "my_thing",
 *   name = @Translation("My Thing"),
 *   path = "business-units/[businessUnitId]/reviews",
 *   method = "GET",
 *   authType = "key",
 *   requiredParams = { "businessUnitId" },
 *   defaultRequestParams = { "perPage" = "" },
 * )
 */
class MyThing extends EndpointPluginBase {}
```

Then `createInstance('my_thing')` and pass to `$client->request()`. Override base methods only if you
need custom path/param logic.

## Bundled endpoints (26)

Public (`authType = key`, `GET` unless noted):

- `business_unit_reviews`, `business_unit_search`, `business_unit_profile_info`,
  `business_unit_profile_promotion`, `business_unit_categories`, `business_unit_company_logo`,
  `business_unit_customer_guarantee`, `business_unit_images`
- Legacy: `business_unit_legacy_all`, `business_unit_legacy_find`, `business_unit_legacy_list`,
  `business_unit_legacy_public_info`, `business_unit_legacy_web_links`
- Categories: `categories_get`, `categories_list`, `categories_business_units`
- Consumer: `consumer_reviews`, `consumer_profile_get`, `consumer_profile_reviews`,
  `consumer_profile_list` (**POST**)
- Product reviews: `product_reviews_get_imported`, `product_reviews_get_imported_summaries`,
  `product_reviews_summaries` (**POST**)

Private (`authType = oauth`; require `api_key` + `api_secret` + `oauth_email` + `oauth_password`):

- `business_unit_private_reviews` (GET)
- `private_products_get` (GET)
- `private_products_upsert` (**POST**)
