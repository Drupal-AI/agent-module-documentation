Drupal Commerce is a flexible, modular eCommerce platform for Drupal; the base `commerce` module defines the shared framework (conditions, entity traits, inline forms, currency/number formatting, country/locale resolution) that its submodules — Store, Product, Order, Cart, Checkout, Payment, Price, Tax, Promotion — build on to create a full storefront.

---

Rather than one monolith, Commerce is split into cooperating submodules, and the base module supplies the common plumbing they all share. It defines three plugin types: **conditions** (reusable boolean rules used by promotions, shipping, payment, etc.), **entity traits** (opt-in bundles of fields/behavior you attach to commerce entity bundles), and **inline forms** (embeddable sub-forms like address or payment-method entry). It provides currency-aware number/price formatting via the `commerceguys/intl` library, current-country and current-locale resolvers (with chain/decorator patterns) so prices, addresses and taxes adapt to the customer, a configurable-field manager for programmatically adding fields to bundles, a mail handler, and an admin "Commerce" configuration hub at `/admin/commerce/config`. On top of this base, the submodules add stores and currencies, products with variations and attributes, orders with adjustments and workflows, an AJAX shopping cart, configurable multi-step checkout flows, a pluggable payment system with gateways and stored payment methods, tax types and rates, and percentage/fixed promotions with coupons. It depends on Address, Entity API, Entity Reference Revisions, Inline Entity Form, Profile, State Machine and Token. Because everything is entity- and plugin-based, developers extend it with custom conditions, checkout panes, payment gateways, tax types and more.

---

- Build a complete online store on Drupal with products, cart, checkout and payment.
- Sell physical goods, digital downloads, services or event tickets.
- Run multiple stores (brands/regions) from one Drupal install.
- Support multiple currencies with locale-aware price formatting.
- Model products with variations (size/color) and purchasable variations.
- Define reusable conditions (order total, product, customer role) for promotions and rules.
- Attach opt-in field bundles to commerce entities via entity traits.
- Embed inline sub-forms (address, payment method) inside larger forms.
- Add custom fields to order/product/store bundles programmatically.
- Resolve the customer's country and locale to drive pricing, tax and address handling.
- Provide an AJAX add-to-cart experience with a cart block and page.
- Configure multi-step, multi-pane checkout flows per order type.
- Accept payments through pluggable gateways (on-site and off-site).
- Store customer payment methods for repeat purchases.
- Calculate and apply taxes (VAT, GST, US sales tax) by rate and jurisdiction.
- Offer percentage or fixed-amount promotions with optional coupon codes.
- Generate sequential, formatted order/invoice numbers.
- Track an activity log/audit trail on commerce entities.
- Manage order workflows with state machine transitions (draft → placed → fulfilled).
- Apply order adjustments (discounts, fees, taxes) as first-class line items.
- Send transactional commerce emails through the mail handler.
- Extend checkout with custom panes (gift message, delivery date, terms acceptance).
- Add a custom payment gateway integration for a regional processor.
- Restrict promotions/payment methods with condition plugins.
- Localize a storefront's prices, addresses and taxes for international customers.
