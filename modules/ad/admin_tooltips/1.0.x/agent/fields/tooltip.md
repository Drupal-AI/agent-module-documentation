<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# admin_tooltips — per-field tooltip configuration & rendering

How a field gets a hover tooltip. Everything lives in `admin_tooltips.module`,
`config/schema/admin_tooltips.schema.yml`, `templates/form-element--admin-tooltips.html.twig`,
`css/admin_tooltips.css`. No routes, permissions, services or Drush.

## Install / configure

1. `drush en admin_tooltips`.
2. Go to a bundle's **Manage form display** (e.g. `admin/structure/types/manage/article/form-display`),
   open a field's widget settings gear.
3. Under **Tooltip settings** enter the text; **Update**, then **Save**. Requires the standard
   permission to administer that entity type's form display.
4. The text now shows as a hover tooltip beside the widget on the entity add/edit form.

## Storage & schema

The text is a widget third-party setting on the form-display component, key
`admin_tooltip.admin_tooltip_text`, namespaced to `admin_tooltips`. Schema
`field.widget.third_party.admin_tooltips` (a `mapping` → nullable `admin_tooltip` mapping →
`admin_tooltip_text: text`) validates it inside each `core.entity_form_display.*` config entity.
`provides_config_schema: true`; there is no dedicated config object.

## Hook wiring (all in `admin_tooltips.module`)

- `admin_tooltips_field_widget_third_party_settings_form()` — builds the settings UI: a `details`
  group "Tooltip settings" containing a `textarea` `admin_tooltip_text`, default from
  `$plugin->getThirdPartySettings('admin_tooltips')`.
- `admin_tooltips_field_widget_settings_summary_alter()` — adds `Tooltip: <text>` to the widget
  summary, truncated to 30 chars.
- `admin_tooltips_field_widget_form_alter()` → delegates to
  `admin_tooltips_field_widget_single_element_form_alter()`, which reads the third-party setting
  (returns early if empty), attaches library `admin_tooltips/tooltips`, and writes the text to
  `#admin_tooltip` on the correct sub-element:
  - `datetime`/`datelist` value elements → on the wrapper `$element['#admin_tooltip']`;
  - other `value` elements → `$element['value']['#admin_tooltip']`;
  - entity reference → `$element['target_id']['#admin_tooltip']`;
  - `link_default`/`linkit` → `$element['uri']['#admin_tooltip']`;
  - otherwise → wrapper `$element['#admin_tooltip']`.
- `admin_tooltips_preprocess_form_element()` — copies `#admin_tooltip` into the `admin_tooltip`
  template variable.
- `admin_tooltips_theme()` — registers `form_element__admin_tooltips` (base hook `form_element`).
- `admin_tooltips_theme_suggestions_form_element_alter()` — adds the `form_element__admin_tooltips`
  suggestion when `#admin_tooltip` is set; `..._container_alter()` reuses it for container elements
  (e.g. paragraph fields).

## Template & styling

`templates/form-element--admin-tooltips.html.twig` overrides the core form-element template: when
`admin_tooltip` is not empty it renders an SVG info icon plus a `.admin-tooltip__text` pop-out
containing `{{ admin_tooltip }}` (standard Twig output), then the usual label/prefix/children/
suffix/description. The wrapper gets `admin-tooltip--field`, and `admin-tooltip--fixed-size`
(scrollable box) when the text length exceeds 120. `css/admin_tooltips.css` positions the icon and
handles the hover reveal. Both the template and CSS can be overridden from the site theme.

## Operating notes

- The tooltip renders only on entity **entry forms**; it never appears on rendered entity output.
- No config object is created on install and nothing to point users to in the admin UI beyond the
  per-field Manage form display gear (no `configure` route).
- Uninstalling removes the module hooks; existing tooltip text stored inside form-display config is
  simply ignored once the schema/hooks are gone.
