# Commerce Product CSV Import/Export — manual setup guide

**Commerce Product CSV Import/Export** (`commerce_product_csv`) lets you bulk
**create and update** Drupal Commerce products from a CSV file, and **export**
existing products back to CSV. It is built for catalog migrations, bulk price
updates, and keeping product data in sync with an external spreadsheet or PIM.

The problem it solves is editing products at scale. Instead of clicking through the
product edit form one at a time, you download a template CSV, fill it in (or edit
an exported one), and upload it — and the module creates or updates products
accordingly. A key design choice is that **there are no hardcoded columns**: the
module inspects each product type's actual field configuration at runtime, so the
CSV column set adapts automatically as you add, remove, or change fields, for any
product type. It supports plain text, number, boolean and list fields, taxonomy
term references (creating missing terms), Commerce product attributes, long/rich
text (HTML preserved), paragraph reference fields, and file/image/media fields
(downloaded from public URLs on import, rendered back as URLs on export).

It depends on **Commerce Product**, **Paragraphs**, and Drupal core's
**Taxonomy**, **Text**, and **Media** modules, and supports Drupal 10 and 11. It
provides a single dedicated **permission** and its own import/export pages — there
is no separate settings form, so setup is just enabling it and granting the
permission (see "How to use it").

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — you grant one permission and
then use the import/export pages, described in "How to use it" below.

## Where it lives in the admin menu

The import/export pages live under the products area: go to **Commerce →
Products** and use the **Import / Export CSV** action link, or visit
**`/admin/commerce/products/csv`** directly to choose a product type. Each product
type gets its own import/export page.

## How to use it

### Grant access

Grant the **Import and export products via CSV** permission (machine name
`administer product csv`) to the appropriate roles at **People → Permissions**.
This permission is intentionally administrative — importing can create and update
products and resolve taxonomy and media references — so give it only to trusted
roles.

### Export or get a template

On a product type's import/export page you can:

- **Export products to CSV** — download every product of that type as a CSV file.
- **Download a sample CSV** — get a template pre-filled with placeholder values for
  every supported column on that product type, plus inline column documentation.

### Import

Upload a `.csv` file with a header row. At minimum the header must include
**`sku`**, **`title`**, and **`price_amount`**; the other supported columns depend
on the fields configured on that product type and are listed on the import form
itself (along with any fields that exist but aren't supported and must be edited
manually). Rows are matched to products by **SKU**:

- A row whose `sku` matches an existing variation **updates** that variation and
  its parent product.
- A row with a new `sku` and a blank `product_id` **creates** a new standalone
  product.
- Several new rows sharing the same arbitrary `product_id` value (for example
  `NEW-1`) are grouped into **one new product with multiple variations**.
- **Multi-value fields** are pipe-delimited (`value one|value two`); **paragraph**
  fields encode each item's sub-fields joined with `::`, with items separated by
  `|`.
- **Image and document columns** take one or more publicly reachable URLs,
  pipe-separated; the file is downloaded, validated against the field's allowed
  extensions and maximum size, and attached automatically (wrapped in a media
  entity first when the field targets media).

Imports run through Drupal's **Batch API**, so large files won't hit PHP timeout or
memory limits.
