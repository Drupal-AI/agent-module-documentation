<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fivestar — agent index

Star-rating system on top of **Voting API** (`votingapi`). Adds a `fivestar` field type,
star widgets/formatters, a `#type => 'fivestar'` Form element, and a pluggable star-skin
system. One permission: **rate content**. No working central admin page (the info file's
`configure: fivestar.admin_overview` route is **not registered**) — configure everything
per field.

- **Add/configure a rating field, storage `vote_type`, stars, voting rules, display skins, permission** →
  [configure/field.md](configure/field.md)
- **Plugins it provides: field type, `fivestar_stars`/`fivestar_select` widgets, `fivestar_stars`/`fivestar_percentage`/`fivestar_rating` formatters, the `fivestar` Form element, star skins** →
  [plugins/plugins.md](plugins/plugins.md)
- **Services to cast/query votes and read results from code** (`fivestar.vote_manager`, `fivestar.vote_result_manager`, `fivestar.widget_manager`) →
  [api/services.md](api/services.md)
- **Hooks you can implement: `hook_fivestar_widgets`, `hook_fivestar_widgets_alter`, `hook_fivestar_access`** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts: rating is stored 0–100 internally (a star = `ceil(i * 100 / stars)`); each field
save also writes a Voting API `vote` of the field's **storage** `vote_type` (default `vote`).
Requires the `votingapi` module. Field settings live in
`field.field.<entity>.<bundle>.<field>` → `settings`; the skin choice lives on the widget/
formatter in the form/view display.
