<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Selectify (selectify) — agent index

Enhances Drupal `<select>`, radio and checkbox form controls with modern, keyboard/ARIA-aware
components, applied through **four independent integration paths**: entity **field widgets** (Manage
Form Display), **Views** exposed select filters, arbitrary **Form API** selects, and (via the
`selectify_webform` submodule) **Webform** submission selects. Radios and checkboxes are styled
**globally** instead of per-field. There is no client library bundled beyond the module's own vanilla
JS/CSS: the mechanism is a native `<select>` that stays in the DOM for submission plus a rendered
overlay widget driven by `js/` behaviors; the field widgets subclass core's `OptionsSelectWidget` and
add `selectify-apply-*` classes + `data-*` attributes, while the other three paths inject the same
classes/libraries by walking form render arrays in `hook_form_alter` / preprocess hooks.

Everything is centralised in one admin config form and one config object; the code is a `.module`
file of hooks plus a `SelectifyHelper` service holding the eligibility/skip rules and a
`SelectifyStyleService` that emits inline CSS-variable overrides for the radio/checkbox styling.

- Depends on: `drupal:views`, `drupal:field` (info.yml). Submodule `selectify_webform` additionally
  depends on `webform:webform`.
- Core: `^10 || ^11`. PHP `>=8.1`. Package: `User interface`.
- Has a settings page: route `selectify.settings_form` at `/admin/config/selectify/settings`
  (`configure:` key). One permission: `administer selectify settings`. Provides config schema.
  No drush commands. Defines **no new plugin type** (its widgets use core's FieldWidget plugin type).
- Ships **5 field-widget plugins** and **3 alter hooks** for integrators.

## What you'd do → where

- **Configure any integration (Views / Form API / Webform / radio-checkbox / colors / disabled pages)
  and know every config key** → [configure/settings.md](configure/settings.md)
- **Put a Selectify widget on an entity field (Manage Form Display) / understand the widget plugins**
  → [fields/widgets.md](fields/widgets.md)
- **Understand how selects get styled at runtime (the helper service, eligibility rules, CSS-selector
  matching, the style service, routes, permission)** → [api/services.md](api/services.md)
- **Alter which widget is applied, skip an element, or block Selectify for a form; theme templates and
  the Twig filter** → [hooks/alter.md](hooks/alter.md)

## Key facts (real machine names)

- Route / form: `selectify.settings_form` (`/admin/config/selectify/settings`), form
  `Drupal\selectify\Form\SelectifySettingsForm`, form id `selectify_settings_form`. Menu link
  `selectify.settings_form` (parent `system.admin_config_system`).
- Permission: `administer selectify settings`.
- Config objects: `selectify.settings` (schema `config/schema/selectify.schema.yml`);
  `selectify_webform.settings` (submodule). State key: `selectify.form_api_discovered_forms`.
- Services: `selectify.helper` (`Service\SelectifyHelper` / `SelectifyHelperInterface`),
  `selectify.style_service` (`Service\SelectifyStyleService` / `SelectifyStyleServiceInterface`),
  `selectify.twig_extension` (`TwigExtension\SelectifyTwigExtension`). Twig filter `selectify_clean_id`.
- **Field-widget plugin ids** (Manage Form Display; base `Plugin\Field\FieldWidget\SelectifyWidgetBase`
  ⇒ core `OptionsSelectWidget`): `selectify_dropdown`, `selectify_dropdown_tags`,
  `selectify_dropdown_searchable`, `selectify_dropdown_checkbox`, `selectify_dual`. Field types:
  `list_string`, `list_integer`, `list_float`, `entity_reference`.
- **Integration "widget" values** (the strings stored in config for Views/Form API/Webform — DISTINCT
  from the field-widget ids above): `selectify_dropdown`, `selectify_tags`, `selectify_searchable`,
  `selectify_checkbox`, `selectify_dual`. Each maps to CSS class `selectify-apply-{dropdown|tags|
  searchable|checkbox|dual}` and to libraries via `SelectifyHelper::getWidgetLibraries()`.
- Theme hooks (base hook `select`, templates in `templates/`): `select__selectify_dropdown`,
  `select__selectify_dropdown_checkbox`, `select__selectify_dropdown_searchable`,
  `select__selectify_dropdown_tags`, `select__selectify_dual`.
- Alter hooks provided (`selectify.api.php`): `hook_selectify_widget_alter`,
  `hook_selectify_element_alter`, `hook_selectify_is_applicable_alter`.
- Marker classes an integration adds to a select: `selectify-apply-*`, plus `selectify-form-api`
  (Form API), `selectify-views`/`selectify-views-form` (Views), `selectify-webform` (Webform);
  wrapper gets `selectify-single`/`selectify-multi`.
- Libraries (`selectify.libraries.yml`): `selectify/selectify-base`, `-helper`, `-dropdowns`,
  `-dropdown`, `-dropdown-checkbox`, `-dropdown-searchable`, `-dropdown-tags`, `-dual`,
  `-radio-checkbox`, `-settings-style`; accent `selectify/selectify-color-{blue|coral|gold|indigo|
  neutral|slate|teal}-{light|dark}`; theme `selectify/selectify-{gin-base|gin-dark|gin-light|gin-auto|
  claro|olivero}`.
- Submodule `selectify_webform`: `hook_webform_element_alter` + `hook_form_alter` style
  `webform_submission_*` selects (including composites `webform_select_other`, `webform_entity_select`,
  `webform_term_select`, `webform_likert`, `webform_mapping`, `webform_tableselect`,
  `webform_composite`); its own config `selectify_webform.settings`; UI merged into the parent settings
  form when enabled. No separate settings route (reuses `selectify.settings_form`).
