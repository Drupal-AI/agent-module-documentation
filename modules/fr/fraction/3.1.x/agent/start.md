# fraction — agent start

Provides a `fraction` **field type** (stores a decimal as BIGINT numerator + INT
denominator, for exact precision) plus a standalone `\Drupal\fraction\Fraction` PHP class
for fraction arithmetic. Ships 2 widgets (Fraction, Decimal), 3 formatters (Fraction,
Decimal, Percentage), Views field/sort/filter handlers, and Feeds + Migrate plugins. No
admin settings form, no permissions, no Drush. Requires core `field`. Math uses BCMath when
available.

- The `Fraction` class API + arithmetic + `createFromDecimal`/`toDecimal` → [api/fraction.md](api/fraction.md)
- Field widgets, formatters, storage, precision, Views/Feeds/Migrate → [configure/fraction.md](configure/fraction.md)
