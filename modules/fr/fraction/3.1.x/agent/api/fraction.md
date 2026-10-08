# fraction — API: the `Fraction` class

`\Drupal\fraction\Fraction` (implements `FractionInterface`) is a plain value object — no
service, just `new`. All arithmetic uses BCMath when the extension is loaded, else native
float math.

```php
use Drupal\fraction\Fraction;

$f = new Fraction(1, 2);            // numerator, denominator (default 0, 1)
$f->getNumerator();                // "1"  (strings)
$f->getDenominator();              // "2"
$f->toString('/');                 // "1/2" (separator configurable)
$f->toDecimal(2);                  // "0.50"  (precision = decimal places)
$f->toDecimal(2, TRUE);            // auto precision: exact length for base-10/terminating
```

## Construct from a decimal
```php
$f = Fraction::createFromDecimal('13.95');  // -> 1395/100
```
Precision is the count of digits after `.`; denominator = `10^precision`;
numerator = `value * denominator`.

## Arithmetic (each returns a NEW, reduced Fraction)
```php
$a = new Fraction(2, 3);
$b = new Fraction(1, 2);
$a->add($b);        // 7/6
$a->subtract($b);   // 1/6
$a->multiply($b);   // 1/3
$a->divide($b);     // 4/3  (multiplies by reciprocal)
```

## Other methods
| Method | Returns | Notes |
|---|---|---|
| `reduce()` | Fraction | Lowest terms (divides by `gcd()`). |
| `gcd()` | string | Greatest common divisor (Euclid). |
| `reciprocate()` | Fraction | Swaps numerator/denominator. |
| `setNumerator($v)` / `setDenominator($v)` | $this | Denominator `0`/empty → treated as `1` with numerator `0`; negative denominator normalises signs onto the numerator. |

## Notes
- Numerator/denominator are handled as **strings** to preserve BIGINT precision — don't cast
  to int in PHP.
- `toDecimal()` rounds via an internal BCMath round helper; without BCMath it uses
  `round()`.
- Auto precision only shortens correctly for base-10 or provably-terminating denominators;
  otherwise the passed precision (or denominator length) is used.
