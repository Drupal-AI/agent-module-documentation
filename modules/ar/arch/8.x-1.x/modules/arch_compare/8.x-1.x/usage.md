Lets storefront visitors select several Arch products and view them side by side in a comparison table.

---

`arch_compare` adds product comparison to an Arch store. Each product type is opted in with a `Comparable` third-party setting (a checkbox on the product-type form). Comparable products then gain a `compare_item` extra display field — a "Compare" checkbox carrying the product id, title and URL — and a `compare_block` block that lists the current selection with a link to the compare page. Selection is maintained in the browser (JavaScript backed by `drupalSettings` and local storage; libraries `compare_storage` / `compare_selectors` / `compare_item` / `compare_block`). The `/compare-products` page (`CompareController::page()`) renders the chosen products as a field-by-field table using a configurable `compare` view mode: rows are grouped by `field_group` groups and CSS-classed as `same-values`, `different-values` or `empty-values` so differences stand out. A settings form at `/admin/store/settings/compare` (permission `administer compare`) sets the `limit` (max comparable items, default 2), the `view_mode`, and a selection-preservation time; over-limit requests are trimmed and redirected.

---

- Let customers compare two or more products side by side.
- Opt specific product types into comparison with a per-type "Comparable" flag.
- Add a "Compare" checkbox to comparable products' display.
- Show a compare block listing the visitor's current selection with a link to the compare page.
- Keep the comparison selection in the browser across page views (client-side storage).
- Render a field-by-field comparison table driven by a dedicated `compare` view mode.
- Group compared fields using Field Group groups.
- Highlight rows where values are the same, different, or empty via CSS classes.
- Cap the number of products that can be compared at once (configurable limit).
- Choose which view mode supplies the fields shown in the comparison.
- Configure how long a selection is preserved.
- Trim and redirect requests that exceed the comparison limit.
- Help shoppers make purchase decisions by contrasting specifications.
- Theme the comparison table, block and item via the module's Twig templates.
- Integrate comparison directly into product pages through an extra display field.
- Provide an admin settings page under the store settings menu.
