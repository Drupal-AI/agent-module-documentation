<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Citation Reference Field (citeref_field) — agent index

A **field type** that stores a citation/reference identified by **DOI, Handle, ARK, URL, URN
(ISSN/ISBN) or Other**, with an AJAX widget that validates/fetches a formatted citation from the
matching public API. Package `general`. Core `^10 || ^11`. License GPL-2.0-or-later. Version
`1.1.0-beta1`. No composer or contrib-module dependencies declared (uses core `field`).

## What it provides (all in `src/`)

- **Field type** `citeref_field` — `Plugin/Field/FieldType/CiterefFieldItem.php`. Four varchar
  columns: `citeref_type` (10), `citeref_style` (255), `citeref_id` (255), `citeref_record`
  (2048). `default_widget = citeref_field_widget`, `default_formatter = citeref_field_default`.
- **Widget** `citeref_field_widget` — `Plugin/Field/FieldWidget/CiterefFieldWidget.php`. Type
  `select` + ID/style/text fields; AJAX callbacks call the DOI/Handle/ARK/URL/ISSN/ISBN services
  (Guzzle `http_client`). → [fields/widget.md](fields/widget.md)
- **Formatters**: `citeref_field_default` (`CiterefFieldDefaultFormatter`, "Default") and
  `configurable_citeref_field_formatter` (`ConfigurableCiterefFieldFormatter`, "Citation or
  Reference Field"). Templates in `templates/`. → [fields/formatters.md](fields/formatters.md)
- **Settings form** `CiterefFieldSettingsForm` at route `citeref_field.admin_settings`
  (`/admin/config/content/citeref_field`, perm `administer citeref_field`); writes config object
  `citeref_field.settings`. → [config/settings.md](config/settings.md)
- **Uninstall cleanup**: service `citeref_field.uninstall_validator`
  (`CiterefFieldUninstallValidator`, tagged `module_install.uninstall_validator`) + form
  `CiterefFieldUninstallValidatorForm` at `/admin/modules/uninstall/entity/citeref_field`.
  → [config/uninstall.md](config/uninstall.md)
- **Controller** `CiterefFieldController::handleAutocomplete` at route
  `citeref_field.autocomplete` (`/autocomplete/citeref_field`, `_user_is_logged_in: TRUE`) —
  CSL style-name autocomplete from bundled `csl_styles/csl_styles.txt`.

## Routes

| Route | Path | Access |
|---|---|---|
| `citeref_field.admin_settings` | `/admin/config/content/citeref_field` | `administer citeref_field` |
| `citeref_field.autocomplete` | `/autocomplete/citeref_field` | logged-in |
| `citeref_field.uninstall_settings` | `/admin/modules/uninstall/entity/citeref_field` | `administer citeref_field` |

## Permission

- `administer citeref_field` (`restrict access: true`) — gates the settings + uninstall forms.

## Hooks / config / libraries

- `citeref_field.module`: `hook_help`, `hook_theme` (two theme hooks matching the two
  formatters), `hook_form_alter` (relabels the uninstall submit button).
- Config: install default `config/install/citeref_field.settings.yml` (endpoint base URLs). **No
  `config/schema/`** ships.
- Libraries (`citeref_field.libraries.yml`): `citeref_field_twig_default` (CSS) and
  `citeref_field_ui_default` (JS `js/citereffield.ui.default.js`, depends on core jquery/once/
  drupal/drupalSettings — provides the debounced-input event for the ID field).

See [usage.md](../usage.md) for use cases.
