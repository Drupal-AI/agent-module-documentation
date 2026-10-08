# VWO (Wingify) — agent index

Injects the VWO / Wingify "Smart Code" JS snippet (via `hook_page_attachments()`) so you can run
A/B / split / multivariate experiments. Everything is driven by one config object `vwo.settings`.
No plugins, no Drush.

- **All config keys, the three admin forms, drush get/set, loading & visibility** →
  [configure/settings.md](configure/settings.md)
- **The `administer vwo` permission** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Configure route `vwo.settings` → `/admin/config/system/vwo` (permission `administer vwo`).
- Also `/admin/config/system/vwo/visibility` and `/admin/config/system/vwo/vwoid` (Extract Account ID).
- Config object `vwo.settings`; the account ID is the integer key `id` (null = snippet not added).
- Visibility under `filter.*`; loading under `loading.*`.
- Snippet is only added when `id` is set AND the visibility filter allows the current page.
- Services: `vwo.account_info` (Wingify flag / collection URL), `vwo.help` (help HTML). Needs a real VWO account.
