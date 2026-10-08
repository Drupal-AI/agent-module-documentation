# Decimal — manual setup guide

**Decimal** (`decimal`) provides a decimal-number field type built for **big and
exact** numbers. Where Drupal core's number fields can run into precision limits,
this field stores its values as strings and uses the `brick/math` library for
big-decimal arithmetic, so you can hold values with the precision and scale your
data actually needs — for example financial amounts where rounding errors are not
acceptable.

It's a straightforward content-modelling tool: you add the field to an entity
bundle just like any other field, and its values then flow through Drupal's normal
field handling (storage, widgets, formatters, Views). It depends on core's
**Field** module, lives in the **Field types** package, and supports Drupal 9.1,
10, and 11. It has no content or access role of its own — it simply gives you a
better numeric field.

There is **no central settings page** — everything is configured per field on the
entity's field-management screens.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You add and tune the field on
your entity's **Manage fields** screen, described below.

## Where it lives and how to use it

Decimal adds no admin settings page. You use it from the **Manage fields** screen
of whatever entity you're modelling:

1. Go to the bundle you want to add the field to — for example **Structure →
   Content types → *(your type)* → Manage fields**.
2. Click **Add field** and choose the **Decimal** field type provided by this
   module.
3. Set the field's storage and instance settings (such as precision and scale, and
   the usual label, help text, and required flag), then save.
4. On the bundle's **Manage form display** and **Manage display**, choose the
   widget and formatter you want for the field.

From then on, editors enter decimal values into the field and Drupal stores and
renders them with the exact precision you configured.
