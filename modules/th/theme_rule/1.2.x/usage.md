<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Theme Negotiation by Rules lets a site builder switch the active theme per page from configurable conditions instead of from custom code.

---

Install with `composer require drupal/theme_rule` and enable it (`drush en theme_rule`); it has no dependencies and adds no settings page. Go to **Appearance → Theme rules** (`/admin/appearance/theme-rules`, requires the core **Administer themes** permission) and click **Add theme rule**. Each rule pairs a **theme** (any installed theme) with a set of Drupal **condition plugins** — Pages (path), Content types, Roles, Language, and any conditions added by other modules such as [Route Condition](https://www.drupal.org/project/route_condition). All conditions on a rule must match (AND logic) for it to apply. Order rules by dragging them: the **topmost enabled rule whose conditions all match wins**, and its theme is used for that request. You can **disable** a rule to ignore it, and a rule with **no conditions** is ignored automatically. One nuance to keep in mind: Drupal resolves the theme through a chain of negotiators ordered by service **priority** (admin theme, core default, sometimes domain or language), and this module joins that chain at priority 10 — so if a page renders in an unexpected theme, the cause is usually the negotiator ordering rather than the rule. Remember too that the active theme drives more than appearance: attached libraries, template suggestions and some render behaviour follow it, so a rule that switches theme on a path switches those there as well.

---

- Serve a marketing or campaign section with a different theme.
- Brand a partner or affiliate area separately.
- Apply a print-oriented theme on a specific path.
- Switch theme by content type (e.g. a distinct look for one node type).
- Switch theme by user role.
- Switch theme by interface language on a multilingual site.
- Combine several conditions on one rule (path AND role, etc.).
- Configure theme negotiation entirely without writing a custom negotiator.
- Replace a bespoke, hand-coded theme negotiator with configuration.
- Add a custom condition plugin (or install Route Condition) to negotiate on new criteria.
- Reorder competing rules by priority using drag and drop.
- Temporarily disable a rule without deleting it.
- Debug a page that renders in the wrong theme.
- Inspect where this module sits in the negotiator priority chain.
- Understand which negotiator ultimately wins a request.
- Account for attached libraries following the switched theme.
- Account for template suggestions changing with the theme.
- Export theme rules as configuration for deployment.
- Audit all of a site's theme-switching rules in one list.
- Document the site's theme-negotiation behaviour for a team.
