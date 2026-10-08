<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
International Personal Documentation Validator (ipd_validator) provides a generic, plugin-based PHP API for validating national identity documents across many countries.

---

The module ships no UI, routes, permissions, or config; it is a pure developer API. Each supported country is a `@Validator`-annotated plugin under `src/Plugin/Validator/` (Argentina CUIT/CUIL, Brazil CPF/CNPJ, Chile RUT, Colombia, India PAN, Nigeria NIN, Japan My Number, Egypt, Ghana, Kenya, Mexico CURP, Malaysia NRIC, and ~25 more). Plugins implement `ValidatorInterface` (`isValid()`, `format()`, `countryCode()`, `country()`, `label()`, `isActive()`) via `ValidatorPluginBase`. Discovery and instantiation go through the `plugin.manager.ipd_validator` service (`ValidatorPluginManager`).

You use it from your own code — a form constraint, a REST resource, or an integration — by loading the manager, creating the plugin for a country code, and calling `isValid($document)`. Because validators are plugins, you can add a new country in your own module without patching this one. There are no external calls, no persistence, and no security-sensitive surface: all validation is local string/checksum logic.

---
- Validate an Argentine CUIT/CUIL check digit server-side.
- Validate a Brazilian CPF or CNPJ before saving a profile.
- Validate a Chilean RUT in a registration form.
- Validate an Indian PAN format in an integration handler.
- Validate a Nigerian NIN or Kenyan national ID.
- Validate a Japanese My Number checksum.
- Validate a Mexican CURP string.
- Validate a Malaysian NRIC.
- Normalise/format a raw document string via `format()`.
- Get a validator's human-readable country name and label.
- List which country validators are active via `isActive()`.
- Look up the correct validator by ISO country code.
- Add a custom validator plugin for an unsupported country.
- Reuse the plugin manager in a custom Form API `#element_validate` callback.
- Wrap the validator in a REST/JSON-RPC resource for headless clients.
- Enforce document validity in a webform submit handler.
- Batch-validate imported records during a migration.
- Guard a Commerce checkout with country-specific ID validation.
- Unit-test country logic with the module's bundled tests as a reference.
- Centralise document-format rules across multiple custom modules.
