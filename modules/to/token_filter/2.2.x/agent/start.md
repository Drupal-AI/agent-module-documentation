# token_filter — agent start

Text-format input filter that expands global + entity tokens (`[site:name]`, `[node:title]`)
to their values at render. Depends on core `filter` + `token`. No dedicated config page — it is
enabled per text format at **Admin → Config → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

- Enable/order the filter, CKEditor token browser, how it resolves entity tokens → [configure/filter.md](configure/filter.md)
