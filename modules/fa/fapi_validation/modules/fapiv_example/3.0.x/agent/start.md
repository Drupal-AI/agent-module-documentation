<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FAPI Validation Example Form (fapiv_example) — agent index

Example/reference submodule of **FAPI Validation**. Package `Development`. License GPL-2.0-or-later. Version 3.0.0.
Core `^10.3 || ^11`. Depends on `fapi_validation:fapi_validation`. Parent docs: `../../../3.0.x/agent/start.md`.

## What it provides (from source)

- **One route/form**: `fapiv_example.simple_form` → `/fapi-example`, `\Drupal\fapiv_example\Form\SimpleForm`
  (extends `FormBase`), permission `fapiv access example page`. Configure link + menu link
  (`fapiv_example.links.menu.yml`). → [forms/simple-form.md](forms/simple-form.md)
- **One custom validator plugin**: `\Drupal\fapiv_example\Plugin\FapiValidationValidator\MyCustomValidator`
  (id `custom_validator`), attribute `error_callback: 'processError'`; `validate()` returns TRUE only when the
  value equals `JohnDoe`. → [forms/simple-form.md](forms/simple-form.md)
- **One permission** (`fapiv_example.permissions.yml`): `fapiv access example page`.

## Not provided

No config object/schema, no services, no additional plugins, no Drush. `.module` file is empty (docblock only).
It exists purely as a worked reference for the parent module's `#validators` / `#filters` API and custom-plugin
authoring (see parent [api/rules-and-engine.md](../../../3.0.x/agent/api/rules-and-engine.md)).
