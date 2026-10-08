<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Author Field (author_field) — agent index

A single composite **field type** `author_field` that stores researcher metadata keyed to an
**ORCID** identifier, with a widget that **autocompletes against the ORCID public API** and three
display formatters. Package `general`. Depends on the **`jquery_ui_tooltip`** module
(`drupal/jquery_ui_tooltip:^2.1`, for the affiliation tooltip). Core `^10 || ^11`. License
GPL-2.0-or-later. Version 1.1.0-beta1.

- **Field type, widget, autocomplete, formatters & templates** → [fields/field.md](fields/field.md)
- **Settings form, config object, routes, permission, uninstall helper** → [config/settings.md](config/settings.md)

## What it actually is (from source)

- **Field type** `author_field` — `src/Plugin/Field/FieldType/AuthorFieldItem.php`. Five string
  columns/properties: `family_name`, `given_name`, `email`, `orcid_id`, `organization_name`
  (varchar 255 each). `default_widget = author_field_widget`, `default_formatter = author_field_default`.
  It stores author data **inline on the host entity** — it is not an entity reference to a Drupal user.
- **Widget** `author_field_widget` — `src/Plugin/Field/FieldWidget/AuthorFieldWidget.php`. Renders a
  "Search" textfield (`#autocomplete_route_name: author_field.autocomplete`) plus the five sub-fields;
  its Ajax `orcidCallback()` re-queries the ORCID API for the picked ORCID and fills the sub-fields.
  Per-instance settings hide any sub-field (`hideGivenName`, `hideFamilyName`, `hideEmail`,
  `hideOrganizationName`, `hideNameIdentifier`).
- **Formatters** (all in `src/Plugin/Field/FieldFormatter/`):
  - `author_field_default` (`AuthorFieldDefaultFormatter`) → theme `author_field_default`: multi-author
    byline with affiliation superscripts + collapsible affiliation list.
  - `configurable_author_field_formatter` (`ConfigurableAuthorFieldFormatter`) → theme
    `configurable_author_field_formatter`: labels, ORCID link/icon, link target and `rel` options.
  - `author_field_name_formatter` (`AuthorFieldNameFormatter`) → theme `author_field_name_formatter`:
    name-only, optionally linked to ORCID.
- **Autocomplete controller** — `src/Controller/RestApiController.php::handleOrcidAutocomplete()`,
  route `author_field.autocomplete` (`_user_is_logged_in: TRUE`), proxies the ORCID public/sandbox
  `expanded-search` endpoint and returns JSON `{value, label}` rows.
- **Settings form** `AuthorFieldSettingsForm` at `/admin/config/content/author_field`
  (route `author_field.admin_settings`, permission `administer author_field`).
- **Uninstall helper**: `AuthorFieldUninstallValidator` (service `author_field.uninstall_validator`,
  tagged `module_install.uninstall_validator`) blocks uninstall while `author_field` field instances
  exist; `AuthorFieldUninstallValidatorForm` at `/admin/modules/uninstall/entity/author_field`
  deletes them and runs cron.

## Provides

- 1 field type, 1 widget, 3 field formatters, 3 Twig templates + 1 JS behavior (tooltip/toggle).
- Config object `author_field.settings` (install defaults only — **no config/schema**).
- Permission `administer author_field` (restrict access). No Drush. Hooks: `hook_help`,
  `hook_theme`, `hook_form_alter`.

## Notes

- All formatter output goes through Twig `{{ }}` auto-escaping (no `|raw`); field values are ordinary
  field data whose visibility follows core field/entity display access.
- The ORCID endpoint URLs are configurable but only by holders of `administer author_field`
  (restricted permission); the autocomplete route itself targets a fixed, config-set ORCID host.
