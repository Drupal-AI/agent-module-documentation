Sell digital goods with Arch by attaching downloadable files to a product type and serving them only to customers who purchased the product.

---

`arch_downloadable_product` extends Arch's `arch_product` with a per-product-type "Downloadable" toggle. When enabled on a product type, the module auto-creates a multi-value file field named `product_file` on the `product` entity using the `private` URI scheme. Buyers receive per-file download links built by `DownloadUrlBuilder`, which sign the URL with the site private key; the download route `/product/{product_id}/{file_uuid}/{user_uuid}` is access-checked server-side (`ProductDownloadController::downloadAccess()` + `ProductFileAccess`) so that only the logged-in owner of a completed order containing that product may fetch the file. Each user also gets a "My files" listing at `/user/{user}/downloads`.

---

- Sell e-books, PDFs, music, software, or other digital downloads through an Arch store.
- Mark an existing product type as "Downloadable" on its add/edit form to enable file sales.
- Automatically provision a `product_file` file field (private scheme, unlimited cardinality) on downloadable product types.
- Upload one or more files per product; each file becomes an independently downloadable item.
- Restrict downloads to customers who have a completed order for the product (purchase verified against `arch_order`).
- Give each customer a personal "My files" page listing every file they have purchased with size, date, product and order.
- Generate signed, per-user download URLs that cannot be shared to another account (the URL's user UUID is bound to the current session).
- Keep source files out of the public web root by storing them under `private://`.
- Display a "Product download" formatter on the `product_file` field that only renders links for entitled users.
- Use the download-link description text as the visible link label via the formatter setting.
- Prevent accidental removal of the managed file field by disabling its delete action while products still hold files.
- Show download links inline on the product page for buyers, and hide them from everyone else.
- Support translated products — the "My files" listing resolves the file list in the visitor's language.
- Integrate digital and physical catalog items in the same store, toggling downloadable per product type.
- Let administrators convert a product type back to non-downloadable, which removes the file field.
- Provide a reusable `download_url_builder` service for other modules that need to construct entitled download URLs.
- Provide a `downloadable_product.access` service to check file entitlement programmatically (`check`, `checkByIds`, `checkByIdsWithToken`).
