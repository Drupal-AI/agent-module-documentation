<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Programmatic integration

## Services

| Service | Class | Use |
|---|---|---|
| `commerce_avatax.avatax_lib` | `AvataxLib` (`AvataxLibInterface`) | Build/send transactions, void, validate/resolve addresses. |
| `commerce_avatax.client_factory` | `ClientFactory` | Returns a configured Guzzle client (Basic auth, fixed base URI). |
| `commerce_avatax.chain_tax_code_resolver` | `ChainTaxCodeResolver` | Resolves the AvaTax tax code for an order item across tagged resolvers. |
| `commerce_avatax.customer_profile_alter` | `CustomerProfileAlter` | Adds AvaTax address-validation behavior to the checkout customer-profile inline form. |

### `AvataxLibInterface` (main methods)

- `transactionsCreate(OrderInterface $order, string $type = 'SalesOrder'): array` — builds the
  request (`prepareTransactionsCreate`) and POSTs `api/v2/transactions/create`. Caches the
  request+response for 24h keyed by order id; re-sends only if the request changed. `SalesInvoice`
  sets `commit: TRUE`.
- `transactionsVoid(OrderInterface $order): void` — POSTs
  `api/v2/companies/{companyCode}/transactions/DC-{order-uuid}/void` (`code: DocVoided`).
- `prepareTransactionsCreate(OrderInterface $order, $type)` — assembles lines from order items,
  shipments (with commerce_shipping), and non shipping/fee/tax adjustments; picks company code
  from the store field or global config; sets `customerCode`, exemption number/type. Fires
  `hook_commerce_avatax_order_request_alter()` at the end.
- `resolveAddress(array $address): array` — POSTs `api/v2/addresses/resolve` (24h cached).
- `validateAddress(array $address): array` — wraps `resolveAddress`, returns
  `['valid','errors','suggestion','fields','original']` for a Drupal-keyed address.

`AvataxLib::doRequest()` swallows Guzzle exceptions (logs, returns `[]`), so callers get an
array either way. All requests go through `ClientFactory`, whose base URI is **fixed** to
`rest.avatax.com` / `sandbox-rest.avatax.com` by `api_mode` — not caller/config-controlled.

## Tax-code resolver chain (extension point)

Tax code per order item is resolved by services tagged
`commerce_avatax.tax_code_resolver` (collected into `ChainTaxCodeResolver`). Implement
`Drupal\commerce_avatax\Resolver\TaxCodeResolverInterface::resolve(OrderItemInterface): ?string`
and register with a priority tag; first non-NULL wins.

```yaml
# my_module.services.yml
my_module.avatax_tax_code_resolver:
  class: Drupal\my_module\MyTaxCodeResolver
  tags:
    - { name: commerce_avatax.tax_code_resolver, priority: 200 }
```

Shipped default: `ProductVariationTaxCodeResolver` (priority 100) returns the variation's
`avatax_tax_code` field value.

## Alter hooks (`commerce_avatax.api.php`)

- `hook_commerce_avatax_order_request_alter(array &$request_body, OrderInterface $order)` — mutate
  the transaction body before it is sent (e.g. force `type = 'SalesInvoice'`).
- `hook_commerce_avatax_order_response_alter(array &$response_body, OrderInterface $order)` — react
  to the AvaTax response (invoked from `transactionsCreate`).

## Commerce event

`AvataxLib::resolveCustomerProfile()` dispatches the commerce_tax
`TaxEvents::CUSTOMER_PROFILE` (`CustomerProfileEvent`) per order item, so existing
customer-profile subscribers apply to the address sent to AvaTax.

## Address-validator route

`commerce_avatax.address_validator` — `POST /commerce-avatax/address-validator`, `_format: json`,
`_access: 'TRUE'` (reachable by anonymous checkout users) but **`_csrf_token: 'TRUE'`**. Body is
a JSON address; `AddressValidator::process()` calls `AvataxLib::validateAddress()` and returns
the validation result (with a rendered `avatax_address` suggestion for a modal). Outbound call
is to the fixed Avalara host using the site's stored credentials — by design for the checkout
address-suggestion feature.

## Order lifecycle (`OrderSubscriber`)

- `commerce_order.place.post_transition` → `transactionsCreate($order, 'SalesInvoice')` unless
  `disable_commit` or the order has no AvaTax adjustments.
- `commerce_order.cancel.pre_transition` and `OrderEvents::ORDER_DELETE` → `transactionsVoid()`.
