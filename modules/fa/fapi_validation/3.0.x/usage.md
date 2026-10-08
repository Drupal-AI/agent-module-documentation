<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Declarative Form API validation and filtering: attach reusable named validator and filter rules to any form element with `#validators` and `#filters` instead of hand-writing `#element_validate` callbacks.

---

FAPI Validation extends Drupal's Form API so a developer can validate and filter form input by declaring rules on an element rather than writing custom validation functions. `hook_element_info_alter` adds `FapiValidationService::process` to every input element; when the element carries a `#filters` and/or `#validators` array, that process callback wires `FapiValidationService::filter` and `FapiValidationService::validate` into the element's `#element_validate`. Validation is powered by two Drupal plugin types: `FapiValidationValidator` plugins (numeric, alpha, alpha_numeric, alpha_dash, digit, decimal, limit_decimals, length, chars, email, url, ipv4, regexp, match_field, range) each return pass/fail with a default or overridable error message, and `FapiValidationFilter` plugins (numeric, trim, ltrim, rtrim, machine_name, ucfirst, ucwords, uppercase, lowercase, strip_tags, html_entities) transform the submitted value. A rule is a plain id (`email`), an id with bracketed parameters (`length[10, 50]`, `range[0, 100]`, `regexp[/^.../]`), or an array with a `rule` key plus a per-rule `error` message or `error callback`. Any module can register its own validator or filter by adding a plugin class under `Plugin/FapiValidationValidator` or `Plugin/FapiValidationFilter`. An admin settings page (`/admin/config/system/fapi`) exposes a bypass flag and two read-only pages list all registered validator and filter plugins. The project ships an example submodule (`fapiv_example`) with a demo form and a custom validator.

---

- Require an email address on a form element with `#validators => ['email']` instead of writing a validate callback.
- Enforce a minimum and maximum length with `#validators => ['length[10, 50]']`.
- Enforce an exact length (e.g. a 7-character code) with `length[7]`, or a minimum-only length with `length[5, *]`.
- Constrain a numeric field to a range with `range[0, 100]`.
- Validate an IPv4 address field with `#validators => ['ipv4']`.
- Require an absolute URL with `url[absolute]`, or accept any valid URL with `url`.
- Restrict input to alphabetic characters (`alpha`), alphanumeric (`alpha_numeric`), or alpha plus dash (`alpha_dash`).
- Allow only digits with `digit`, or validate decimals with `decimal` / `decimal[<int>,<dec>]`.
- Cap the number of decimal places with `limit_decimals[<n>]`.
- Restrict a field to an explicit character allow-list with `chars[a, b, c]`.
- Confirm two fields match (e.g. password / confirm) with `match_field[otherfield]`.
- Validate against an arbitrary developer-supplied PCRE pattern with `regexp[/^pattern$/]`.
- Trim surrounding whitespace before validation with `#filters => ['trim']` (or `ltrim` / `rtrim`).
- Force a value to uppercase or lowercase on submit with the `uppercase` / `lowercase` filters.
- Normalise a label into a machine name automatically with the `machine_name` filter.
- Strip out numeric characters, HTML tags, or normalise HTML entities with the `numeric`, `strip_tags`, and `html_entities` filters.
- Capitalise the first letter (`ucfirst`) or every word (`ucwords`) of a submitted value.
- Override a rule's default message per element with `['rule' => 'alpha_numeric', 'error' => 'Custom message for %field.']`.
- Generate an error message dynamically with `['rule' => '...', 'error callback' => 'my_callback']`.
- Register a project-specific reusable validator by adding a class under `Plugin/FapiValidationValidator`.
- Register a project-specific reusable filter by adding a class under `Plugin/FapiValidationFilter`.
- Review every validator or filter plugin registered on the site from `/admin/config/system/fapi/validations` and `/admin/config/system/fapi/filters`.
- Grant trusted roles the ability to bypass validation for staging/admin workflows via the bypass permission and settings flag.
- Combine filters and validators on one element (e.g. `trim` + `uppercase`, then `length` + `alpha`) so input is normalised before it is checked.
- Study the shipped `fapiv_example` submodule's `/fapi-example` form as a working reference for the rule syntax.
