<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address verification

Source: `src/AddressVerification.php`,
`src/Plugin/Field/FieldWidget/SwissPostAddress.php`,
`src/Plugin/WebformHandler/AddressValidationHandler.php`.

Validates/corrects **CH and LI** postal addresses against Swiss Post's *Address Web Services*.
Independent of the shipping feature — works even without `commerce_shipping`.

## Service (`AddressVerification::verifyAddress`)

- Reads `aws_host`, `aws_username`, `aws_password`, `aws_log_level` from
  `commerce_swiss_post.settings`.
- If any of host/username/password is missing → logs an error and returns `TRUE` (address
  treated as valid).
- `extractStreetParts()` splits the street line into `StreetName` / `HouseNo` /
  `HouseNoAddition` (regex, handles number-before-street and no-number cases).
- GET `{aws_host}/buildingverification4` with query
  `StreetName, HouseNo, HouseNoAddition, ZipCode, TownName` and **HTTP Basic auth**
  (`auth => [aws_username, aws_password]`) on the shared `@http_client`.
- Parses `QueryBuildingVerification4Result`: requires `Status == 0`, then reads `PSTAT` from
  `BuildingVerificationData`.
  - `PSTAT` 1 → valid.
  - `PSTAT` 2–5 → valid but corrected; writes back `$corrected_address` (street/zip/town).
  - otherwise → invalid (returns `FALSE`).
- **Error handling (documented contract):** a `ServerException` or any `\Exception` is logged
  and the method returns `TRUE` (address treated as valid), so an API outage never blocks the
  form.

### Logging (`aws_log_level`)

`0` none (errors/exceptions still logged), `1` failures, `2` +corrections (logs original vs
corrected address), `3` +every check (logs the full JSON response). Higher levels write customer
address data to the log; keep at `0` in production unless debugging.

## Consumers

- **Field widget** `commerce_swiss_post_address` (extends `AddressDefaultWidget`). Adds an
  element-validate callback: only for `country_code` in `CH`/`LI`; on failure sets a form error;
  on success with a correction, rewrites the address form values.
- **Webform handler** `commerce_swiss_post_address_validation`. Admin maps the street /
  postal-code / town elements; `validateForm()` calls `verifyAddress()` and errors / rewrites
  values the same way.

### Double-submit override (both consumers, by design)

The last-rejected address is stored in `$_SESSION['commerce_swiss_post_previous_input']`. If the
next submission is identical, validation is skipped — an intentional UX feature so a customer
certain their address is correct can proceed (the form error explicitly instructs them to
re-submit the same data).
