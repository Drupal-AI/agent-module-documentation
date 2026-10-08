<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Product CSV Import/Export (commerce_product_csv) — agent index

**Bulk create/update Commerce products (with paragraph & taxonomy fields) from CSV, and export products back to CSV.**

- **Version:** 1.1.x
- **Core:** ^10 || ^11
- **Package:** Commerce
- **Dependencies:** commerce_product, paragraphs, taxonomy, text, media
- **Permission:** `administer product csv` (restrict access: true) — gates all routes
- **Routes:** `/admin/commerce/products/csv` (overview), `/admin/commerce/products/csv/{product_type}` (import form), `.../export`, `.../sample` — each requires the permission + `accessProductType` custom check.
- **Service:** `commerce_product_csv.manager` (ProductCsvManager)
- **Security:** All routes permission-gated (`administer product csv`, restricted) plus a custom check the product type exists. Upload is a `managed_file` limited to the `csv` extension; the file is read via `file_system` realpath of the stored URI (no user-supplied path → no traversal). Export streams via `php://output`. No anonymous or unauthenticated surface. No security findings.

See [configure/import-export.md](configure/import-export.md).
