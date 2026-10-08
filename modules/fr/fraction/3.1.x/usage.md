Fraction provides a `fraction` field type that stores a decimal as two integers — a numerator and a denominator — so values keep exact precision instead of suffering floating-point rounding, plus a standalone `\Drupal\fraction\Fraction` PHP class for fraction arithmetic.

---

The field stores each value as a signed BIGINT numerator and a signed INT denominator (a constraint keeps the denominator a positive non-zero integer), avoiding the precision loss of float or fixed-scale decimal columns. Two widgets are provided: **Fraction** (separate numerator/denominator textfields, for exact fractions like 1/3) and **Decimal** (a single decimal textfield that is converted to a base-10 fraction on save, e.g. `13.95` → `1395/100`). Three formatters render the stored fraction: **Fraction** (`numerator / denominator`, separator configurable), **Decimal** (fixed or automatic precision), and **Percentage** (same, ×100). The `\Drupal\fraction\Fraction` value object offers `getNumerator()/getDenominator()`, `toString()`, `toDecimal($precision, $auto_precision)`, `createFromDecimal()`, `reduce()`, `gcd()`, `reciprocate()`, and arithmetic (`add`, `subtract`, `multiply`, `divide`) — all performed with the BCMath extension when available, falling back to native float math otherwise. "Automatic precision" derives the exact number of decimal places for base-10 or terminating fractions. The field also exposes a computed `decimal` property (so min/max range validation is applied against the decimal value) and extends Views field/sort/filter handlers so you can sort and filter by the decimal equivalent via SQL formula; a general-purpose `fraction` Views handler is available for custom numerator/denominator columns too. Integration plugins for **Feeds** (`FractionTarget`) and **Migrate** (a d7 field plugin plus a `DecimalFraction` process plugin) ship with the module. A common use is high-precision or multi-currency **price storage** (up to 9 decimal places). Requires only core's Field module.

---

- Store a decimal value with exact precision (no floating-point rounding errors).
- Add a price field that supports variable/high decimal precision across currencies.
- Capture measurements as true fractions (e.g. 1/3) without converting to a lossy decimal.
- Let editors enter a value either as numerator/denominator or as a plain decimal.
- Display a stored fraction as `1/3` with a configurable separator.
- Display a stored fraction as a decimal with a fixed precision (e.g. 0.33333).
- Display a stored fraction as a percentage (e.g. 33.33333%).
- Use automatic precision so base-10/terminating fractions render at their exact length.
- Sort a View by the decimal equivalent of a fraction field.
- Filter a View by the decimal equivalent of a fraction field.
- Validate min/max ranges against the decimal value of the fraction field.
- Do exact fraction arithmetic in custom code via the `Fraction` class (add/subtract/multiply/divide).
- Convert a decimal string to a reduced fraction with `Fraction::createFromDecimal()`.
- Reduce a fraction to lowest terms with `->reduce()` (uses Euclid's GCD).
- Compute the decimal value of a fraction at a chosen precision with `->toDecimal()`.
- Perform BCMath-backed arbitrary-precision math where the extension is available.
- Import fraction/price data from a feed using the Feeds target plugin.
- Migrate Drupal 7 fraction fields (or decimals) into fraction fields via the Migrate plugins.
- Implement custom database tables with numerator/denominator columns and reuse Fraction's Views handler.
- Store scientific or engineering quantities that must round-trip without precision loss.
