# commerce_cart — agent start

Commerce submodule: the shopping cart. A cart is a draft `commerce_order` flagged as a cart.
Provides add-to-cart form, cart block, `/cart` page, and the provider/manager/session
services. Requires `commerce`, `commerce_order`. No permissions, no config form (behavior via
services + order/checkout config).

- Cart services (provider, manager, session) API → [api/cart.md](api/cart.md)
