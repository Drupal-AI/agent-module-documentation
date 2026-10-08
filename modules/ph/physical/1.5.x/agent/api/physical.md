# PHP API — measurement value objects, units & conversion

All classes live in the `Drupal\physical` namespace. No service needed for the value
objects — they are plain immutable objects (every operation returns a **new** instance).

## Value objects

One class per measurement type, each a `final` subclass of the abstract `Measurement`:

| Type | Class | Unit class | Base unit |
|---|---|---|---|
| weight | `Weight` | `WeightUnit` | `kg` |
| length | `Length` | `LengthUnit` | `m` |
| area | `Area` | `AreaUnit` | `m2` |
| volume | `Volume` | `VolumeUnit` | `m3` |
| temperature | `Temperature` | `TemperatureUnit` | — |
| pressure | `Pressure` | `PressureUnit` | — |

Construct with a **numeric string** (never a float) and a unit constant:

```php
use Drupal\physical\Weight;
use Drupal\physical\WeightUnit;

$weight = new Weight('100', WeightUnit::KILOGRAM);   // '100 kg'
```

The constructor asserts the number is a numeric string and that the unit exists for the
type (throws `\InvalidArgumentException` otherwise).

## Units (class constants)

Units are constants on the `*Unit` classes; static helpers: `getLabels()`,
`getBaseUnit()`, `getBaseFactor($unit)`, `assertExists($unit)`.

- `WeightUnit`: `MILLIGRAM` `mg`, `GRAM` `g`, `KILOGRAM` `kg`, `OUNCE` `oz`, `POUND` `lb`, `CARAT` `ct`.
- `LengthUnit`: `MILLIMETER` `mm`, `CENTIMETER` `cm`, `METER` `m`, `KILOMETER` `km`, `INCH` `in`, `FOOT` `ft`, `NAUTICAL_MILE` `M`, plus `MILLIGRAM`/`MICROGRAM`.
- `AreaUnit`: `SQUARE_MILLIMETER` `mm2`, `SQUARE_CENTIMETER` `cm2`, `SQUARE_METER` `m2`, `SQUARE_INCH` `in2`, `SQUARE_FOOT` `ft2`, `HECTARE` `ha`.
- `VolumeUnit`: `MILLILITER` `ml`, `CENTILITER` `cl`, `DECILITER` `dl`, `LITER` `l`, `CUBIC_MILLIMETER` `mm3`, `CUBIC_CENTIMETER` `cm3`, `CUBIC_METER` `m3`, `CUBIC_INCH` `in3`, `CUBIC_FOOT` `ft3`, `FLUID_OUNCE` `fl oz`, `US_GALLON` `gal`.

`MeasurementType` (constants `WEIGHT`, `LENGTH`, `AREA`, `VOLUME`, `TEMPERATURE`,
`PRESSURE`) maps a type string to its value-object and unit classes via
`MeasurementType::getClass($type)` / `getUnitClass($type)`.

## Conversion, arithmetic & comparison

Every method returns a new instance (immutable). Conversion goes via the base unit and
each unit's `getBaseFactor()`:

```php
$w   = new Weight('100', WeightUnit::KILOGRAM);
$lb  = $w->convert(WeightUnit::POUND);            // 100 kg -> lb

$sum = $w->add(new Weight('120', WeightUnit::KILOGRAM))   // add() auto-converts
         ->convert(WeightUnit::POUND);

$w->subtract($other);      // ->  new Weight
$w->multiply('3');         // scalar multiply (string!)
$w->divide('2');           // scalar divide
$w->round(2);              // precision + optional PHP_ROUND_HALF_* mode
```

`add`, `subtract`, `compareTo`, `equals`, `greaterThan`, `greaterThanOrEqual`,
`lessThan`, `lessThanOrEqual` all auto-convert the argument to the current unit first.
`compareTo()` returns -1/0/1; `isZero()` tests against zero. `getNumber()`, `getUnit()`,
`toArray()`, and `__toString()` (`"<trimmed number> <unit>"`) read the value.

`Calculator` is the underlying bcmath helper (strings only, default scale 16):
`Calculator::add/subtract/multiply/divide/compare/round/ceil/floor/trim($number)`. It
uses arbitrary-precision arithmetic to avoid float precision loss.

## Reading a physical field in code

```php
// physical_measurement item -> value object of the field's measurement type.
$item        = $entity->get('field_weight')->first();
$measurement = $item->toMeasurement();            // Weight | Length | ...
$kg          = $measurement->convert(WeightUnit::KILOGRAM)->getNumber();
// Raw columns are also available: $item->number, $item->unit.

// physical_dimensions item -> Length value objects (all share the item's unit).
$dim    = $entity->get('field_dimensions')->first();
$length = $dim->getLength();   // Length
$width  = $dim->getWidth();
$height = $dim->getHeight();
```

You can also assign a value object straight into a `physical_measurement` field:
`$entity->set('field_weight', new Weight('2.5', WeightUnit::KILOGRAM));`
(`MeasurementItem::setValue()` accepts a `Measurement`).
