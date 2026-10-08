<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Tooltips (admin_tooltips) — agent index

Adds a per-field **"Tooltip settings"** text box to the Manage form display, and renders that text
as a **hover tooltip** (info icon + pop-out) beside the field widget on entity add/edit forms to
guide editors. Version **1.0.0-beta3** (dir `1.0.x`). Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later
(shipped `LICENSE.txt`; `composer.json` says MIT).
No routes, controllers, permissions, services or Drush commands — pure form/theme integration.

## What it provides

- **Widget third-party setting** `admin_tooltips.admin_tooltip.admin_tooltip_text` (config schema
  `field.widget.third_party.admin_tooltips` in `config/schema/admin_tooltips.schema.yml`).
- **Hooks** (procedural, `admin_tooltips.module`): `hook_field_widget_third_party_settings_form`
  (adds the textarea), `hook_field_widget_form_alter` + `hook_field_widget_single_element_form_alter`
  (stash text on `#admin_tooltip`, attach library), `hook_field_widget_settings_summary_alter`
  (truncated preview), `hook_preprocess_form_element`, `hook_theme`,
  `hook_theme_suggestions_form_element_alter`, `hook_theme_suggestions_container_alter`.
- **Theme hook** `form_element__admin_tooltips` (base hook `form_element`) +
  `templates/form-element--admin-tooltips.html.twig`.
- **Library** `admin_tooltips/tooltips` (CSS `css/admin_tooltips.css`).

## Dependencies / relationships

- No module dependencies (only `drupal/core` in `composer.json`). Works with any core Field
  widget; special-cases `datetime`/`datelist`, entity-reference (`target_id`), and `link_default`/
  `linkit` (`uri`) widgets, otherwise falls back to the element wrapper.

## Solution docs

- `agent/fields/tooltip.md` — configuring the tooltip, the third-party setting + schema, the
  widget/element wiring, the theme suggestion and template, and theming overrides.

## Notes for agents

- Configuration lives on the field widget in **Manage form display**, not on a settings page —
  there is no `configure` route.
- The tooltip only appears on entity **entry forms**, not on rendered/front-end output.
