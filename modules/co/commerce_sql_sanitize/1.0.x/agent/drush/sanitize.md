# `sql:sanitize` integration — what runs, and how to disable each part

This module has no command of its own. It hooks Drush's existing `sql:sanitize` (also invoked by
`sql:sync … --sanitize`). Everything below happens in the `@hook post-command sql-sanitize` methods
of the classes in `src/Commands/`. Each operation is on by default; pass the matching option with
`no` or `0` to switch it off. Options can be combined, e.g.:

```bash
drush sql:sanitize --sanitize-commerce-log=no --sanitize-commerce-payment-method=no
```

Enable/disable semantics (every class): an option value disables the operation only when it equals
the string `'no'` or `'0'` (`isEnabled()` returns `$value != 'no' && $value != '0'`). Any other
value — including the default `NULL` when the flag is omitted — leaves the operation **enabled**.

## Operations, in source order

| Operation | Default option (`=no` disables) | What it does | Source |
|---|---|---|---|
| Delete carts | `--delete-carts` | Entity-query `commerce_order` `condition('cart', TRUE)->accessCheck(FALSE)`, then `loadMultiple` + `delete` in chunks of 25. Draft orders that are **not** carts are kept. | `SanitizeOrderCommands::sanitize()` |
| Sanitize orders | `--sanitize-orders` | `UPDATE commerce_order SET mail='sanitized@local.test' WHERE mail IS NOT NULL`; `UPDATE commerce_order SET ip_address='127.0.0.1' WHERE ip_address IS NOT NULL`. | `SanitizeOrderCommands::sanitize()` |
| Sanitize addresses | `--sanitize-address-field` | For every `address`-type field on the **`profile`** entity type, overwrites each address column in the field table **and its revision table**. | `SanitizeAddress::sanitize()` |
| Restrict address fields | `--sanitize-address-fields=a,b` | Comma list; when set, only those named address fields are sanitized (others skipped). Empty/unset = all address fields. | `SanitizeAddress::getSanitizeFields()` |
| Delete Commerce logs | `--sanitize-commerce-log` | Truncates **all** tables of the `commerce_log` entity type. | `TruncateCommerceLogCommands` |
| Delete payment methods | `--sanitize-commerce-payment-method` | Truncates **all** tables of the `commerce_payment_method` entity type (stored cards / gateway tokens). | `TruncatePaymentMethodsCommands` |
| Delete tax numbers | `--delete-tax-numbers` | Truncates `profile__tax_number`, and `profile_revision__tax_number` if it exists. | `SanitizeTaxNumber` |

## Address sanitization details

`SanitizeAddress::sanitizeColumn()` replaces column values (only where the column is `IS NOT NULL`
and `<> ''`). The 13 columns in `SanitizeAddress::FIELD_COLUMNS` are `country_code`,
`administrative_area`, `locality`, `dependent_locality`, `postal_code`, `sorting_code`,
`address_line1`, `address_line2`, `address_line3`, `organization`, `given_name`, `additional_name`,
`family_name`. Replacement values: `country_code` → `US`, `administrative_area` → `DC`,
`postal_code` → `20500`, everything else → `[Sanitized]` (the label is passed through `dt()`).
Column and table names are resolved from the entity's `DefaultTableMapping`
(`getColumnNames()`, `getAllFieldTableNames()`), so only real, mapped columns are written.

Scope note: address sanitization is intentionally limited to the `profile` entity type
(`array_intersect_key($fields, ['profile' => 'profile'])`). `address`-type fields attached to any
other entity type are not touched by this operation.

## Confirmation prompt

`@hook on-event sql-sanitize-confirms` methods add human-readable lines to the pre-run confirmation
list (e.g. "Sanitize order email and IP addresses.", "Truncate payment method entity tables."), so
the operator sees what will happen before confirming.

## Gotcha — `--delete-tax-numbers` does not actually disable the tax-number scrub

`SanitizeTaxNumber::options()` registers the flag **`--delete-tax-numbers`**, and
`messages()` also reads `delete-tax-numbers`, but `sanitize()` guards on a *different* key —
`$options['sanitize-tax-number'] ?? 1` (singular, never registered). Because that key is never set,
the `?? 1` default always wins and the truncation of `profile__tax_number` runs regardless of
`--delete-tax-numbers=no`. Treat the tax-number scrub as always-on for this version; to keep tax
numbers you would need to patch `SanitizeTaxNumber::sanitize()` to read `delete-tax-numbers`.
(`SanitizeTaxNumber.php:46` vs `:63`/`:79`.)

## No-op guards

Each class checks for the presence of its target before doing anything: `SanitizeOrderCommands` and
the truncate classes check `entityTypeManager->getDefinition($id, FALSE)`; `SanitizeAddress` checks
`getFieldMapByFieldType('address')`; `SanitizeTaxNumber` checks
`schema()->tableExists('profile__tax_number')`. On a site without Commerce/profile installed the
options are not even added and the sanitize methods return early.
