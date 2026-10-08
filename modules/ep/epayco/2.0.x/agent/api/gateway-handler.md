<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# epayco.handler service (GatewayHandler)

`Drupal\epayco\GatewayHandler` (service `epayco.handler`, args `@http_client`, `@epayco.logger`) is the reusable
ePayco integration point. It wraps the ePayco PHP SDK and calls ePayco's REST endpoints with Guzzle. All methods
catch exceptions and log to the `epayco` channel, returning `[]`/`NULL` on failure. Interface:
`GatewayHandlerInterface`.

## Methods (`src/GatewayHandler.php`)

- `getFactory($api_key, $private_key, $language, $test)` — instantiate an `\Epayco\Epayco` SDK client from raw
  values (used by the `factory:custom` API operation).
- `executeFactoryOperation(\Epayco\Epayco $client, $element_name, $element_callback, array $params)` — experimental:
  calls `$client->{$element_name}->{$element_callback}(...$params)` via `call_user_func_array`; refuses
  `__construct` and requires the sub-object to exist.
- `getTransactionRemoteData($transaction_id)` — GET `EPAYCO_TRANSACTION_DATA_API_URL` with
  `?id_transaccion=`; returns the decoded JSON (used by cron/Drush pending-payment checks and the API endpoint).
- `getReferenceRemoteData($reference)` — GET `EPAYCO_REFERENCE_CODE_BASE_URL . $reference`; returns decoded JSON
  (used by the response page and the Commerce return handler to look up a payment by `ref_payco`).
- `getAvailablePseBanks($public_key)` — GET `EPAYCO_PSE_BANKS_LIST_API_URL` with `?public_key=`.
- `getPaymentSignature($p_cust_id_cliente, $p_key, $order_id, $p_amount, $p_currency_code)` — returns
  `md5($cust_id.'^'.$p_key.'^'.$order_id.'^'.$p_amount.'^'.$p_currency_code)`; used to sign the **outbound**
  standard-checkout form.

## Endpoint constants (`GatewayHandlerInterface`)

All `https://`:
`EPAYCO_STANDARD_CHECKOUT_API_URL` = `secure.payco.co/checkout.php`;
`EPAYCO_TRANSACTION_DATA_API_URL` = `secure.payco.co/pasarela/estadotransaccion`;
`EPAYCO_REFERENCE_CODE_BASE_URL` = `secure.epayco.co/validation/v1/reference/`;
`EPAYCO_PSE_BANKS_LIST_API_URL` = `secure.payco.co/restpagos/pse/bancos.json`;
`EPAYCO_SPLIT_PAYMENTS_API_URL` = `secure.payco.co/splitpayments.php`;
`EPAYCO_TRANSACTIONS_LIST_API_URL` = `apiservices.epayco.co/consulta/transaccion`;
`EPAYCO_MOVEMENTS_LIST_API_URL` = `apiservices.epayco.co/consulta/movimiento`.

Requests use the injected `http_client` (Guzzle) with default TLS certificate verification.

## Other services

- `epayco.logger` — `LoggerChannel` for the `epayco` channel.
- `epayco.payment_options.handler` — see [../events/transaction-response.md](../events/transaction-response.md).

`commerce_epayco` extends this class (`CommerceGatewayHandler`) to add Commerce-specific payment reconciliation.
