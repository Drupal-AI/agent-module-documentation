# Configure (settings)

One admin form, `SelectifySettingsForm` (form id `selectify_settings_form`), at
`/admin/config/selectify/settings` (route `selectify.settings_form`, permission
`administer selectify settings`). It edits the config object **`selectify.settings`** and, when the
`selectify_webform` submodule is enabled, also **`selectify_webform.settings`**. The five integration
paths are independent — radios/checkboxes are global, the three form-based paths (Views, Form API,
Webform) each have their own disable / site-wide / per-target mode, and field widgets are set on
Manage Form Display (see [../fields/widgets.md](../fields/widgets.md)).

## `selectify.settings` keys (schema `config/schema/selectify.schema.yml`)

| Key | Type | Default (install) | Meaning |
|---|---|---|---|
| `enable_radio` | bool | `true` | Style all radio buttons globally. |
| `radio_style` | string | `toggle` | `toggle` or `checkbox`. |
| `radio_shape` | string | `circle` | `circle` or `square`. |
| `radio_size` | string | `medium` | `small` / `medium` / `large`. |
| `enable_checkbox` | bool | `true` | Style all checkboxes globally. |
| `checkbox_style` / `checkbox_shape` / `checkbox_size` | string | `toggle` / `circle` / `medium` | Same value sets as radios. |
| `disable_on_admin_routes` | bool | `false` | Skip Selectify on `/admin*` routes (all paths). |
| `disabled_pages` | string | `admin/appearance/settings/gin` | Newline-separated path patterns (wildcards via `PathMatcher::matchPath`, matched against path AND alias) where ALL Selectify output is suppressed. |
| `accent_color` | string | `neutral` | Front-end accent: `none|blue|coral|gold|indigo|neutral|slate|teal`. |
| `accent_color_mode` | string | `light` | `none|light|dark`. |
| `admin_accent_color` / `admin_accent_color_mode` | string | `neutral` / `light` | Same, applied on admin routes (chosen via `AdminContext`). |
| `apply_site_wide` | bool | `true` | Views: apply `global_selectify_widget` to every exposed select filter. |
| `disable_views_widgets` | bool | `false` | Views: turn Selectify off for all exposed filters. |
| `global_selectify_widget` | string | `selectify_dropdown` | Views site-wide widget (one of the 5 integration widget values). |
| `widget_for_filters` | sequence | `[]` | Views per-display map: entries `{filter_id/unique_key, widget, exposed_form_id}`. |
| `enable_form_api_selects` | bool | `false` | Master switch for the Form API path. |
| `form_api_widget_map` | sequence | `[]` | Form API per-form map: entries `{form_id, widget}`. |
| `css_selector_widget_map` | sequence | `[]` | Form API CSS-selector rules: entries `{selector, widget}` (evaluated BEFORE the per-form map). |

Integration **widget** values everywhere in this config are: `selectify_dropdown`, `selectify_tags`,
`selectify_searchable`, `selectify_checkbox`, `selectify_dual` (schema `Choice`-constrained). These are
NOT the field-widget plugin ids — see [../fields/widgets.md](../fields/widgets.md).

Removed by update hooks (do not re-add): `form_api_widget` (single default, dropped in
`selectify_update_10004`), `form_api_excluded_forms` (dropped in `_10002`). `hook_uninstall` deletes
`selectify.settings` and the discovered-forms state.

## The three form-based modes (Views / Form API / Webform)

- **Views** (`hook_preprocess_views_exposed_form`): `disable_views_widgets` beats `apply_site_wide`
  beats `widget_for_filters`. `submitForm` mutually-exclusively clears the other keys. The per-view
  table only lists displays that actually expose a `select`/`radios` filter (`getExposedFilters()`
  walks all views, resolving default-display inheritance).
- **Form API** (`hook_form_alter`): there is **no site-wide mode** — a plain form is styled only if it
  matches a `css_selector_widget_map` rule or is listed in `form_api_widget_map`. Forms are recorded
  into `state('selectify.form_api_discovered_forms')` at render time (capped at 1000, form_id
  sanitised `[^a-zA-Z0-9_-]` and length-limited) so the settings form can list them. A hardcoded
  blocklist (`SelectifyHelper::getInternalBlockedFormPatterns()`, e.g. `views_ui_*`, `layout_builder_*`,
  `system_modules`, Field-UI edit forms, `selectify_settings_form` itself) is always excluded.
  CSS-selector rules are validated (`validateForm`): chars `<>&;{}()\/` and control chars rejected,
  max 50 rules.
- **Webform** (submodule, `selectify_webform.settings`): keys `enable_webform_selects` (bool, default
  `true`), `disable_webform_widgets` (bool), `apply_site_wide_webform` (bool), `global_webform_widget`
  (string, default `none`), `widget_for_webforms` (sequence of `{webform_id, widget}`). Same
  disable/site-wide/per-target precedence as Views. The per-webform table lists only webforms whose
  decoded elements contain a `select` or a known composite type.

## Radio / checkbox styling mechanism

`enable_radio`/`enable_checkbox` add body classes (`SelectifyStyleService::getBodyClasses()`,
e.g. `selectify-radio-toggle-circle-medium`) in `hook_preprocess_html`, attach
`selectify/selectify-radio-checkbox` + the accent library in `hook_page_attachments[_alter]`, and inject
an inline `<style id="selectify-inline-variables">` block of `--selectify-radio-*` /
`--selectify-checkbox-*` CSS variables from `SelectifyStyleService::getConfiguredInlineCss()`. All
values are drawn from fixed lookup tables keyed by the schema-constrained config values (no user text
reaches the CSS).

## Set config from code

```php
$config = \Drupal::configFactory()->getEditable('selectify.settings');
// Views: one widget for every exposed select filter.
$config->set('disable_views_widgets', FALSE)
  ->set('apply_site_wide', TRUE)
  ->set('global_selectify_widget', 'selectify_searchable')
  ->clear('widget_for_filters')
  ->save();

// Form API: target specific selects by CSS selector, or a whole form.
$config->set('enable_form_api_selects', TRUE)
  ->set('css_selector_widget_map', [
    ['selector' => 'select[name^="field_"]', 'widget' => 'selectify_tags'],
  ])
  ->set('form_api_widget_map', [
    ['form_id' => 'my_custom_form', 'widget' => 'selectify_dropdown'],
  ])
  ->save();
```
