<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CIM creation form, block & the SDK create/validate/delete flow

## The form — `CimCreationFom`

`src/Form/CimCreationFom.php`, a `FormBase`, form id `authnet_cim_manager_cim_creation_fom`.
Injects `config.factory` and `messenger` via `create()`. Fields built in `buildForm()`:

- `customer_type` (select: individual/business), `company`
- `card_number` (required), `expiry_date` (required, `mm/yy`), `cvv` (required)
- `first_name`, `last_name` (required), `email` (required), `phone` (required)
- `address`, `city`, `state`, `country`, `zip` (optional)

Attaches libraries `authnet_cim_manager/authorize_net_css` and `.../authorize_net_js`
(`assets/js/authnet.js` — pure client-side masking of card number, expiry, CVV, ZIP and phone;
no data is sent anywhere by the JS).

**`validateForm()`** — server-side checks: card number digits-only (after stripping spaces);
expiry matches `^(0[1-9]|1[0-2])/\d{2}$` and is not before the current month/year; CVV digits-only;
phone matches `^[0-9()+\- ]*$`; ZIP digits-only. (Note: it does **not** verify the card with a
Luhn check or a length check — Authorize.Net does that.)

**`submitForm()`** — normalizes the values: `str_replace(' ', '', card_number)`, and rebuilds the
expiry into `CCYY-MM` (`substr(date("Y"),0,2)` + the 2-digit year + `-` + month). It then does
`$objCim = new CreateCimController($this->configFactory, $this->messenger); $objCim->createCustomerProfile($data);`
— i.e. it constructs the controller **directly** (not via the container) and calls it. Nothing is
returned to or stored by the form.

## The block — `CimCreationBlock`

`src/Plugin/Block/CimCreationBlock.php`, `@Block` id `authnet_cim_manager_cim_creation`, admin
label "CIM Creation Form", category "Other". Its `build()` returns
`authnet_cim_manager_get_form(CimCreationFom::class)`, where the helper
(`authnet_cim_manager.module`) is `Drupal::formBuilder()->getForm($form_name)`. So the block and
the route `/authnet-cim-manager/cim-creation-fom` render the identical form.

## The SDK worker — `CreateCimController`

`src/Controller/CreateCimController.php` (extends `ControllerBase`, but is **not** wired to any
route — it is a plain service-less helper the form `new`s up). All three methods read
`api_id` / `transaction_key` / `environment` from `authnet_cim_manager.settings` and build a
`MerchantAuthenticationType` (`setName($api_id)`, `setTransactionKey($transaction_key)`).

### `createCustomerProfile(array $data): ?AnetApiResponseType`

1. Builds `CreditCardType` from `card_number` / `expiry_date` (`CCYY-MM`) / `cvv`, wrapped in a
   `PaymentType`.
2. Builds `CustomerAddressType` (Bill To) from the name/company/address fields.
3. Builds `CustomerPaymentProfileType` (`setCustomerType`, Bill To, payment) and a
   `CustomerProfileType` (`setDescription("drupal submission")`,
   `setMerchantCustomerId("M_".time())`, `setEmail`, one payment profile).
4. Sends a `CreateCustomerProfileRequest` (with `refId = 'ref'.time()`) via
   `CreateCustomerProfileController->executeWithApiResponse(PRODUCTION|SANDBOX)` — endpoint chosen
   by the `environment` config.
5. On `resultCode == "Ok"`: reads the new `customerProfileId` and the first
   `customerPaymentProfileId`, then calls `validateCustomerPaymentProfile()`. If validation is
   `Ok`, adds a success message with the profile id; otherwise calls `deleteCustomerProfile()` and
   shows the validation error.

### `validateCustomerPaymentProfile($profileId, $paymentProfileId)` (private)

Sends a `ValidateCustomerPaymentProfileRequest` with **validationMode `"liveMode"`** against the
selected endpoint and returns the response. `liveMode` performs a real gateway validation of the
stored card.

### `deleteCustomerProfile($profileId)` (private, void)

Sends a `DeleteCustomerProfileRequest` to remove a profile whose payment method failed validation.

## What it does NOT do

- Does **not** store the returned `customerProfileId` / `customerPaymentProfileId` in Drupal (no
  DB write, no entity, no state) — the IDs only appear in a `messenger` status message.
- Provides **no** routes/UI to list, view, update, charge, or delete an existing profile (the
  delete/validate methods are private and only run as part of the create flow).
- Has **no** webhook / silent-post / notify callback route.

## Known code defect (not a doc concern, but affects behavior)

In the non-`Ok` branch of `createCustomerProfile()` the code calls
`$this->$response->getMessages()...` (note the `$this->$response` variable-variable) — this
references an undefined dynamic property and will error instead of surfacing the API error
message. The success path is unaffected.
