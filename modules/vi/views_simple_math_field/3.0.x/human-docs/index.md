# Views Simple Math Field — manual setup guide

**Views Simple Math Field** (`views_simple_math_field`) adds a new field to Views
called **Global: Simple Math Field**. It lets you compute a value from a formula
that references other fields already in the same view — for example a subtotal
(`@quantity * @price`), a percentage (`(@completed / @total) * 100`), or a per-unit
cost — without writing a custom Views field plugin or resorting to Twig math.

You add the fields you want to work with to your view as usual, then add the Simple
Math Field, tick which of those fields feed the calculation, and write the formula
using a simple token for each field (`@field_price`, `@nid`, and so on). The value
is worked out in PHP for each row at display time using the `andileco/eval-math`
library, so it handles the usual arithmetic operators, parentheses, and functions
like `abs()` and `sqrt()`. It understands values coming through relationships,
rewritten/aliased fields, and Commerce price fields, and it can safely divide by
zero (with an option to silence the log noise that would otherwise create).

The module also ships a matching **sort handler**, so you can order a view's rows by
a computed Simple Math Field value even though that value is not a real database
column. All configuration lives inside the view itself — there is no separate
settings page, no permissions, and no Drush commands. It requires core's **Views**
module and the external `andileco/eval-math` library (pulled in automatically via
Composer).

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its math
   library) with Composer, then enable it.

## How to use it

Everything is configured on the field inside a view — there is no admin settings
page.

**Add the field:**

1. Edit a view and, next to **Fields**, click **Add**.
2. First add the numeric fields you want to use in the calculation — they must
   already exist in the view to be available as formula inputs.
3. Add **Global: Simple Math Field** (search for "Simple Math Field").
4. In its settings:
   - **Select the fields to use in the formula** — tick each field to feed in. Each
     ticked field shows its **formula token** (e.g. `@field_price`, `@nid`), which
     equals that field's Views id.
   - **Formula** — write the expression using those tokens, for example
     `(@field_price + @field_tax) / @field_qty`. Supports `+ - * / ^`, parentheses,
     and functions like `abs` and `sqrt`.
   - **Mute database logs for this field** — tick this to suppress the log entry a
     division-by-zero would otherwise write, which is handy when some rows legitimately
     contain zero.
5. Click **Apply**, then **Save** the view.

**A few things worth knowing:**

- Each input value is treated as a number; thousands separators are stripped and
  missing values default to `0`.
- To add more than one calculated column, just add the field again — extra copies
  get ids like `field_views_simple_math_field_1`, and you can even feed one computed
  field into another.

**Sort by the computed value:**

Add a **Sort criteria → Global: Simple Math Fields**, choose which Simple Math
Field to sort by, and pick ascending or descending. Because the value is computed in
PHP, the sort runs on the result set after the query — so avoid pairing it with a
rewritten field that needs advanced rendering.
