<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce NZ — agent index

**New Zealand customisations for Drupal Commerce.** Version **2.2.0**. Core `^9 || ^10 || ^11`. Depends on `commerce:commerce_tax`.

Per its own README: *"Just a GST number validator for now."* The module is a placeholder home for NZ-specific Commerce features; today it ships exactly **one** thing — a New Zealand GST/IRD tax number type for Commerce Tax. No routes, controllers, services, permissions, config entities, config schema, forms, hooks (beyond `hook_help`), JS, or templates.

## What it actually contains

- `src/Plugin/Commerce/TaxNumberType/NewZealandGst.php` — a `@CommerceTaxNumberType` plugin extending `commerce_tax`'s `TaxNumberTypeBase`.
  - id `new_zealand_gst`, label `New Zealand GST`, `countries = {"NZ"}`, example `096-259-824`.
  - `validate($tax_number)` → canonicalizes (base-class strips non-alphanumerics), casts to int, runs `checkIrd()`.
  - `checkIrd(int $ird)` implements the NZ IRD number spec:
    - range gate: rejects `< 10000000` or `> 150000000`;
    - splits digits, pops the check digit, left-pads to 8 base digits;
    - primary weights `[3,2,7,6,5,4,3,2]`, weighted sum, check digit = `11 - (sum % 11)` (0 stays 0);
    - if primary check digit `== 10`, retries with secondary weights `[7,4,3,2,5,2,7,6]`;
    - returns TRUE on a matching check digit, else FALSE. (Uses base-10 modulo-11 IRD validation; local pure-PHP computation, no network calls.)
- `commerce_nz.module` — only `hook_help()` for `help.page.commerce_nz` (echoes the description).
- `tests/src/Functional/LoadTest.php` — smoke test: front page returns 200 with the module enabled.

## Usage

Enable the module; the **New Zealand GST** tax number type is then selectable wherever Commerce Tax collects a tax number (store/customer tax-number fields). Zero configuration — no settings form, no `configure` route. See [`../usage.md`](../usage.md) and [`../human-docs/index.md`](../human-docs/index.md).

## Notes for agents

- Not a payment gateway and not a localisation bundle — do not conflate with Windcave/DPS/POLi. It carries **no** payment, access, or role logic.
- The only integration point is `commerce_tax`'s TaxNumberType plugin system; it defines a plugin *instance*, not a new plugin *type*.
- Validation is a self-contained checksum; nothing is sent to IRD or any external service.
