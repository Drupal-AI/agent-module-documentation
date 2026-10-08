# Physical Quantity Fields — manual setup guide

**Physical Quantity Fields** (`physical_quantity_fields`) is an engineering and
scientific field toolkit. It adds **15+ specialized field types for physical
measurements** — Length, Mass, Temperature, Volume, Time, Speed, Area, Pressure,
Energy, Power, Angle, and Data Storage — each with unit‑aware storage, a widget
for entering a value with its unit, and a formatter for displaying it. It is meant
for product specifications, scientific data, and any content that needs to store
measurements as structured, unit‑aware values rather than free text.

Accuracy is the module's main selling point: it uses NIST‑sourced conversion
factors and mathematically correct formulaic temperature conversions (Celsius,
Fahrenheit, Kelvin) to keep round‑trip conversions precise. Values are stored in a
base unit, and the display formatter converts to whatever target unit you choose,
with configurable decimal precision (0–10), prefix/suffix toggles, text
transformations (UPPERCASE / Title Case), and trailing‑dot options for
abbreviations. The conversion logic lives in a reusable `UnitConverter` service,
and the module ships Twig template suggestions (for example
`physical-quantity--length.html.twig`) for per‑type styling. It is backward
compatible with 1.x data and includes automated configuration migrations for the
upgrade to 2.x.

Everything is set up on the field itself — there is **no central settings page**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — you configure it per field,
described under "How to use it" below.

## Where it lives in the admin menu

Physical Quantity Fields adds no admin settings page. You use it from
**Structure → Content types (or any fieldable entity — nodes, users, media) →
*(bundle)* → Manage fields**, and configure its display from the same bundle's
**Manage form display** and **Manage display** tabs.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage fields** and click
   **Add field**.
2. Choose one of the quantity field types — for example **Mass**, **Length**, or
   **Energy**.
3. On **Manage form display**, configure the widget — unit‑label suffixes and any
   min/max validation constraints for the value.
4. On **Manage display**, choose the **target display unit**. The module
   automatically converts from the stored base unit, and here you also set the
   decimal precision, prefix/suffix, and text‑transform options.

### For developers

If you need to convert values in your own code, the
`physical_quantity_fields.unit_converter` service exposes a clean interface, for
example:

```php
// Convert 100 kilometres to miles.
$miles = $unitConverter->convert(100.0, 'km', 'mi', 'length');
```
