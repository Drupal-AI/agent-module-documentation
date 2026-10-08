<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Product statistics (arch_product_statistics) — agent index

**Placeholder submodule** of Arch for product statistics. Package `Arch TODO`. Depends on `arch`,
`arch_product`. Core `^9.4 || ^10 || ^11`. License GPL-2.0-or-later. Version dir `8.x-1.x`
(installed `8.x-1.0-alpha26`).

## What it actually is

As of this release the module directory (`modules/statistics/products/`) contains **only**
`arch_product_statistics.info.yml`. There is:

- no `.module` / `.install` / PHP `src/`,
- no `.routing.yml`, `.services.yml`, `.permissions.yml`,
- no `config/` or `config/schema/`.

The info file's `package` is literally `Arch TODO` and its description is empty. Enabling the module
only registers it and its dependencies — it provides **no entities, routes, services, permissions,
plugins or hooks**. Treat it as a reserved namespace for future product-reporting functionality
(compare the sibling `arch_order_statistics`). No API to document here yet.
