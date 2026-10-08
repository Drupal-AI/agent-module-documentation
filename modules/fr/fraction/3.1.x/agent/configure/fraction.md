# fraction — field: widgets, formatters, storage

No admin settings page — you configure a **fraction field** through the normal Field UI on
any fieldable entity (Manage fields / Manage form display / Manage display).

## Field type
`fraction` (`FractionItem`, extends `NumericItemBase`). Storage columns:
- `numerator` — BIGINT (signed), nullable.
- `denominator` — INT (signed), nullable; a `FractionConstraint` keeps it a positive
  non-zero integer.

Computed properties: `fraction` (a `Fraction` object) and `decimal` (the decimal value —
this is what min/max range constraints validate against, via `getConstraints()` remapping
`value` → `decimal`). Setting the field from a plain numeric value (or a `decimal` key)
auto-converts through `Fraction::createFromDecimal()`.

## Widgets (Manage form display)
| Widget id | UI | Use for |
|---|---|---|
| `fraction` | Two textfields (numerator, denominator) | Exact fractions like 1/3. |
| `fraction_decimal` | One decimal textfield (→ base-10 fraction on save) | Prices / decimals; has an **auto precision** option. |

## Formatters (Manage display)
| Formatter id | Output | Options |
|---|---|---|
| `fraction` | `numerator / denominator` | `separator` (default `/`). |
| `fraction_decimal` | Decimal string | `precision`, `auto_precision`. |
| `fraction_percentage` | Decimal ×100 with `%` | `precision`, `auto_precision`. |

## Precision / storage facts
- Numerator range = signed BIGINT; denominator range = signed INT.
- Decimal widget converts e.g. `13.95` → `1395/100`; supports up to ~9 decimal places for
  price storage.
- Config schema for widgets/formatters ships in `config/schema/fraction.schema.yml`.

## Views
Views integration is automatic for the field (core Field module). Fraction extends field/
sort/filter handlers so you can **sort and filter by the decimal equivalent** (computed by
SQL formula). For custom numerator/denominator DB columns, a general-purpose `fraction`
Views field/sort/filter handler is available for use in `hook_views_data()` (example in the
module README).

## Feeds / Migrate
- **Feeds:** `FractionTarget` maps incoming values onto a fraction field.
- **Migrate:** a d7 `FractionField` field plugin + a `DecimalFraction` process plugin convert
  decimals to fractions during migration.
