Syncart submodule adding paragraph-based product features/upsells that apply an adjustment to the Commerce order total.

---

`syncart_product_feature` adds a `product_feature` paragraph type and a `product_feature` `commerce_product` type, an order-item bundle carrying a `field_json` field, and product/paragraph fields (`field_product_features`, `field_product_feature_products/title/widget/none`). `Service\CartService` manages adding feature items to the cart; `OrderProcessor\OrderProcessor` (tagged `commerce_order.order_processor`, priority -300) applies a `syncart_product_feature` adjustment (declared in `syncart_product_feature.commerce_adjustment_types.yml`) to the order total. `Hook\ViewsPreRender` and `Service\InstallService` support it. Depends on `paragraphs`, `syncart`, and `shs`.

---

- Model product add-ons / features as `product_feature` paragraphs referenced from a product.
- Offer a `product_feature` product type for standalone feature products.
- Store per-order-item feature selections in a `field_json` field on the feature order-item bundle.
- Add feature items to the cart through `Service\CartService`.
- Apply a `syncart_product_feature` price adjustment to the order via the tagged order processor.
- Configure feature widgets (including SHS hierarchical select) on products and paragraphs.
- Render feature data on product displays via the ViewsPreRender hook.
- Provision all required paragraph/product/order-item fields on install (`Service\InstallService`).
