<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Easy Responsive Tabs to Accordion (field_group_easy_responsive_tabs) — agent index

Adds two **field_group formatters** that render a field group as **horizontal/vertical tabs that
collapse to an accordion on narrow screens**, driven by the external "Easy Responsive Tabs to
Accordion" jQuery plugin. You build the structure entirely in field_group: a parent group uses the
`ertta_tabs` formatter (the wrapper) and each child group uses `ertta_tab` (one tab). The wrapper's
`preRender` (`src/Plugin/field_group/FieldGroupFormatter/Tabs.php`) sets `#type`
`field_group_easy_responsive_tabs`, attaches this module's two libraries, and copies each formatter
setting onto the wrapper as a `data-*` attribute; the init script
(`assets/js/field_group_easy_responsive_tabs.js`) reads those attributes and calls
`$el.easyResponsiveTabs({...})` on `.field-group-easy-responsive-tabs`.

Both formatters work in **form and view** displays (`supported_contexts = {form, view}`), so the same
grouping can theme the node edit form and the rendered entity. Rendering goes through two theme hooks
(`field_group_easy_responsive_tabs`, `field_group_easy_responsive_tab`) whose preprocessors
(`templates/theme.inc`) build the `resp-tabs-list` navigation `<ul>` from each child tab's `#title`
and wrap children in `resp-tabs-container`. There are **no routes, controllers, services,
permissions, or drush commands** — configuration is the field_group formatter settings only.

- Depends on: `field_group:field_group` (formatter host). **External asset (not via Composer):** the
  Easy Responsive Tabs to Accordion jQuery plugin must be unpacked into the site's
  `/libraries/easy-responsive-tabs/` (see configure/setup.md) or nothing initialises.
- Core: `^9.4 || ^10 || ^11`. Package: `Fields`. Composer requires `drupal/field_group ^3.0 || ^4.0`.
- No settings page / `configure` route. No permissions. No drush. No config schema shipped. Does
  **not** define a plugin type (it implements field_group's `FieldGroupFormatter`).

## What you'd do → where

- **Install the required jQuery library and build the tabs/tab group nesting on a display** →
  [configure/setup.md](configure/setup.md)
- **The two formatter plugin ids, every settings key + default, the `data-*`→JS wiring, render
  elements, theme hooks & suggestions** → [plugins/formatters.md](plugins/formatters.md)

## Key facts (real machine names)

- Field-group formatters (plugin type `FieldGroupFormatter`, provided by field_group):
  - `ertta_tabs` — class `Drupal\field_group_easy_responsive_tabs\Plugin\field_group\FieldGroupFormatter\Tabs` (the wrapper; has the settings form).
  - `ertta_tab` — class `…\FieldGroupFormatter\Tab` (a single tab; no extra settings).
- Render/form elements: `field_group_easy_responsive_tabs` (`src/Element/Tabs.php`, process
  `processTabs`), `field_group_easy_responsive_tab` (`src/Element/Tab.php`).
- Theme hooks (`hook_theme`): `field_group_easy_responsive_tabs`, `field_group_easy_responsive_tab`
  — templates `templates/field-group-easy-responsive-tab{s}.html.twig`, preprocessors in
  `templates/theme.inc`; suggestions added by `field_group_easy_responsive_tabs_theme_suggestions_alter`.
- Libraries (`*.libraries.yml`): `field_group_easy_responsive_tabs/easy-responsive-tabs`
  (external `/libraries/easy-responsive-tabs/{js/easyResponsiveTabs.js,css/easy-responsive-tabs.css}`
  + `core/jquery`) and `…/easy-responsive-tabs-init` (`assets/js/field_group_easy_responsive_tabs.js`,
  deps `core/once`, `core/drupal`, `core/drupalSettings`).
- `ertta_tabs` settings keys: `type`, `width`, `fit`, `closed`, `active_bg`, `inactive_bg`,
  `active_border_color`, `active_content_border_color`, `id`.
- Hooks: `hook_help` (`help.page.field_group_easy_responsive_tabs`), `hook_theme`,
  `hook_theme_suggestions_alter`.
- CSS classes on the wrapper (`Tabs::getClasses`): `field-group-easy-responsive-tabs`,
  `field-group-easy-responsive-tabs-<type>`, `field-group-<format_type>-wrapper`.
