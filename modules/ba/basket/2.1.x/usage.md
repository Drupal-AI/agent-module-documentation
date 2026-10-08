Basket (Drupal AlternativeCommerce) is a self-contained online store for Drupal that turns ordinary
node types into products and adds a cart, checkout, orders, currencies, delivery, payment, discounts,
stock and e-mail notifications — a lightweight alternative to Drupal Commerce that works right after
install. It depends on core node, token and views plus the contrib scss_compiler (storefront CSS is
compiled from Sass at request time), and it manages everything from one "Shop" admin section.

---

Products are any node bundle you register in the store; each carries Basket's own currency-aware price
field (basket_price_field), and optional image and stock fields. A session- or cookie-based cart
(scoped per user/visitor) collects items, and checkout is a basket_order node form whose totals,
discounts and delivery costs are always computed server-side from the cart. Orders live in bespoke
basket_* tables and are managed on a dedicated admin UI with filtering, xlsx export and mPDF invoices.
The store is extended through eight plugin types (payment gateways, delivery methods, delivery
settings, discount rules, product params, popups, stock bulk ops, extra settings) — payment and
delivery providers ship as separate ecosystem modules. Currencies, delivery types, payment types and
order statuses are configured as terms; an in-admin Twig template editor (with preview) controls the
storefront and e-mail templates. Blocks provide a live cart count, a currency switcher, an exchange
rate and the shopper's personal discount, and a rich hook API lets integrators override prices,
discounts, order data and the payment/delivery flow. Settings are stored as basket.setting.* config
objects (no dedicated settings page — everything is under /admin/basket/settings-*), and there are no
config-schema files, so those objects are untyped.

---

- Build a full online store on Drupal without installing Drupal Commerce.
- Turn an existing content type into a sellable product with a price and image.
- Add a currency-aware price field (with an "old price") to product nodes.
- Let visitors add products to a cart and check out with an order form.
- Run the cart for anonymous users via a signed cookie instead of PHP sessions (cache-friendly).
- Merge a guest's cart into their account automatically on login or registration.
- Manage orders (view, edit, delete, restore from trash) from a dedicated admin section.
- Separate "change status" from "change financial status" rights for order staff.
- Filter the orders list by configurable fields and export orders to xlsx.
- Print an order invoice / waybill as a PDF (mPDF).
- Sell in multiple currencies and let shoppers switch the display currency with a block.
- Show a live cart-count block and the shopper's personal discount percentage in a region.
- Offer per-user or range-based discounts through discount plugins.
- Track product stock and manage on-hand quantities from the stock-product screen.
- Configure order statuses and financial statuses as colored terms.
- Add delivery methods and payment methods as configurable terms plus plugins.
- Integrate a payment gateway by writing a BasketPayment plugin (with server-side verification).
- Integrate a carrier by writing a BasketDelivery plugin.
- Send admin and customer e-mail notifications when a new order is placed.
- Edit storefront and e-mail templates directly in the admin panel with a Twig editor + preview.
- Pre-fill the order form fields from tokens.
- Add per-product option/parameter forms via BasketParams plugins.
- Override computed line prices, discounts or the cart total with hooks.
- React to order placement and payment confirmation with hooks (basket_postInsertOrder, basket_paymentFinish).
- Expose the add-to-cart button on a node display or as a Views field.
- Localize the storefront and export/import a Basket add-on's translations with the basket:po Drush commands.
- Style the storefront by editing colors/contacts that feed the SCSS compiler.
