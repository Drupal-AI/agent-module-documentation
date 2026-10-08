Adds warehouses and per-warehouse product stock to Arch, reducing quantities automatically as customers place orders.

---

`arch_stock` gives an Arch store inventory management. It defines a `warehouse` config entity and a multi-value `stock` field (field type `stock`, columns `warehouse` / `quantity` / `cart_quantity`) that is attached to products whose product type has stock enabled (third-party setting `arch_stock.stock_enable`). A per-warehouse permission set — `purchase from {id} stock`, plus restricted `create` / `edit` / `delete {id} stock` — governs which roles may buy from or manage each warehouse, so different customer groups can see different availability. The `arch_stock.stock_keeper` service computes total available stock for the current user across the warehouses they may draw from, decides whether a purchase is possible (including optional over-booking / negative stock), and reduces stock under a lock when an order completes, invalidating the product's cache tags. A site-wide settings form lives at `/admin/store/stock` and a warehouse admin UI under `/admin/store/stock/warehouse`.

---

- Track how many units of a product are on hand, per warehouse.
- Run multiple warehouses / stock locations from one store.
- Enable stock tracking only for selected product types (third-party setting on the product type).
- Restrict which customer roles can purchase from a given warehouse (`purchase from {id} stock`).
- Restrict who can create / edit / delete stock for a warehouse (admin-only, `restrict access`).
- Automatically reduce a product's stock when a customer places an order.
- Prevent race conditions on concurrent orders using a per-product lock during stock reduction.
- Allow over-booking (negative stock) on chosen warehouses via the `allow_negative` flag.
- Automatically switch a product's availability status when a warehouse is oversold (`overbooked_availability`).
- Show a per-warehouse stock table on the product edit form (`stock_default` widget).
- Display current stock on the product page (`stock_default` formatter).
- Compute the buyable quantity for the current user across only the warehouses they may access.
- Reserve in-cart quantities separately from on-hand quantity (`cart_quantity` column / `stock_cart.info` service).
- Show an "out of stock" message per product type when quantity is exhausted.
- Let other modules adjust computed stock via `hook_product_stock_alter()` and react via `hook_stock_reduced()`.
- Let other modules override warehouse selection via `hook_stock_keeper_selected_warehouses_alter()`.
- Provide a locked "Default" warehouse out of the box for simple single-location stores.
- Integrate stock into Search API / Views to filter product listings by "has stock" (via `arch_stock_search_api`).
- Define a default over-booked availability and weighting per warehouse.
- Keep product listings cache-correct by invalidating product cache tags whenever stock changes.
