A placeholder Arch submodule reserved for product-level statistics; it ships no functionality yet.

---

`arch_product_statistics` is, as of `8.x-1.0-alpha26`, a stub. Its directory (`modules/statistics/products/`) contains only `arch_product_statistics.info.yml` — package `Arch TODO`, an empty description, and dependencies on `arch` and `arch_product`. There is no PHP, no routing, no services, no permissions, and no config or schema. Enabling it does nothing beyond declaring the module and pulling in its dependencies; it exists as a reserved namespace for future product-reporting features (the counterpart to `arch_order_statistics` for orders). Do not expect any product-statistics behaviour from this version.

---

- Reserve the `arch_product_statistics` machine name / namespace for future product reporting.
- Signal intent to add product-level statistics to an Arch store (roadmap placeholder).
- Pair conceptually with `arch_order_statistics` (order-level reporting).
- Enable it as a no-op dependency without adding runtime behaviour.
- Serve as a mount point for a future product-statistics feature without breaking config if referenced.
- Document, for agents, that no product-statistics API/route/service currently exists in Arch here.
- Avoid assuming product KPIs (views, sales counts) are provided by this module in this release.
- Track the Arch product-statistics feature area in dependency graphs.
