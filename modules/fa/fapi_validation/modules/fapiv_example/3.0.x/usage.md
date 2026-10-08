<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Example submodule of FAPI Validation providing a working demo form at `/fapi-example` and a custom validator plugin that shows how to attach `#validators`/`#filters` and register your own rule.

---

`fapiv_example` is the reference/example submodule bundled in the FAPI Validation project. Enabling it exposes one route, `fapiv_example.simple_form` at `/fapi-example` (permission `fapiv access example page`), served by `Drupal\fapiv_example\Form\SimpleForm`. That form demonstrates the parent module's declarative rule syntax across several fields — a title using `length[5, *]` with `uppercase`/`trim` filters, a name combining an array rule (`length[7]` with a custom `error`) and the submodule's own `custom_validator`, plus email, `range[0, 100]`, `ipv4`, and `url[absolute]` fields. The submodule also ships `Drupal\fapiv_example\Plugin\FapiValidationValidator\MyCustomValidator` (id `custom_validator`), which passes only when the value equals `JohnDoe` and generates its error message through a public static `processError` callback declared via the attribute's `error_callback`. It depends on `fapi_validation`, defines only the example-page permission, and owns no config. It is meant to be read as a copy-paste starting point, not run in production.

---

- Enable `fapiv_example` to see FAPI Validation working end to end at `/fapi-example`.
- Study a real `#validators` array mixing plain ids, bracketed-parameter rules, and array rules with a custom `error`.
- See how `#filters` (`uppercase`, `trim`) run before validators on the same element.
- Copy the `length[5, *]` (minimum-only length) pattern for your own fields.
- Copy the `length[7]` exact-length rule with a per-element custom error message.
- See `email`, `range[0, 100]`, `ipv4`, and `url[absolute]` validators applied to text fields.
- Use `MyCustomValidator` as a template for writing a custom `FapiValidationValidator` plugin.
- Learn the `error_callback` pattern (a public static `processError(Validator, array $element)` returning a message).
- Grant `fapiv access example page` to a role to let it reach the demo form.
- Reference the demo when onboarding developers to the FAPI Validation rule syntax.
- Verify a fresh FAPI Validation install works by submitting valid and invalid values on the example form.
- Remove/disable the submodule once its patterns have been copied into your own module.
