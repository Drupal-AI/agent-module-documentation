# Physical Fields — manual setup guide

**Physical Fields** (`physical`) gives Drupal two field types for storing real
physical measurements together with their units — plus a small, dependency-light
PHP API for working with those measurements in code. It is the module Drupal
Commerce uses to model product weight and package dimensions for shipping, but
it is useful anywhere you need to record a number *and* the unit it was measured
in and convert reliably between units.

The two field types are **Measurement** (`physical_measurement`) — a single
number with a unit, where a storage-level "measurement type" decides which unit
set applies (weight, length, area, volume, temperature, or pressure) — and
**Dimensions** (`physical_dimensions`), which captures length, width, and height
sharing one unit. Editors pick the unit on the form (or you can lock the field
to a single unit), and formatters can display a stored value converted into a
different output unit.

Behind the fields is a set of immutable PHP value objects — `Weight`, `Length`,
`Area`, `Volume`, `Temperature`, `Pressure` — that convert between units and do
arithmetic (`add`, `subtract`, `multiply`, `divide`, `round`) and comparisons.
All the maths runs through a `Calculator` that uses bcmath on numeric *strings*,
so you never lose precision to floating-point drift — which matters for money
and shipping. The module has **no settings page, routes, or permissions of its
own**: you set it up entirely by adding fields through Drupal's standard Field
UI, and you use it in code through the value-object API.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the full value-object,
unit, and conversion API — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no configuration page to document — see **How to use it** below, since
everything is done through the Field UI and in code.

## Where it lives in the admin menu

Nowhere of its own. Physical Fields adds no admin menu item, settings form, or
permission. You interact with it in two places:

- **Structure → (your entity) → Manage fields**, when you add a Measurement or
  Dimensions field.
- In **custom PHP code**, through the value-object API.

## How to use it

### Add a measurement field (in the UI)

1. Go to **Structure → (content type / media type / etc.) → Manage fields → Add
   field**.
2. Choose **Measurement** (the `physical_measurement` type). Each measurement
   type is also offered as its own ready-made option — **Weight**, **Length**,
   **Area**, **Volume**, **Temperature**, **Pressure** — so you can pick, say,
   "Weight" directly.
3. In the field's **storage settings**, the **Measurement type** (area / length /
   temperature / volume / weight / pressure) fixes which unit set the field uses.
   This locks once the field holds data, so choose carefully. The default is
   *length*.
4. For a **Dimensions** field (length + width + height in one shared unit), pick
   the **Dimensions** field type instead — its units are always length units.

### Widget settings (Manage form display)

- **Default unit** — the unit pre-selected on the entry form (defaults to the
  measurement type's base unit).
- **Allow unit change** — whether editors may change the unit. Turn it off to
  lock the field to the default unit. On by default.
- **Available units** — checkboxes limiting which units appear in the dropdown;
  select none to show them all.

### Formatter settings (Manage display)

- **Output unit** — render the stored value converted into this unit, regardless
  of the unit it was entered in.

### Use it in code

The value objects are plain immutable PHP objects (every operation returns a new
instance). Construct them with a numeric **string** and a unit constant:

```php
use Drupal\physical\Weight;
use Drupal\physical\WeightUnit;

$weight = new Weight('100', WeightUnit::KILOGRAM);   // "100 kg"
$pounds = $weight->convert(WeightUnit::POUND);       // convert to lb
$total  = $weight->add(new Weight('20', WeightUnit::KILOGRAM));
```

To read a field's stored value, hydrate the matching value object:

```php
$item        = $entity->get('field_weight')->first();
$measurement = $item->toMeasurement();   // a Weight, Length, …
```

The full API — all unit classes, conversion, arithmetic, comparison helpers, the
`Calculator`, and reading/writing dimensions fields — is documented in the
sibling [`agent/api/physical.md`](../agent/api/physical.md) reference.
