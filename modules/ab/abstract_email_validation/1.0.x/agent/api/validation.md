<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Validation pipeline

Three services (`abstract_email_validation.services.yml`) plus a constraint and a form callback.

## `Http\AbstractApi` (service `abstract_email_validation.api`)

- Ctor args: `@http_client`, `@config.factory`, `@logger.factory` (channel `abstract_email_validation`).
- `callAbstractApi(string $email): array` — reads `api_url` + `api_key` from
  `abstract_email_validation.settings`, then `httpClient->request('GET', $api_base_url, ['query' =>
  ['api_key' => $api_key, 'email' => $email]])`. Returns `['status_code' => int, 'data' => array]`
  (from `Json::decode($response->getBody())`). On exception: sets `status_code` to the exception code
  and logs `API Request failed: @message`. Uses Guzzle defaults (TLS verification on).

## `Validate\EmailValidator` (service `abstract_email_validation.validator`)

- Ctor args: `@config.factory`, `@logger.factory`, `@abstract_email_validation.api`.
- `validate(string $email): array` returns `['status' => bool, 'message' => ?TranslatableMarkup]`:
  1. If the email blacklist is on, non-empty, and `checkBlacklistEmail($email)` matches → `status = FALSE`,
     message *"This email is banned for the site…"*.
  2. Else if the domain blacklist is on, non-empty, and `checkBlacklistDomain($email)` matches → `status
     = FALSE`, *"This domain is banned…"*. (Blacklist runs **before** any API call.)
  3. Else `callAbstractApi($email)`; if `status_code == 200`, `status = detailedValidation(...)`,
     otherwise `status = FALSE` with *"Unable to verify email…"*.
- `detailedValidation(array $detailed_settings, array $data): bool` —
  - detailed mode **on**: start TRUE, AND-in each enabled check (`getSmtpStatus` →
    `data.is_smtp_valid.value`, `getMxFoundStatus` → `data.is_mx_found.value`, `getDeliverabilityStatus`
    → `data.deliverability`, `getQualityScoreStatus` → `data.quality_score >= threshold`).
  - detailed mode **off** (default rule): TRUE only if `is_smtp_valid` AND `deliverability` AND
    `quality_score >= 0.8`.
- Blacklist helpers `checkBlacklistEmail` / `checkBlacklistDomain` explode the comma lists and compare
  `trim(strtolower(...))`; `extractDomain` splits on `@` and returns `$parts[1] ?? ''`.

Behavioral caveat (not security): `getDeliverabilityStatus()` returns the raw `deliverability` string
and is used in a boolean AND — any non-empty status (including `UNDELIVERABLE`) is truthy, so the
deliverability check passes for any populated value rather than only `DELIVERABLE`.

## Constraint `AbstractEmailValidation`

- `Plugin/Validation/Constraint/AbstractEmailValidationConstraint` (id `AbstractEmailValidation`,
  message `%message`). Validator `AbstractEmailValidationConstraintValidator` (service
  `abstract_email_validation.constraint_validator`, tag `validator.constraint_validator`,
  alias `AbstractEmailValidation`; ctor `@abstract_email_validation.validator`, `@config.factory`).
- `validate($value, $constraint)`: for each field item, calls `EmailValidator::validate($field_value['value'])`;
  on `status === FALSE` adds a violation — either the returned `message`, or `t($custom_error_message,
  ['%email' => ...])`. Attached to fields by `hook_entity_bundle_field_info_alter` when the field's
  `abstract_email_validation` third-party setting is set (node/user/paragraph/taxonomy/menu/media only).

## Form callback (webform / custom / user forms)

`abstract_email_validation_custom_form_validate($element, $form_state, &$form)` in the `.module` file:
resolves `abstract_email_validation.validator`, reads the submitted value by `$element['#name']`, calls
`validate()`, and on failure `setErrorByName()` with the returned message or the `%email`-substituted
custom message. Wired in by `hook_form_alter` / `hook_webform_element_alter` (see config/settings.md).

## Operating notes

- Every validated submission makes **one Abstract API call per email value** (blacklist hits skip it) —
  factor in Abstract quota/latency on high-traffic forms.
- A non-200 / API error fails **closed** (address rejected with the "unable to verify" message).
- The `%email` placeholder is escaped by core's `t()` placeholder handling; `custom_error_message` is
  admin-set (config, `administer site configuration`).
