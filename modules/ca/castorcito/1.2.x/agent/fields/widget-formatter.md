<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON-field widget & formatter (how content is authored and rendered)

Castorcito plugs into a **Drupal JSON field** (from the `json_field` module). One widget writes
the component data as JSON; one formatter renders it through an SDC.

## Setup (per README)

1. Create at least one component at `/admin/castorcito/component` (or enable castorcito_basepack).
2. Add a field of type **JSON (raw) / JSON (text) / JSONB** to a bundle.
3. *Manage form display* → set the field's widget to **Castorcito Component**, and in the widget
   settings pick which components are allowed.
4. *Manage display* → set the field's format to **Castorcito Component**.

## Widget — `castorcito_component_widget`

- Class `src/Plugin/Field/FieldWidget/CastorcitoComponentWidget.php`; field types `json`,
  `json_native`, `json_native_binary`. Settings: `components` (allowed component ids sequence),
  `components_settings` (per-component overrides).
- The widget marks the field so `castorcito_form_alter()` (in `castorcito.module`) can replace the
  raw JSON textarea with the Vue app: it attaches libraries `castorcito/castorcito.widget` and
  `castorcito/castorcito.form_validation`, wraps the field in `<div id="app_<field>">`, hides the
  raw element, and pushes everything the JS needs into `drupalSettings` —
  `field_components`, the assembled component models (`CastorcitoManager::getCastorcitoComponents`),
  `allowed_formats`, `castorcito_plugins_settings` (per-cfield JS path), `generalUrls()` (public
  file base, private base, CSRF token URL, upload + block-list endpoints), `default_translations`,
  and `user_permissions`. If no components are configured it shows a "no allowed components"
  notice instead.
- On submit, `CastorcitoFileProcessor::process` is appended as a submit handler to record
  file usage for image/formatted_text files (see [../api/rest-and-services.md](../api/rest-and-services.md)).

## Formatter — `castorcito_component_formatter`

- Class `src/Plugin/Field/FieldFormatter/CastorcitoComponentFormatter.php`; same three JSON field
  types. Setting `components_display_settings` (per-component display overrides).
- `viewElements()` JSON-decodes each item, resolves the component's display settings + SDC via
  `getDisplaySettings()`, applies predefined-option attributes, and returns
  `#type => component` with `#component` = the SDC id and props `component_data`,
  `display_settings`, `attributes`, `cfield_plugins`.
- **SDC resolution** (`getDisplaySettings()`): use the component's configured `sdc.id` when
  `fixed_sdc` and the SDC exists, else fall back to `castorcito:default_sdc`; a per-display
  override (`components_display_settings`) may replace the SDC id if that definition exists.
  Container / advanced_container components recurse to merge child display settings.
- The settings form lets an admin open per-component **display override** links (route
  `castorcito.list_override_component_display`); `validateComponentsDisplaySettings()` reloads the
  live view-display config to avoid stale cached settings and filters overrides to the currently
  selected components.
- `castorcito_preprocess_field()` adds `castorcito-component--even/--odd` classes per delta.

## SDC rendering & theming

The default SDC (`components/default_sdc/default_sdc.twig`) iterates `component_data.fields` and
`embed`s each cfield's SDC as `<provider>:castorcito_<type>` with `cfield_data` and
`cfield_display_settings`. Per-cfield SDCs live in `components/cfields/` and use safe helpers —
`drupal_image`, `drupal_entity`, `drupal_block`, and `#type => processed_text` for formatted text.
To override any markup, copy the SDC into a theme's `components/` dir and add
`replaces: 'castorcito:<sdc-name>'` (or `castorcito_basepack:<name>` for basepack components) to
its `.component.yml`. Available Twig props: `component_data`, `display_settings`, `attributes`,
`cfield_plugins`.
