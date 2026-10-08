Human Decimal Formatter adds a single decimal field formatter that hides unnecessary trailing zeros — `3.00` renders as `3`, while `3.23` still renders as `3.23`.

---

The module ships one thing: a `FieldFormatter` plugin with id `human_decimal` (label "Human decimal"), applicable to core `decimal` fields. It extends core's `DecimalFormatter`, inheriting every setting the standard Decimal formatter has (scale, decimal separator, thousand separator, prefix/suffix) and its settings form/summary unchanged. The only behavioural change is in the protected `numberFormat()` method: it inspects the value's fractional part and, when there are no significant decimal digits, drops the scale to `0` so no trailing zeros are shown; when the fractional part is shorter than the configured scale, it shrinks the scale to the actual number of digits instead of padding with zeros. Values with more digits than the scale are still rounded by `number_format()` as normal. There is no admin config page, no permissions, no routes, no config schema, and no services — you enable the module and pick "Human decimal" as the formatter in a decimal field's display settings (Manage display). Depends only on core `field`. Output is a numeric string; prefix/suffix and the raw markup are escaped by the core parent's rendering, so there is nothing extra to configure or secure.

---

- Display product prices so `19.00` shows as `19` but `19.99` keeps both decimals.
- Show quantities or stock counts without forced `.00` padding.
- Render ratings/scores (`4.5`, `4.0` → `4`) cleanly in a listing.
- Present measurement fields (weight, length) that only sometimes need decimals.
- Clean up View field columns where decimals would otherwise show padded zeros.
- Format currency-like fields where whole amounts should read as integers.
- Display tax or discount rates that vary between whole and fractional percentages.
- Show sensor/telemetry decimal readings without trailing-zero noise.
- Render nutritional values (grams, calories) as integers when whole.
- Display distances (`5 km`, `5.3 km`) with a shared field but no padding.
- Show aggregate averages that land on a whole number as an integer.
- Present sports statistics (goals-per-game, ERA) with variable precision.
- Format financial KPIs on a dashboard node without `.00` clutter.
- Display shipping weights on commerce product pages.
- Show interest rates that are sometimes whole percentages.
- Render voting/poll averages cleanly.
- Display coordinates or offsets that may be whole numbers.
- Present temperature readings that only sometimes carry a fraction.
- Format inventory unit counts stored as decimal fields.
- Show currency conversion results with variable decimal length.
- Display engineering tolerances where trailing zeros are misleading.
- Render a decimal field in an email/newsletter view without padding.
- Keep the standard prefix/suffix and separator options while dropping trailing zeros.
- Swap in as a drop-in replacement for the core Decimal formatter anywhere whole numbers dominate.
- Improve readability of report tables that mix whole and fractional decimals.
