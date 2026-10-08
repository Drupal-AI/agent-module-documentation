<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme Switcher Rules — agent index

One config entity type (`theme_switcher_rule`) + one theme negotiator. Each rule pairs a
theme (and optional admin theme) with a set of core **Condition plugins**; the first
matching enabled rule, in weight order, wins.

- **Create / read / order rules, config shape, condition syntax, drush recipes** →
  [configure/rules.md](configure/rules.md)
- **The five permissions and the access handler** →
  [permissions/permissions.md](permissions/permissions.md)
- **`hook_available_conditions_alter()`** →
  [hooks/available-conditions.md](hooks/available-conditions.md)

Key facts:
- Config entity: type id `theme_switcher_rule`, config prefix **`theme_switcher.rule.*`**
  (so `theme_switcher.rule.my_rule`), exported keys:
  `uuid,id,label,weight,status,theme,admin_theme,conjunction,visibility`.
- Admin UI: `/admin/config/system/theme_switcher` (route `theme_switcher.admin`, the
  module's `configure` route). Add form at `…/add`, edit at `…/edit/{id}`.
- Negotiator service `theme.negotiator.theme_switcher_negotiator`, tag
  `theme_negotiator` **priority 12**.
- `visibility` holds condition plugin configs keyed by plugin id, identical in shape to a
  block's visibility settings.
- Admin routes use `admin_theme`; everything else uses `theme`. A rule with an empty theme
  for the current context is skipped.
