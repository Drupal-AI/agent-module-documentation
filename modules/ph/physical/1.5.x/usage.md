Physical Fields provides two Drupal field types plus a PHP value-object API for storing and manipulating physical measurements (weight, length, area, volume, temperature, pressure) with their units and conversions.

---

Physical Fields ships a `physical_measurement` field type (a single number + unit, with a storage-level "measurement type" that determines which unit set applies) and a `physical_dimensions` field type (length/width/height sharing one unit). Behind the fields sits a small, dependency-light PHP API: immutable value objects — `Weight`, `Length`, `Area`, `Volume`, `Temperature`, `Pressure` — that all extend `Measurement` and are constructed with a numeric string and a unit constant (e.g. `new Weight('100', WeightUnit::KILOGRAM)`). Each value object supports unit `convert()`, plus `add()`, `subtract()`, `multiply()`, `divide()`, `round()`, and comparison helpers (`equals`, `greaterThan`, `compareTo`, `isZero`). Arithmetic runs through `Calculator`, a bcmath wrapper that keeps numbers as strings to avoid floating-point precision loss (important for e-commerce). Units are defined as class constants on `WeightUnit`, `LengthUnit`, `AreaUnit`, `VolumeUnit`, `TemperatureUnit`, `PressureUnit`, each exposing `getBaseUnit()`, `getBaseFactor()`, `getLabels()`, and `assertExists()`; conversion works by translating any unit to the type's base unit via its factor. Widgets let editors pick a unit (or lock it), formatters can render in a chosen output unit, and a `NumberFormatter` service handles language-specific number input and display. Reading a measurement field in code returns the raw `number`/`unit` columns; `MeasurementItem::toMeasurement()` hydrates the matching value object, and `DimensionsItem` exposes `getLength()`, `getWidth()`, `getHeight()`. It has no admin UI or permissions of its own — you configure it by adding fields through the standard Field UI. Drupal Commerce uses it to model product weight and dimensions for shipping.

---

- Add a "Weight" field to a product or content type to store a number and a weight unit (kg, g, lb, oz, etc.).
- Add a "Dimensions" field to capture length, width, and height in a single shared unit.
- Store a length, area, volume, temperature, or pressure measurement via the `physical_measurement` field's measurement-type setting.
- Let editors choose the unit on the entry form, or lock the field to a single unit.
- Restrict which units appear in a widget's dropdown via the "Allowed units" setting.
- Render a stored measurement in a different output unit than it was entered (formatter `output_unit`).
- Construct a weight in code: `new Weight('100', WeightUnit::KILOGRAM)`.
- Convert a measurement between units, e.g. kilograms to pounds with `->convert(WeightUnit::POUND)`.
- Add two weights together and express the result in another unit.
- Sum item dimensions or weights when building a shipment total.
- Multiply a unit weight by a quantity to compute an order-line total weight.
- Compare two measurements (`greaterThan`, `lessThan`, `equals`, `compareTo`) regardless of their units.
- Check whether a measurement is zero before running shipping logic (`isZero()`).
- Round a measurement to a fixed precision with a chosen PHP rounding mode.
- Perform bcmath-safe arithmetic on numeric strings via `Calculator` (add/subtract/multiply/divide/compare/round).
- Read a measurement field in code and hydrate its value object with `$item->toMeasurement()`.
- Read a dimensions field's sides as `Length` objects via `getLength()`, `getWidth()`, `getHeight()`.
- Convert an entity's stored weight to the carrier's expected unit before an API call.
- Model product weight and package dimensions for Drupal Commerce shipping.
- Display measurements with locale-aware number formatting via the `physical.number_formatter` service.
- Validate that a submitted unit exists for its measurement type (`assertExists()` throws on unknown units).
- Look up the base unit and conversion factor for any unit (`getBaseUnit()`, `getBaseFactor()`).
- Present each measurement type as its own preconfigured field option in the Field UI.
- Convert nautical miles, hectares, carats, fluid ounces, US gallons, and other less-common units.
- Store measurements safely for financial/e-commerce contexts without floating-point drift.
- Migrate legacy weight data into a physical field using the provided migrate process plugin.
