# Dashboard configuration

Routes (all under `/admin/content-planner/dashboard`):
- `content_planner.dashboard` — the dashboard view (`view content planner dashboard`).
- `content_planner.dashboard_settings` — `/settings`, enable/order/title widgets
  (`administer content planner dashboard settings`).
- `content_planner.dashboard_block_config_form` — `/configure/{block_id}`, per-widget config
  (same admin permission).

## Config object

Single config object `content_planner.dashboard_settings`, key `blocks` = map of block id →

```
plugin_id: custom_html_block_1        # the DashboardBlock plugin id
title: 'My widget'
weight: 0
configured: true
plugin_specific_config:               # plugin-defined; e.g. content, view, allowed_roles
  allowed_roles: { editor: editor }   # empty/unset = all roles; user 1 always sees it
```

Read/write via service `content_planner.dashboard_settings_service`
(`DashboardSettingsService`): `getBlockConfigurations()`, `getBlockConfiguration($id)`,
`saveBlockConfiguration($id, $config)`, `saveBlockConfigurations($all)`. There is **no config
schema** shipped for this object.

## Shipped widgets (`Plugin/DashboardBlock/`)

- `user_block` (User Widget) — lists users and their moderation stats.
- `view_1_block` … `view_10_block` (View 1–10) — each embeds one View; `plugin_specific_config`
  holds the `view_id.display_id` string. Rendered only if `$view->access($display)` passes.
- `custom_html_block_1|2|3` (Text/HTML Widget 1–3) — a `text_format` field
  (`plugin_specific_config.content = {value, format}`) rendered with
  `check_markup($value, $format)`; the config form hardcodes `#format => 'full_html'`.

Per-widget role visibility comes from `plugin_specific_config.allowed_roles`
(`DashboardBlockBase::currentUserHasRole()`), evaluated at render time.

Note (not a vuln, by design): the Text/HTML widgets let a holder of `administer content planner
dashboard settings` author `full_html` markup shown to all dashboard viewers. Output goes through
`check_markup`, so the active text format's filters apply — keep `full_html` restricted to trusted
roles as with any Full HTML field.
