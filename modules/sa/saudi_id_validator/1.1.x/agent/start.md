<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Saudi ID Validator — agent index

**Offline Saudi National ID / Iqama validation** (format, type, checksum) via a reusable service + Form API `#element_validate` validator + entity `SaudiId` constraint. Version **1.1.0**. Core `^10.3 || ^11 || ^12`, PHP `>= 8.3`. Package `Validation`. Not covered by Drupal's security advisory policy.

Entirely local: no registry is contacted, no HTTP request is made, no database is read. A number that passes is *well formed*, not proven to belong to a real person.

## The three rules (in order, cheapest first)

1. **Format** — exactly ten ASCII digits (`/^\d{10}$/`). Arabic-Indic digits, zero-width chars and non-breaking spaces fail here rather than being folded to ASCII. Surrounding whitespace is trimmed; whitespace inside the number is not.
2. **Type** — leading digit: `1` = National ID (`SAUDI_NATIONAL_ID`), `2` = Iqama (`IQAMA`); anything else fails.
3. **Checksum** — the official Luhn check digit (odd positions doubled, total ≡ 0 mod 10).

No setting relaxes any rule.

## Public API (`@api`, stable since 1.0.0)

- `SaudiIdValidatorInterface` — inject this (alias `@saudi_id_validator.validator`). Methods: `isValid()`, `detectType(): ?IdType`, `isSaudiCitizen()`, `isResident()`, `getMetadata(): IdMetadata`.
- `IdMetadata` — immutable verdict: `->valid`, `->type`, `->reason`, `->normalised`, `firstDigit()`, `toArray()`.
- `IdType` enum (`SaudiNationalId`, `Iqama`) — `leadingDigit()`, `label()`, `fromLeadingDigit()`.
- `FailureReason` enum (`NotTenDigits`, `UnknownLeadingDigit`, `ChecksumFailed`) — each carries its own translated `message()`. May gain cases in a minor; `match()` should keep a default arm.
- `Checksum\LuhnChecksum` — `isValid()`, `checkDigit()`, `const LENGTH = 10`.
- `Validator\SaudiIdElementValidator::validate($element, $form_state)` — static Form API callback.
- `Plugin\Validation\Constraint\SaudiIdConstraint` — attach as `->addConstraint('SaudiId')`; option `requireType` (an `IdType` case value) restricts to one type; `wrongTypeMessage` is the wrong-type message.
- `Event\SaudiIdValidatedEvent` / `SaudiIdValidationFailedEvent` — dispatched once per public call, carrying `originalValue` + `metadata`. Observe only; cannot change the verdict.
- `ValidatorSettings` — typed read access to config (alias `@saudi_id_validator.settings`).

`SaudiIdValidator`, `SaudiIdConstraintValidator`, `SettingsForm` are `@internal` adapters — do not reference directly; inject the interface / attach the constraint.

## Config & routing

- Config object `saudi_id_validator.settings` (schema provided): `automatic_validation` (bool, default TRUE), `field_names` (sequence, default `national_id`, `saudi_id`, `identity_number`, `iqama`, `id_number`), `show_detected_type` (bool, default FALSE).
- Settings form at `/admin/config/system/saudi-id-validator` (route `saudi_id_validator.settings`), gated by permission **`administer saudi id validator`** (`restrict access: true`).
- `hook_form_alter` attaches the element validator to any `textfield`/`number`/`tel`/`search` element whose key matches a watched machine name — only when `automatic_validation` is on. It only *adds* validation, never removes it; a form that attaches the validator or constraint itself is always validated.

## Diff 1.0.x → 1.1.x

- **Drupal 12 compatibility** — `core_version_requirement` widened from `^10.3 || ^11` to `^10.3 || ^11 || ^12`; the Composer `drupal/core` / `drupal/core-dev` dev constraints accept `^12` too.
- **Metadata only.** No code, behaviour or public-API change. Per the module's CHANGELOG, D12 and D10.3 compatibility is established by static analysis; runtime validation was on Drupal 11.4.4.
- (1.0.1, folded in: a PHPStan docblock-only fix to the element validator's by-reference `$element` param — no functional change.)

See [usage.md](../usage.md) for how to wire it in.
