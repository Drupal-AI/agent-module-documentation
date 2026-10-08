# commerce_payment — agent start

Commerce submodule: pluggable payment layer. Three plugin types — **payment gateway**
(processor integration, on-site/off-site), **payment method type** (stored instrument), and
**payment type** (payment category). Entities: `commerce_payment` (recorded payment),
`commerce_payment_method` (stored card), config `commerce_payment_gateway`. Requires
`commerce`, `commerce_order`, `entity_reference_revisions`, `filter`. Admin:
**/admin/commerce/config/payment-gateways** (`commerce_payment.configuration`).

- Configure gateways, checkout payment, permissions → [configure/gateways.md](configure/gateways.md)
- Payment gateway / method-type / type plugins → [plugins/payment-gateway.md](plugins/payment-gateway.md)
