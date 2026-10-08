<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Authorise.Net CIM Manager (authnet_cim_manager) — agent index

Creates **Authorize.Net Customer Information Manager (CIM)** customer payment profiles from a
Drupal form. One card-capture form (route **and** block) builds a CIM profile via the
`authorizenet/authorizenet` PHP SDK, validates it, and deletes it again if validation fails.
Package `Other`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.2.
Composer requires **`authorizenet/authorizenet:^2.0`**; no Drupal-module dependencies.

- **Settings form, config object, routes & permissions** →
  [config/settings.md](config/settings.md)
- **The CIM creation form, block, and the SDK create/validate/delete flow** →
  [api/cim-creation.md](api/cim-creation.md)

## What it actually is (from source)

- **One settings form** `SettingsForm` (`ConfigFormBase`, `src/Form/SettingsForm.php`) editing
  config **`authnet_cim_manager.settings`** with keys `api_id`, `transaction_key`, `environment`
  (`development` | `production`). Route `authnet_cim_manager.settings` at
  `/admin/config/system/authcim`, `_permission: 'administer site configuration'`. Menu link
  under System config. **No `config/install` and no `config/schema`** ship.
- **One front-end form** `CimCreationFom` (`FormBase`, `src/Form/CimCreationFom.php`) — collects
  customer_type, company, card_number, expiry_date, cvv, first/last name, email, phone, address,
  city, state, country, zip. Route `authnet_cim_manager.cim_creation_fom` at
  `/authnet-cim-manager/cim-creation-fom` (`_permission: 'access content'`, `no_cache: true`).
  Attaches libraries `authorize_net_css` / `authorize_net_js` (client-side field formatting).
- **One block** `CimCreationBlock` (`@Block` id `authnet_cim_manager_cim_creation`, label
  "CIM Creation Form", category "Other", `src/Plugin/Block/CimCreationBlock.php`) — renders the
  same form via helper `authnet_cim_manager_get_form()` in `authnet_cim_manager.module`.
- **The SDK worker** `CreateCimController` (`ControllerBase`, `src/Controller/CreateCimController.php`)
  — public `createCustomerProfile($data)` plus private `validateCustomerPaymentProfile()` and
  `deleteCustomerProfile()`. This is **not** a routed controller; the form instantiates it
  directly in `submitForm()`.
- Provides **no permissions of its own**, no Drush, no services, no entities, no config schema,
  no custom plugin types. Only `hook_help()` and the form helper in the `.module` file.

## Data flow (create a CIM profile)

`CimCreationFom::submitForm()` normalizes the values (strips spaces from the card number, turns
`mm/yy` into `CCYY-MM`), then calls
`CreateCimController::createCustomerProfile()`, which reads `api_id`/`transaction_key`/`environment`
from config, builds a `CreateCustomerProfileRequest` (`MerchantAuthenticationType` + `CreditCardType`
+ `CustomerAddressType` + `CustomerPaymentProfileType`), executes it against the SANDBOX or
PRODUCTION endpoint, and on success validates the new payment profile (`liveMode`), deleting the
profile if validation fails. Results are surfaced only through `messenger`. See
[api/cim-creation.md](api/cim-creation.md).
