Decimal provides a field type that stores decimal numbers as database strings so that very large or very high-precision values keep every digit exactly.

---

The module adds the `decimal_string` field type, which extends core's `DecimalItem` but persists its value in a `varchar(32)` column instead of the core `DECIMAL` SQL type. This avoids the precision and range limits of native SQL decimal columns and lets you store amounts with up to 32 significant digits and 18 fractional digits. It ships a matching widget (`decimal_string`), a formatter (`decimal_string`, "Decimal (from string)"), a reusable `decimal_string` render/form element, and two services — `decimal.normalizer` (parses and cleans user input, converting locale symbols like `,` to `.` and stripping spaces/`+`/non-breaking spaces) and `decimal.formatter` (formats a string to a fixed scale using `brick/math` `BigDecimal` with HALF_UP rounding). Storage settings expose precision (max 32) and scale (max 18); field settings expose min, max, prefix and suffix. Values are normalized on `preSave()` and validated against min/max in the form element. The module requires the BCMath PHP extension (a runtime requirement is registered) and depends only on core `field`.

---

- Store monetary amounts with exact precision, avoiding floating-point rounding errors in prices or balances.
- Hold very large numbers (up to 32 significant digits) that overflow a native SQL decimal column.
- Record high-precision measurements such as scientific readings or engineering tolerances.
- Track cryptocurrency amounts that need many fractional digits (up to 18 places).
- Capture exchange rates or interest rates that require more precision than a standard decimal field.
- Add a numeric field to any content type, taxonomy term, user, or other fieldable entity via Field UI.
- Configure per-field precision and scale in the field storage settings (precision up to 32, scale up to 18).
- Constrain input with min and max bounds enforced during form validation.
- Show a currency symbol or unit by setting a field prefix or suffix (e.g. `$`, `€`, `kg`).
- Accept locale-formatted input where users type a comma as the decimal separator; the normalizer converts it to a dot.
- Let editors paste values containing spaces, `+` signs, or non-breaking spaces; those are stripped on save.
- Display stored values rounded to a chosen number of decimal places using the formatter's scale setting.
- Provide a placeholder hint in the widget to show editors the expected number format.
- Reuse the `decimal_string` form element in a custom form to collect a validated decimal string.
- Call the `decimal.formatter` service to format an arbitrary decimal string to a fixed scale in custom code.
- Call the `decimal.normalizer` service to clean and validate a decimal string, returning `FALSE` on invalid input.
- Migrate existing float or decimal field data into a lossless string-backed field.
- Store quantities for commerce or inventory that must not lose trailing precision.
- Keep tax or accounting figures where exact string representation matters for auditing.
- Use as the value source for computed totals that rely on BigDecimal arithmetic downstream.
