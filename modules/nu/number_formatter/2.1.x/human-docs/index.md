# Number Formatter — manual setup guide

**Number Formatter** (`number_formatter`) turns number‑display settings into
reusable **`number_format` configuration entities**, and provides a field
formatter that applies a chosen one. Instead of repeating the same decimal count,
thousands separator, prefix and suffix inside every field's display, you define a
format **once** and point as many fields at it as you like.

The problem it solves shows up on any site with more than a handful of numbers. A
catalog with prices, quantities, percentages and measurements ends up storing the
same formatter settings over and over in each view mode, and a change to house
style means editing all of them by hand. Number Formatter inverts that: define
"Currency (EUR)", "Percentage", "Quantity" and "Measurement" once, apply them
across content types and view modes, and when the style guide changes you adjust
the format in one place and every field follows.

Because the formats are configuration entities, they **export, deploy and diff**
like anything else in your site's configuration, and they can be referenced from
code if something needs to render a number the same way outside a field. The
formatter is built on PHP's `NumberFormatter` class (part of the intl extension),
so a working intl extension is what makes the formatting happen. Its only
dependency is core's **Field** module, and it declares support all the way through
Drupal 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

The number formats themselves are managed in the admin UI (a collection of config
entities) and applied on a field's display — both described in "How to use it"
below.

## Where it lives in the admin menu

Number Formatter's formats are managed at the **Number formats** collection page
(route `entity.number_format.collection`). This is where you create, edit and
delete the reusable formats. Applying a format to a specific field happens
separately, on that field's **Manage display** under **Structure → Content types →
*(your type)* → Manage display**.

## How to use it

1. **Create a format.** Go to the **Number formats** collection page and add a new
   format. Give it a clear name (for example "Currency (EUR)") and set its display
   options — decimal places, thousands and decimal separators, and any prefix or
   suffix. Save it. Repeat for each distinct style you need ("Percentage",
   "Quantity", "Measurement", and so on).
2. **Apply it to a field.** Go to the relevant entity's **Manage display**, find
   your number field, and choose the **Number Formatter** formatter. In its
   settings, pick the named format you created.
3. **Reuse and maintain.** Point as many fields and view modes at the same format
   as you like. When house style changes, edit the format once and every field
   that uses it updates. Because formats are configuration, they travel with your
   config export/import between environments.
