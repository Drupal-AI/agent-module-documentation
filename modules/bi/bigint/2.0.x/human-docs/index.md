# BigInt — manual setup guide

**BigInt** (`bigint`) adds a new field type — **Number (bigint)** — that stores an 8-byte
database integer, holding numbers up to 19 digits, instead of the roughly 10-digit range of
Drupal core's ordinary Integer field. Core's Integer field tops out around ±2.1 billion; a
bigint column reaches into the quintillions. Use it whenever a numeric value can outgrow a
normal integer: 64-bit IDs imported from another system, millisecond timestamps, large
counters, financial amounts in cents, barcodes, and so on.

It behaves like any other Drupal field. You add a **Number (bigint)** field to a content
type, taxonomy term, user, or any fieldable entity, and configure it on the field's edit
form. It ships with a matching number-input widget and a display formatter. The formatter
groups digits with your chosen thousand separator using a string-safe technique, so very
large numbers are shown accurately without the rounding errors you'd get if they were pushed
through floating-point math.

By default a bigint field is **unsigned** (zero and up), which also adds a validation rule
rejecting negatives — untick that option in the field's storage settings if you need negative
values. The other field settings (minimum, maximum, prefix, suffix) are inherited from core's
Integer field. If the **Feeds** module is present, BigInt also provides a Feeds target so
imports can map values into bigint fields. There is no admin settings page and no permissions;
it depends only on core's **Field** module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

There is no configuration page — you use it exactly like a core number field:

1. Go to the entity you want to extend — for example **Structure → Content types →
   (your type) → Manage fields → Create a new field**.
2. Choose **Number (bigint)** as the field type and give it a label.
3. On the **field storage settings** (shown once, when the field is first created and locked
   after data exists), you'll find:
   - **Do not allow values less than 0** *(ticked by default)* — keeps the field unsigned.
     When on, the database column is unsigned *and* a validation rule rejects negative values.
     Untick it if you need to store negative numbers.
   - The internal size stays **big**, which is what produces the 64-bit `BIGINT` column.
4. On the ordinary **field settings** you get core's familiar options — **minimum**,
   **maximum**, **prefix**, and **suffix** — to bound the allowed range and decorate the
   display.
5. Save. On **Manage form display** the field uses the bigint number-input widget, and on
   **Manage display** it uses the bigint formatter (both are the defaults, so there is
   nothing extra to select). The formatter's thousand-separator grouping is applied without
   floating-point rounding, so even 19-digit values display exactly.

If the **Feeds** module is installed, a bigint Feeds target also becomes available so you can
map imported values straight into these fields.
