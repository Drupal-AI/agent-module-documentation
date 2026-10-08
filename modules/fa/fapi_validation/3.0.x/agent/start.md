<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FAPI Validation (fapi_validation) — agent index

A **declarative validation + filtering layer for Drupal's Form API**. Developers attach reusable named rules to
a form element with `#validators` and `#filters` instead of writing `#element_validate` callbacks. Package
`Development`. License GPL-2.0-or-later. Version 3.0.0. Core `^10.3 || ^11`. No module or Composer dependencies.

## How it wires in (from source)

- `fapi_validation.module` → `hook_element_info_alter` appends `\Drupal\fapi_validation\FapiValidationService::process`
  to `#process` of every element whose type is `#input`.
- `FapiValidationService::process` (src/FapiValidationService.php): if the element has `#filters`, prepends
  `FapiValidationService::filter` to `#element_validate`; if it has `#validators`, appends
  `FapiValidationService::validate`. Filters run before validators.
- Those two static methods delegate to the plugin managers `plugin.manager.fapi_validation_filters` and
  `plugin.manager.fapi_validation_validators`.

## Plugin types it provides

- **FapiValidationValidator** — validator plugins in `Plugin/FapiValidationValidator` (attribute
  `Drupal\fapi_validation\Attribute\FapiValidationValidator`, legacy annotation also supported), interface
  `FapiValidationValidatorsInterface::validate()`. → [plugins/validators.md](plugins/validators.md)
- **FapiValidationFilter** — filter plugins in `Plugin/FapiValidationFilter` (attribute
  `Drupal\fapi_validation\Attribute\FapiValidationFilter`), interface `FapiValidationFiltersInterface::filter()`.
  → [plugins/filters.md](plugins/filters.md)

## Rule syntax, engine, and custom plugins

`Validator` (src/Validator.php) parses each rule; the managers run it. Rule forms, parsing, the bypass mechanism,
and how to write your own validator/filter → [api/rules-and-engine.md](api/rules-and-engine.md).

## Config, routes, permissions

Settings form + `fapi_validation.settings` config + schema, the two read-only plugin-listing controllers, four
static permissions plus dynamic per-validator permissions → [config/settings.md](config/settings.md).

## Services (fapi_validation.services.yml)

- `plugin.manager.fapi_validation_validators` — `FapiValidationValidatorsManager` (extends `default_plugin_manager`;
  extra args `@config.factory`, `@current_user`).
- `plugin.manager.fapi_validation_filters` — `FapiValidationFiltersManager` (extends `default_plugin_manager`).

## Submodule

- `fapiv_example` — demo form at `/fapi-example` + a custom `custom_validator` plugin. Documented at
  `../../modules/fapiv_example/3.0.x/`.

## Not provided

No entities, no fields/formatters, no Drush, no HTTP/external calls, no libraries. `dependent_modules` is empty.
