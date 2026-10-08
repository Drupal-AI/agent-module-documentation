<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Validator plugins (FapiValidationValidator)

Plugin type discovered from `Plugin/FapiValidationValidator` in any module. Attribute:
`Drupal\fapi_validation\Attribute\FapiValidationValidator` (`id`, optional `label`, `description`,
`error_message`, `error_callback`, `deriver`); legacy annotation `Drupal\fapi_validation\Annotation\FapiValidationValidator`
also supported. Interface: `FapiValidationValidatorsInterface::validate(Validator $validator, array $element, FormStateInterface $form_state): bool`
— return TRUE to pass, FALSE to fail. Manager: `FapiValidationValidatorsManager`. See rule syntax and the engine
in [../api/rules-and-engine.md](../api/rules-and-engine.md).

## Bundled validators (src/Plugin/FapiValidationValidator/)

| id | rule usage | behaviour (from source) |
|----|-----------|-------------------------|
| `numeric` | `numeric` | value is numeric. |
| `alpha` | `alpha` | `preg_match('/^[\pL]++$/uD')` — Unicode letters only. |
| `alpha_numeric` | `alpha_numeric` | letters and digits only. |
| `alpha_dash` | `alpha_dash` | letters and dash (`-`) only. |
| `digit` | `digit` | digits only (no dots/dashes). |
| `decimal` | `decimal`, `decimal[<int>,<dec>]` | with 2 params, `/^[0-9]{int}\.[0-9]{dec}$/`; else `filter_var(FILTER_VALIDATE_FLOAT)`. |
| `limit_decimals` | `limit_decimals[<n>]` | numeric with at most `n` decimal places. |
| `length` | `length[<n>]`, `length[<min>, <max>]`, `length[<min>, *]` | `mb_strlen` compared to exact / range / min-only. |
| `chars` | `chars[<c1>, <c2>, ...]` | every character must be in the allow-list. |
| `email` | `email` | via `fapi_validation_validate_email()` → core `email.validator` service. |
| `url` | `url`, `url[absolute]` | `UrlHelper::isValid()`; `absolute` requires a full URL. |
| `ipv4` | `ipv4` | dotted-quad IPv4 regex. |
| `regexp` | `regexp[/^pattern$/]` | `preg_match($params[0], $value)`; array values imploded first. |
| `match_field` | `match_field[otherfield]` | equals `$form_state->getValue('otherfield')`. |
| `range` | `range[<min>, <max>]` | `min <= value && max >= value`. |

Notes: `regexp`'s pattern is the developer-authored rule string from the form definition (parsed as a single
param, delimiters included). `match_field` currently supports only a top-level sibling field key (see the `@todo`
in `MatchFieldValidator` about nested elements).

## Default vs. overridden error messages

Each plugin's attribute carries an `error_message` (e.g. `AlphaValidator` → `'Use only alpha characters at %field.'`)
or an `error_callback`. A form can override per element with a `'error'` string or `'error callback'` in the
array rule form; precedence is documented in [../api/rules-and-engine.md](../api/rules-and-engine.md). `%field`
resolves to the element `#title`.

## Adding your own

Create `src/Plugin/FapiValidationValidator/YourValidator.php` implementing `FapiValidationValidatorsInterface`
with the attribute, then use its `id` in `#validators`. Full example in
[../api/rules-and-engine.md](../api/rules-and-engine.md); a live one ships in the `fapiv_example` submodule
(`custom_validator`).
