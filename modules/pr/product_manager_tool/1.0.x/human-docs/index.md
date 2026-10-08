# Product Manager Tool — manual setup guide

**Product Manager Tool** (`product_manager_tool`) gives Drupal Commerce stores
**bulk management** for products and variations. It bundles two managers: a
**Layout Template Manager**, which saves any product's Layout Builder
configuration as a reusable template and clones it onto many products at once, and
a **Field Manager**, which updates fields across many products or variations in a
single pass. Both are translation-aware and both put a preview/confirmation step
between you and the change, so you can see exactly which products will be affected
before anything is written.

The point of the module is to save hours of repetitive work: apply a standard
layout across an entire catalog, fill in newly added fields on hundreds of
existing products, or update descriptions and specifications in several languages
at once. The Layout Template Manager preserves block configurations and content
during cloning and gives special treatment to products whose title is prefixed
with `[TEMPLATE]` so templates are easy to spot. The Field Manager detects which
fields are empty, lets you choose per field whether to overwrite existing values
or only fill blanks, reports how many entities have empty versus filled fields,
and works with complex field types (entity reference, inline entity form,
paragraphs, and the standard types). A dry-run preview and detailed
success/skip/failure statistics accompany every operation.

Because a single bulk action can change many products at once — including prices,
fields, and layouts — this is a **powerful administrative capability**. Gate it to
trusted store managers using its permissions, and always use the preview before
committing. The module has no access-control role beyond its own permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no settings form** for this module — it works immediately after you
enable it and assign permissions. Setup is a matter of granting permissions and
then using the tool, described below.

## Where it lives in the admin menu

The tool is at **`/admin/commerce/product-manager-tool`**, with two tabs:
**Layout Manager** (manage and apply layout templates) and **Field Manager** (bulk
field updates). It's built to look at home in the Gin admin theme, in both light
and dark modes.

## Setting it up and using it

1. **Assign permissions.** At **People → Permissions**
   (`/admin/people/permissions`), grant these to your trusted store-manager role:
   - **Access Product Manager Tool** — basic access to the interface.
   - **Manage Product Layouts** — create and apply layout templates.
   - **Bulk Update Product Fields** — update fields across multiple entities.
   - **Create Layout Templates** — save new layout templates.
2. **Use layout templates.** Build a product with the Layout Builder configuration
   you want (optionally prefix its title with `[TEMPLATE]`), open the **Layout
   Manager** tab, save it as a template, then select target products and apply it.
3. **Use the field manager.** Open the **Field Manager** tab, choose whether to
   work on products or variations, pick the type, select a language and any filter
   options, tick the products to update, enter the field values and per-field
   overwrite behaviour, then **preview** and confirm.

> Because bulk operations are far-reaching, test on a staging copy first and
> always review the dry-run preview before applying changes to a live catalog.

> **Note:** Product Manager Tool operates on **Drupal Commerce** products and
> variations, so it's only useful on a site that runs Commerce.
