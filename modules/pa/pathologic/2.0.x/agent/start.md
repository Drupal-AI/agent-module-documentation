# pathologic — agent start

A text-format **input filter** (`filter_pathologic`, "Correct URLs with Pathologic") that rewrites
`href`/`src`/`srcset`/`action`/`longdesc` URLs in content so local links and images keep working when
the domain, base path, or protocol changes. Depends on core `filter`. Global config UI:
**Admin → Config → Content authoring → Pathologic** (`/admin/config/content/pathologic`,
route `pathologic.config_form`, config object `pathologic.settings`). Should be the **last** filter
in a format's processing order.

- Enable the filter on a text format; global vs. per-format settings; `protocol_style`, `local_paths`, `keep_language_prefix`, `scheme_allow_list` → [configure/pathologic.md](configure/pathologic.md)
- Alter or veto an individual URL rewrite in code → [hooks/pathologic.md](hooks/pathologic.md)
