<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu vs. URL Alias forces nodes of chosen content types to either sit in a menu or carry an explicit custom URL alias, using conditional validation on the node edit form.

---

On a per-content-type opt-in, the module rewires the node form so the "Menu settings" and "URL alias" tabs behave as an either/or choice. If the menu item is enabled, the URL-alias/Pathauto fields are hidden and the menu-derived path is used; if the menu item is left off, a custom alias becomes required. A validation handler blocks saving a node that has neither a menu title nor a custom alias (and no Pathauto). It also enables the menu by default and unchecks Pathauto by default on new nodes of those types, and hides the Description and Weight fields on menu-link forms. The feature is turned on by editing a content type and ticking "Enable Menu vs. URL Alias functionality" on the "Menu vs. URL Alias Settings" tab; the list of enabled content types is stored in `menu_vs_url_alias.settings:enabled_content_types`. Depends on Pathauto. There is no admin report, no dedicated route, and no custom permission — everything works through core node/content-type forms.

---

- Force a "Web Page" content type's nodes to always be either in a menu or given a custom path.
- Prevent editors from saving a page with no menu placement and no URL alias.
- Make the menu-item vs. URL-alias choice mutually exclusive on the node form.
- Auto-enable the menu on new nodes of a governed content type.
- Auto-uncheck Pathauto on new nodes so editors consciously choose menu-based vs. custom paths.
- Require a custom alias whenever an editor chooses not to place a node in a menu.
- Hide the Pathauto/alias fields once the menu item is enabled to reduce form clutter.
- Enforce a site convention that navigable pages live in the menu tree.
- Combine with Pathauto patterns so menu-based nodes get predictable paths.
- Pair with the Simplify module to hide the URL-alias tab entirely for fixed-pattern content types.
- Turn the behavior on for one content type at a time via the content-type edit form.
- Turn the behavior off for a content type without uninstalling the module.
- Keep landing pages consistent by mandating either a menu entry or a hand-picked path.
- Reduce orphaned pages that have no menu link and an auto-generated alias nobody links to.
- Standardize how content editors think about a page's URL at creation time.
- Hide the Description and Weight fields on menu-link content forms to simplify menu editing.
- Give a clear inline error ("assign to a menu" or "give a custom URL path") when validation fails.
- Onboard new editors with guardrails that make URL/menu decisions explicit.
- Apply the rule only to content types where a path is genuinely required, leaving others untouched.
- Migrate an existing site toward a menu-first information architecture incrementally.
- Use as a lightweight editorial policy layer without writing custom code.
- Review the enabled-content-types configuration after adding or renaming content types.
