# Configuration

Dimension has no central settings form. Instead, every option lives on the
**field itself**, split into two groups you'll recognise from any Drupal field:
**storage settings** (how the numbers are stored) and **field settings** (factor,
limits, and units). You reach both by editing a Length, Area, or Volume field
under **Structure → Content types → [type] → Manage fields**.

Both groups have settings for **each component** (Length has `length`; Area has
`width` and `height`; Volume has `length`, `width`, and `height`) and for the
computed **value** — the derived total.

## Storage settings — how numbers are stored

These control the numeric precision of each stored column. Like all field storage
settings, they can only be changed while the field holds **no data** — once
content exists they are locked.

- **Precision** — the total number of digits stored, including decimals. Range
  10–32, default **10**.
- **Scale** — how many of those digits sit to the right of the decimal point.
  Range 0–10, default **2**.

You set a precision/scale pair for every component and for the value. So an Area
field has precision and scale for `width`, for `height`, and for `value`.

## Field settings — factor, limits, and units

These can be changed at any time.

- **Factor** — a multiplier applied to the component during the calculation. It
  defaults to `1`. Use it for unit conversion: a Length field with `length.factor
  = 10` converts a value entered in centimetres to a stored value in millimetres.
  Each component has its own factor.
- **Min** and **Max** — the minimum and maximum allowed for a component. Leave
  blank for no limit. These are enforced when the editor saves (a height must fall
  between 1 and 300, say).
- **Prefix** — a string placed before the value, for example `cm `. You can supply
  singular and plural forms separated by a pipe (`inch|inches`).
- **Suffix** — a string placed after the value, for example ` m²` or ` L`. It also
  supports the `singular|plural` form.

Prefix and suffix exist for each component **and** for the value. The **value's**
prefix and suffix are the ones the plain (value) formatter prints around the
computed total — this is where you'd put the unit of the result, such as ` m²` on
an Area field.

## How the total is calculated

When the entity is saved, the module:

1. rounds each component to its configured scale,
2. multiplies each component by its factor,
3. multiplies the components together, and
4. rounds the result to the value's scale, storing it in `value`.

So Area `value = width × width.factor × height × height.factor`; Volume multiplies
all three components; Length is simply `length × length.factor`. A dimension is
treated as empty if any component is left blank.

## Choosing how it displays

On **Manage display**, two kinds of formatter are available:

- **Value formatters** (Length / Area / Volume) show the computed total with the
  value's prefix/suffix, e.g. `96 m²`.
- **Components formatters** (Area or Volume) show the raw components through a
  template — Area renders as `width x height` (e.g. `12 x 8`) and Volume renders
  its three parts. There is no separate components formatter for Length, since a
  Length field has only one component.
