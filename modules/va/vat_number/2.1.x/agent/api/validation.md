# Validation mechanism — `VatNumberController`

All validation lives in `src/Controller/VatNumberController.php`. Despite the `Controller`
namespace/name it is **not a route controller** and is wired to no route — it is a plain helper
instantiated with `new VatNumberController($vatNumber)` from the render element and (indirectly) the
widget/Webform element.

## Public API

```php
public function __construct($vatNumber);        // stores input, calls getComponents()
public function check(
  bool $validate_vies = TRUE,
  bool $fail_if_vies_unavailable = TRUE
): array;                                        // ['status' => bool, 'message' => TranslatableMarkup|null]
public function euCountries(): array;            // country_code => human name (via country_manager)
```

Callers pass explicit flags; the callers in this module (`Element\VatNumber`, `webform_vat_number`)
default both flags to **FALSE**, even though `check()`'s own defaults are TRUE.

`check()` (VatNumberController.php:50) runs the format check first, and only calls VIES when the
format check produced no error message **and** `$validate_vies` is TRUE:

```php
$this->checkVatFormat();
if (!isset($this->vatInfo['message'])) {
  $this->vatInfo['message'] = $validate_vies
    ? $this->validateVatNumber($fail_if_vies_unavailable)
    : NULL;
}
return ['status' => $this->valid, 'message' => $this->vatInfo['message']];
```

## Tier 1 — offline format check

- `getComponents()` (VatNumberController.php:134): `preg_replace('/[ .-]/', '', $vatNumber)` strips
  spaces, dots and dashes; the first two characters become `country_code` (upper-cased), the rest
  become `vatNumber` (upper-cased).
- `checkVatFormat()` (VatNumberController.php:151): a big `switch` on `country_code` selects a
  per-country regex and example. Supported prefixes (case labels): `AT BE BG CY CZ DK EE DE EL PT FR
  FI HR HU LU MT SI IE IT LV LT NL PL SK RO SE ES GB`. An unrecognised prefix sets `valid = FALSE`
  and a "country … can not be detected" message. When the prefix is a listed EU country
  (`euCountries()`) but the regex does not match, it sets `valid = FALSE` with a "does not match the
  '%country' VAT format" message.
- The per-country regexes allow the country prefix to be optional (`(XX){0,1}`), so the value is
  re-assembled as `country_code . vatNumber` before matching.

Quirks worth knowing (not security issues, but they affect which inputs pass):
- Greece: the `switch` case is `EL`, but `euCountries()` lists `GR` (not `EL`). So a `GR…` number
  hits the `default` (unknown country) branch, and an `EL…` number is regex-checked but is treated as
  non-EU for the "format mismatch" message.
- Croatia: the `HR` case reuses Hungary's `$example['HU']` text (copy/paste), so the example message
  shown for a bad HR number is mislabelled.
- `GB` (United Kingdom) is still in both the `switch` and `euCountries()`, so GB numbers pass the
  offline check — but the UK left the EU VAT system, so a GB number sent to VIES will not validate.

## Tier 2 — VIES (SOAP)

`validateVatNumber()` (VatNumberController.php:75):

1. If `class_exists('SoapClient')` is false → sets `valid = FALSE`, logs an error, returns the
   generic "could not connect" message. (The `ext-soap` requirement is also enforced at install by
   `vat_number_requirements()` in `vat_number.install`.)
2. Otherwise builds
   `new \SoapClient('http://ec.europa.eu/taxation_customs/vies/checkVatService.wsdl', ['exceptions' => 1])`
   and calls `checkVat(['countryCode' => …, 'vatNumber' => …])`. The country code and number come
   from `getComponents()` and are passed as **structured SOAP parameters** — the SOAP extension
   XML-encodes them, so user input is not concatenated into a raw XML/SOAP string. No timeout is set.
3. If `$response->valid` is false → `valid = FALSE`, "not registered to trade cross-border" message.
4. On `\SoapFault`:
   - `faultstring === 'INVALID_INPUT'` → `valid = FALSE` (treated as an invalid number).
   - any other fault (SERVICE_UNAVAILABLE, MS_UNAVAILABLE, TIMEOUT, SERVER_BUSY, …) → logged, then
     **`$this->valid = !$fail_if_vies_unavailable;`** and the generic "could not connect" message is
     returned.

### `fail_if_vies_unavailable` behaviour

Because both the widget and the Webform element default `fail_if_vies_unavailable` to `FALSE`, a VIES
outage or transport error (anything except an explicit `INVALID_INPUT`) leaves `valid = TRUE`, i.e.
the number passes when VIES could not confirm it. Enabling the setting flips this so an outage makes
validation fail. This is the module's documented default ("Fail validation if the VIES search engine
is unavailable" is opt-in); treat the VIES tier as a best-effort data-quality aid whose result
depends on the remote service being reachable.

## Return shape and message HTML

`message` is a `TranslatableMarkup` (or `NULL`). Some messages contain intentional markup
(`<strong>`, `<br />`) built from translated strings with placeholders (`%country`, `%format`), so
the output is safe placeholder-escaped markup, not raw user input.
