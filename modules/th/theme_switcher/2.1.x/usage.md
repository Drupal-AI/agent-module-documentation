<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Theme Switcher Rules lets you swap the active theme (and admin theme) based on Drupal's Condition plugin system — by path, content type, language, role, and anything else that exposes a condition.

---

The module defines one config entity type, `theme_switcher_rule` (config prefix `theme_switcher.rule.*`), and one theme negotiator service, `theme.negotiator.theme_switcher_negotiator`, registered at priority **12** so it outranks core's default negotiators. Each rule stores a `theme`, an optional `admin_theme`, a `status` flag, a `weight`, a `conjunction` (`and` / `or`) and a `visibility` map of **core Condition plugin** configurations — exactly the same plugin collection blocks use for their visibility settings, so `request_path`, `entity_bundle:node`, `user_role`, `language`, `response_status` and any contrib condition are available. On every request the negotiator loads all rules sorted by weight ascending, skips disabled ones and ones with no theme set, applies runtime contexts to each condition, and resolves them with the chosen conjunction; the **first** rule that passes wins and no later rule is evaluated. Whether the rule's `theme` or its `admin_theme` is used depends on `router.admin_context` — admin routes get `admin_theme`, everything else gets `theme`. The rule list at `/admin/config/system/theme_switcher` supports drag-and-drop reordering and AJAX enable/disable; five dedicated permissions plus a custom access control handler gate view/create/edit/delete. `hook_available_conditions_alter()` lets other modules remove conditions from the rule form (the module itself removes `current_theme`, which would loop, and hides `language` on monolingual sites), and entity-delete hooks clean role and language references out of saved rules.

---

- Apply a special theme to a marketing landing page path such as `/campaign/*`.
- Give one content type (e.g. Landing page) its own theme site-wide.
- Serve a different theme per language on a multilingual site.
- Show anonymous visitors one theme and authenticated editors another, by role condition.
- Use a distinct admin theme for a subset of admin pages.
- Build a "microsite" look for a section of the site without a separate Drupal install.
- Preview an in-progress theme on a single path before switching the whole site over.
- Apply a high-contrast/accessible theme on an opt-in path.
- Use a stripped-down theme for print or kiosk URLs.
- Theme a checkout or donation funnel differently from the rest of the site.
- Switch themes for a specific node id via the "Pages" condition (`/node/42`).
- Order competing rules with drag-and-drop so the most specific one wins first.
- Temporarily disable a rule from the list page without deleting it.
- Combine conditions with AND to require both a path and a content type.
- Combine conditions with OR so any one of several paths triggers the theme.
- Negate a condition to mean "every page except these".
- Deploy theme-switching logic through configuration management as `theme_switcher.rule.*.yml`.
- Delegate rule management to a non-admin role with `create/edit theme switcher rules`.
- Give a read-only role `view theme switcher rules` for auditing.
- Let a contrib condition (domain, group, workflow state) drive theme selection.
- Remove an inappropriate condition from the rule form with `hook_available_conditions_alter()`.
- Keep the site's default theme untouched while overriding it only where needed.
- Apply an event/seasonal theme for a date-range condition supplied by contrib.
- Roll out a theme redesign progressively, path by path.
- Debug theme selection by disabling rules one at a time from the admin list.
