# Physical Multi Field — manual setup guide

**Physical Multi Field** (`physical_multi`) provides a single field type that can
store a **weight, a volume, a plain count, or a named size** — chosen per value,
not fixed per field. It was built for a problem that comes up constantly on recipe
and ingredient sites: one ingredient is a weight ("250 g flour"), the next is a
volume ("1.5 l stock"), another is just a count ("3 eggs"), and another is a
named size ("1 large onion"). Drupal core has no field for that, and the popular
[Physical](https://www.drupal.org/project/physical) module locks each field to a
single measurement type. Physical Multi Field stores the measurement *type*
alongside the quantity and unit on every individual value, so one field can hold
any mix of these quantities.

It reuses the Physical module's unit definitions and bcmath‑based conversion
engine for weight and volume, so unit maths (grams to ounces, litres to cups, and
so on) is accurate and consistent with any other Physical‑powered fields on your
site. The default widget shows a single quantity input next to one unit select,
with the units grouped into optgroups by measurement type — there's no
JavaScript "pick a type, then pick a unit" two‑step to keep in sync. The default
formatter shows the stored value with locale‑aware number formatting and can
optionally convert weight and/or volume values to a chosen display unit.

Everything is configured on the field itself — this module has **no central
settings page**. This is a beta release (`1.0.0-beta1`) and is not covered by
Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Physical dependency.

There is **no configuration page** for this module — you configure it per field,
described under "How to use it" below.

## Where it lives in the admin menu

Physical Multi Field adds no admin settings page. You set it up entirely from
**Structure → Content types (or any fieldable entity) → *(bundle)* → Manage
fields**, and its display from the same bundle's **Manage display** tab.

## How to use it

1. Under **Manage fields** on your bundle, click **Add field** and choose the
   **Quantity (weight, volume, count, or size)** field type, exactly as you would
   add any other field.
2. On the field's **storage settings** form, tick which measurement types
   (weight, volume, count, size) editors will be able to choose from — at least
   one is required.
   - If **Weight** or **Volume** is enabled, you can optionally restrict which
     units are offered. Leaving all of a type's units unchecked allows every unit
     for that type.
   - If **Size** is enabled, enter one size label per line (for example
     *Small*, *Medium*, *Large*). Each line becomes a selectable option.
3. On the bundle's **Manage form display** tab, the default **Quantity and unit**
   widget needs no special setup beyond the usual widget options (placeholder
   text, input width, whether to visually hide the field labels).
4. On the bundle's **Manage display** tab, the default **Quantity and unit**
   formatter can optionally be given a weight and/or volume **output unit**, so
   those measurement types always display in one unit regardless of how they were
   entered. Count and size values are unaffected by that setting.

> **Note:** because a single field can mix weights, volumes, counts, and sizes,
> sorting or filtering a View by the field's raw quantity isn't meaningful without
> first narrowing to one measurement type. This module does not ship Views
> integration for that.
