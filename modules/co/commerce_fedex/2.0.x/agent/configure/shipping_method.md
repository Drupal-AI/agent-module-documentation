# Configure the FedEx shipping method

There is **no module settings form**. Configuration lives on a `commerce_shipping_method` config
entity whose plugin is `fedex`. Create one at **`admin/commerce/shipping-methods`** → *Add shipping
method* → Plugin = **FedEx**. The form is built by
`FedEx::buildConfigurationForm()` (`src/Plugin/Commerce/ShippingMethod/FedEx.php`).

Prerequisite: shippable product variations need `weight` (and, for real box sizing, `dimensions`)
fields from the Commerce **physical** module, populated per product.

## Config structure (schema: `config/schema/commerce_fedex.schema.yml`)

Third-party config on the shipping method, under two groups.

### `api_information`
| Key | Type | Notes |
|---|---|---|
| `api_key` | string | FedEx API key (client id), from developer.fedex.com. Stored in config. |
| `api_password` | string | FedEx API secret (client secret). Form field is `#type: password`; on save it is **only overwritten when non-empty**, so re-saving the form without retyping keeps the old value. Stored in config. |
| `account_number` | integer | FedEx account number. |
| `mode` | string | `test` (default) or `live`. `live` calls `useProduction()` on the FedEx client. |

### `options`
| Key | Type | Values / meaning |
|---|---|---|
| `packaging` | string | `individual` (each item its own box, default), `allinone` (all items in the default package type), `calculate` (compute box count from volumes). The last two require a real Default package type — the built-in 1×1×1 mm box is rejected. |
| `rate_request_type` | sequence | Any of `LIST`, `PREFERRED`, `ACCOUNT`, `INCENTIVE`. Empty ⇒ treated as `ACCOUNT`. |
| `pickup_type` | string | `PickupType` enum: contact-FedEx / dropoff (default) / scheduled. |
| `insurance` | bool | Send declared value on each package. |
| `rate_multiplier` | float | Each returned rate is multiplied by this (e.g. `1.5` = 150%). Default `1.0`. |
| `round` | int | `PHP_ROUND_HALF_*` constant used to round the final price. |
| `log` | mapping | `request` and `response` checkboxes — enable to log outgoing/incoming FedEx payloads to the `commerce_fedex` logger channel (default off; see runtime note). |
| `tracking_url` | url | Base URL for `getTrackingUrl()`; `[tracking_code]` token is replaced, else the code is appended. Default is the FedEx track URL. |

`services` (which of the ~12 FedEx service levels are offered) and `default_package_type` come from
`ShippingMethodBase`; all services are pre-selected the first time the form is built.

`plugins` is a sequence of FedEx Service plugin configs (one per discovered `@CommerceFedExPlugin`);
each plugin renders its own sub-details on the form. See [plugins/fedex_service.md](../plugins/fedex_service.md).

## Credentials

FedEx credentials are live secrets. They are stored in the shipping-method config entity, which is
exported with the site config. Keep production config out of VCS or inject the values through your
environment/secret store rather than committing them. On save, `validateConfigurationForm()`
verifies a newly entered secret by calling `FedExRequest::getToken()` and sets an "Invalid
credentials" error if the token request throws.

## Set it programmatically

```php
$method = \Drupal\commerce_shipping\Entity\ShippingMethod::create([
  'name' => 'FedEx',
  'plugin' => [
    'target_plugin_id' => 'fedex',
    'target_plugin_configuration' => [
      'api_information' => [
        'api_key' => getenv('FEDEX_API_KEY'),
        'api_password' => getenv('FEDEX_API_SECRET'),
        'account_number' => 123456789,
        'mode' => 'live',
      ],
      'options' => [
        'packaging' => 'individual',
        'rate_request_type' => ['ACCOUNT'],
        'rate_multiplier' => 1.0,
        'insurance' => FALSE,
      ],
      'services' => ['FEDEX_GROUND' => 'FEDEX_GROUND', 'FEDEX_2_DAY' => 'FEDEX_2_DAY'],
    ],
  ],
  'status' => TRUE,
]);
$method->save();
```

Service machine names available: `FEDEX_2_DAY`, `FEDEX_2_DAY_AM`, `FEDEX_EXPRESS_SAVER`,
`FEDEX_GROUND`, `FIRST_OVERNIGHT`, `GROUND_HOME_DELIVERY`, `INTERNATIONAL_ECONOMY`,
`INTERNATIONAL_FIRST`, `INTERNATIONAL_PRIORITY`, `PRIORITY_OVERNIGHT`, `SMART_POST`,
`STANDARD_OVERNIGHT`.

## Runtime note on `log`

When `options.log.request` (or `response`) is on, `FedEx::logRequest()` writes the FedEx
request/response payloads to the `commerce_fedex` channel (dblog). These payloads are verbose and
include shipping addresses; leave logging **off** in production unless actively debugging.
