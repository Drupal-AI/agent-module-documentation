# Create & configure a USPS shipping method

There is **no module configure route**. USPS is configured as a Commerce **Shipping method**.

## Via the UI

1. Go to *Commerce › Configuration › Shipping › Shipping methods › Add shipping method*
   (`/admin/commerce/config/shipping-methods/add`).
2. Choose plugin **USPS** (`usps`, domestic) or **USPS International** (`usps_international`).
3. Under **API information** enter your USPS **Consumer key** (`client_id`), **Consumer secret**
   (`secret`), and **mode** (`test` or `live`).
4. Pick the **services** to offer (Priority Mail, Ground Advantage, etc.), a default package type,
   and any optional rate options.
5. Save. Rates are then returned during checkout for the enabled services.

## Plugins

| Plugin id | Class | Services (examples) |
|---|---|---|
| `usps` | `USPSDomestic` | `PRIORITY_MAIL`, `PRIORITY_MAIL_EXPRESS`, `USPS_GROUND_ADVANTAGE`, `PARCEL_SELECT`, `MEDIA_MAIL`, `LIBRARY_MAIL`, `BOUND_PRINTED_MATTER`, USPS Connect Local/Regional/Mail, return-service variants |
| `usps_international` | `USPSInternational` | `GLOBAL_EXPRESS_GUARANTEED`, `PRIORITY_MAIL_INTERNATIONAL`, `PRIORITY_MAIL_EXPRESS_INTERNATIONAL`, `FIRST-CLASS_PACKAGE_INTERNATIONAL_SERVICE` |

## Configuration schema

The plugin configuration is stored on the `commerce_shipping_method` config entity
(`commerce_shipping.commerce_shipping_method.plugin.usps` →
`commerce_usps.shipping_method_configuration`):

```yaml
rate_label: ''            # optional label shown to customers
rate_description: ''
api_information:
  client_id: ''           # USPS OAuth Consumer key
  secret: ''              # USPS OAuth Consumer secret
  mode: test              # test | live
rate_options:
  price_type: retail      # retail | contract
  account_type: eps       # used with contract pricing
  account_number: ''
  account_crid: ''        # Customer Registration ID
  categories: []          # processing categories
  rate_indicators: []
  facility_types: []      # destination-entry facility types
  rate_multiplier: 1.0
  round: <int>
options:
  tracking_url: 'https://tools.usps.com/go/TrackConfirmAction?tLabels=[tracking_code]'
  log:
    request: { value: false }   # log API request messages
    response: { value: false }  # log API response messages
```

Validation requires both `client_id` and `secret`; an invalid key/secret pair surfaces
"Invalid Consumer key or Consumer secret specified."

## Create with drush (scriptable)

```php
use Drupal\commerce_shipping\Entity\ShippingMethod;
$store = current(\Drupal::entityTypeManager()->getStorage('commerce_store')
  ->loadByProperties(['name' => 'my_store']));
ShippingMethod::create([
  'stores' => [$store->id()],
  'name'   => 'USPS',
  'status' => 1,
  'plugin' => [
    'target_plugin_id' => 'usps',
    'target_plugin_configuration' => [
      'rate_label' => 'USPS',
      'api_information' => ['client_id' => 'KEY', 'secret' => 'SECRET', 'mode' => 'test'],
    ],
  ],
])->save();
```

Read it back:

```bash
drush php:eval '$m = current(\Drupal::entityTypeManager()->getStorage("commerce_shipping_method")->loadByProperties(["name"=>"USPS"])); var_export($m->get("plugin")->first()->target_plugin_id);'
```

## Package types

The module declares USPS flat-rate boxes as Commerce package types (in
`commerce_usps.commerce_package_types.yml`): Large/Medium/Small Flat Rate Box (and a
top-loading Medium), each bound to `shipping_method: usps`. Select one as the method's default
package type.
