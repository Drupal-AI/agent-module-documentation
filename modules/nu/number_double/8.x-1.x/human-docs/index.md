# Number Double — manual setup guide

**Number Double** (`number_double`) adds a numeric field type that stores its
values in the database as a MySQL **DOUBLE** — a double‑precision floating‑point
column. Drupal core already ships decimal, integer and float fields, but when you
genuinely need the wider range and precision that a database `DOUBLE` provides,
this module gives you a field type whose schema maps to exactly that column type.

The problem it solves is narrow and specific: scientific measurements, very large
or very small quantities, and any data where the storage characteristics of a
`DOUBLE` matter more than the fixed‑scale behavior of a decimal field. Once the
field is added, values behave like any other number field — the difference is
purely in how the value is stored in the database.

There is nothing to configure globally. The module works the moment you enable it:
its footprint is a single field type plus its config schema, with no dependencies
beyond Drupal core. You use it entirely from the Field UI when you add a field to a
content type or other fieldable entity.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it adds no settings form. All
setup happens on a field, described in "How to use it" below.

## Where it lives in the admin menu

Number Double adds no admin page of its own. You reach it through **Structure →
Content types → *(your type)* → Manage fields → Add field**, where "Number Double"
appears in the list of available field types.

## How to use it

1. Go to **Structure → Content types → *(your content type)* → Manage fields**
   (the same place works for other fieldable entities such as taxonomy terms or
   users).
2. Click **Add field** and choose the **Number Double** field type, give it a
   label, and save.
3. Configure the field settings and the usual per‑field options (required,
   default value, cardinality), then save again.
4. The field is now available on the entity's edit form and can be arranged on
   **Manage form display** and **Manage display** like any other number field.

Because the storage is a MySQL `DOUBLE`, choose this field type only when the
database column type is the reason you need it — for ordinary decimals, core's
own number fields are usually the better fit.
