<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VWO (Wingify) (vwo) — agent index

Injects the VWO / Wingify "Smart Code" JS snippet (via `hook_page_attachments()` in `vwo.module`) so
you can run A/B / split / multivariate experiments. Everything is driven by one config object,
`vwo.settings`. No dependencies beyond core, no plugins, no Drush. 3.0.x ships the V3.0 async snippet
and a new `AccountInfo` service that detects newer "Wingify" accounts.

- **Config keys, the three admin forms, visibility & loading, routes/permission** →
  [configure/settings.md](configure/settings.md)
- **Snippet build + injection mechanism, `VwoSmartCode`, `AccountInfo`, per-user opt-out** →
  [api/snippet-injection.md](api/snippet-injection.md)

Key facts:
- Configure route `vwo.settings` → `/admin/config/system/vwo` (all three forms gated by permission `administer wingify`).
- Also `/admin/config/system/vwo/visibility` and `/admin/config/system/vwo/vwoid` (Extract Account ID).
- Config object `vwo.settings`; the account ID is the integer key `id` (null = snippet not added).
- Visibility under `filter.*`; loading under `loading.*`; account-info cache under `is_wingify_account` / `coll_url`.
- Snippet is only added when `id` is set AND (the visibility filter is disabled OR the filter allows the current page).
- Services: `vwo.account_info` (`AccountInfo` — Wingify flag / collection URL), `vwo.help` (`VwoHelp` — help HTML).
- Helper: `VwoSmartCode` (static methods building the async body / sync URL / preconnect URL / element id).
- Needs a real VWO/Wingify account for the snippet to do anything.
