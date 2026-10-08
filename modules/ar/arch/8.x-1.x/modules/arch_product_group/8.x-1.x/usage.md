Group related Arch products (variants) and present them as a switchable option matrix on the product page.

---

`arch_product_group` links related products — typically variants that differ by one or two attributes (size, colour) — into a product group and renders them as an interactive matrix. `GroupHandler` records and queries group membership, `ProductMatrix` builds the grid of available option combinations, and an AJAX API route (`/api/product-matrix/{group_id}/{product}`, access-checked with `product.view`) returns the rendered variant when a shopper selects a different option. The module provides a group widget, an `IsGroupParent` computed field, and two field formatters (`ProductMatrixFormatter`, `ProductGroupDefaultFormatter`).

---

- Sell variant products (size/colour/etc.) as a single grouped listing.
- Link several products together into one product group.
- Render a product's variants as a clickable option matrix on its page.
- Swap the displayed product via AJAX when a shopper picks a different variant, without a full reload.
- Keep the browser URL/state in sync with the selected variant (`ProductReplaceContentCommand`).
- Mark a product as the group parent through the `IsGroupParent` field.
- Configure the matrix display with the `ProductMatrixFormatter` field formatter.
- Show a simple grouped list with the `ProductGroupDefaultFormatter`.
- Edit group membership with the `ProductGroupWidget`.
- Respect product view access on the variant AJAX endpoint (each variant is `product.view`-gated).
- Resolve group id / membership programmatically via the `product_group.handler` service.
- Build the option grid programmatically via the `product_matrix` service.
- Support translated variants (the matrix loads the current-language translation).
- Integrate with the standard Arch product display and view modes.
- Group products across multiple attribute dimensions into one matrix.
