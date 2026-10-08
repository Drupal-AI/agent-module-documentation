<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Constraints and how they attach

All plugins live in `src/Plugin/Validation/Constraint/` and extend `EmailConstraintBase`
(`extends Symfony\Component\Validator\Constraint`) which holds public `$title` / `$description`, a
`getSettingsForm()` (default `[]`), and `getKey()` (returns the short class name, e.g.
`GoogleEmailConstraint`). Each concrete constraint has a matching `<Name>Validator` (a
`ConstraintValidator`) whose `validate($value, $constraint)` reads the email via
`$value->getString()` and, on failure, calls a private `violation($message)` that does
`$this->context->buildViolation($message)->atPath('mail')->addViolation()`.

## Attachment (`email_validate.module`)

`email_validate_entity_base_field_info_alter()` runs only for the `user` entity when
`$fields['mail']` exists. It loads `email_validate.settings` via `config.factory` `getRawData()` and,
for every constraint whose `enable` is non-empty, calls `$fields['mail']->addConstraint($constraint)`
using the constraint plugin id as the key. Constraints therefore validate the account `mail` base
field everywhere it is validated (registration, admin user add/edit, `$account->get('mail')->validate()`).
Toggling settings requires a container/plugin-cache rebuild — the settings form does that on save
(see [../config/settings.md](../config/settings.md)).

## GoogleEmailConstraint / GoogleEmailConstraintValidator

- id `GoogleEmailConstraint`, title "Google emails constraints". Only acts when the domain is
  `gmail.com` or `googlemail.com` (`isGoogleDomainEmail()`).
- `validateDots()`: strips all `.` from the local part, appends `@domain`, and runs
  `\Drupal::entityQuery('user')->accessCheck(FALSE)->condition('mail', $duplicate_mail)`; if a match
  exists it raises `dotsDuplicationError`.
- `validatePlus()`: takes the local part before the first `+`, re-forms the address, same existence
  query; match → `plusDuplicationError`. Blocks alias synonyms of an already-registered Gmail address.

## YandexEmailConstraint / YandexEmailConstraintValidator

- id `YandexEmailConstraint`, title "Yandex emails constraints". Acts only when the domain is in the
  24-entry `YandexEmailConstraint::DOMAINS` const (yandex.com/.ru/.by/…, ya.ru, narod.ru, …).
- `validateDotsAndDashes()`: swaps `-`↔`.` in the local part, queries for that variant; match →
  `dotsAndDashesDuplicationError`.
- `validateDomainDuplication()`: builds the same local part across every Yandex domain (minus the
  current address) and does an `IN` existence query; match → `domainDuplicationError`.

## BlockEmailDomainConstraint / BlockEmailDomainConstraintValidator

- id `BlockEmailDomainConstraint`, title "Email domains block list". Adds a `block_domains` textarea
  (`getSettingsForm()`).
- Validator reads `block_domains` from config, splits it on `\r\n` (`getBlockedDomainList()`), and if
  the address domain is `in_array()` the list, raises `error` ("Emails with this domain are not
  permitted!"). Purely local, no network.

## DomainMxRecordConstraint / DomainMxRecordConstraintValidator

- id `DomainMxRecordConstraint`, title "Domain MX record constraint", no extra settings.
- Validator: `checkdnsrr(idn_to_ascii($mail_domain, 0, INTL_IDNA_VARIANT_UTS46), 'MX')`. If no MX
  record resolves it raises `error` ("E-mail domain name is not recognised!"). This performs a live
  DNS lookup on the submitted domain at validation time.

## TemporaryEmailConstraint / TemporaryEmailConstraintValidator

- id `TemporaryEmailConstraint`, title "Temporary emails constraints". `getSettingsForm()` adds
  `api_key` (textfield) and `api_url` (default
  `https://block-temporary-email.com/check/email/{email}`; supports `{email}` and `{api_key}` tokens).
- Validator only runs when both `api_key` and `api_url` are set. It token-replaces `{email}` and
  `{api_key}` into the URL, then does a Guzzle `new Client()` `->get($uri, [... 'headers' =>
  ['x-api-key' => $api_key]])`, `json_decode`s the body, and raises `error` ("Disposable e-mail
  address is not allowed.") only when `$data->temporary === TRUE`. On any `GuzzleException` it logs a
  warning and **returns TRUE (fail-open)** — a remote outage does not block registration.

## Developer / programmatic use

Validate any account's stored email directly:
`$violations = $account->get('mail')->validate();` — returns a `ConstraintViolationListInterface`
of whatever constraints are currently enabled. The bulk `UserValidationForm` uses exactly this.
