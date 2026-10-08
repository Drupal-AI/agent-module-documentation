<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Claro Extras

Extra administrative UX for the Claro admin theme (node form layout, breadcrumb fix, Paragraph titles).


## What & when

- Use it when Claro is your admin theme and you want the node meta block shown as vertical tabs under the form.
- Also fixes an erroneous "node" breadcrumb link shown when editing a node.
- Optionally improves the display of Paragraph titles.

---

## Install & configure

- `composer require drupal/claro_extras` then `drush en claro_extras -y`.
- Settings live at **/admin/appearance/settings/claro_extras** (also linked under theme settings).
- The settings route requires the `access administration pages` permission.
- Options: display node meta as vertical tabs (and pick which content types), enable the node-edit breadcrumb fix, enhance Paragraph titles.
- The vertical-tabs and Paragraph enhancements only apply when the admin theme is actually Claro.

---

## Usage & behaviour

- Move the node meta block (author, published, etc.) into vertical tabs beneath the main node form.
- Restrict that behaviour to selected content types via the checkboxes.
- Remove the misleading `node` breadcrumb link on node edit pages.
- Improve Paragraph title readability with an extra library.
- Settings are stored in `claro_extras.settings` config.
- `hook_form_node_form_alter` applies the changes only when `system.theme` admin is `claro`.
- Enabling vertical tabs attaches the `claro_extras/claro_extras` library and reworks `advanced`/`meta` form groups.
- The breadcrumb fix attaches `claro_extras/claro_extras-node_breadcrumbs`.
- The Paragraph title enhancement attaches `claro_extras/claro_extras-paragraph_titles`.
- Settings are saved via core `theme_settings_convert_to_config()`.
- No new routes beyond the settings form; no Drush commands.
- Purely an admin-experience/theming module; no front-end effect.
- The settings form uses vertical tabs itself (a `details`/`vertical_tabs` layout).
- Content-type selection is a `checkboxes` element populated from node types.
- Safe to enable site-wide; behaviour is gated on the Claro admin theme.
- The config form is a standard `ConfigFormBase` (CSRF-protected).
