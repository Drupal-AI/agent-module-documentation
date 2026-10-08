# Paragraphs Sum Formatter — manual setup guide

**Paragraphs Sum Formatter** (`paragraphs_sum_formatter`) adds a field formatter
that displays the **total** of a numeric field taken across all items of a
multi‑value Paragraphs field. If each paragraph in a field carries, say, a price
or a quantity, this formatter adds them all up and shows the single summed figure
when the content is displayed — handy for line‑item totals and similar running
sums.

It works with all core numeric field types (with the exception of the phone
field), and you tell it which numeric field to sum when you configure the
formatter. It only computes a value for display; it does not change your stored
content and has no access‑control role. It depends on the Paragraphs module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Paragraphs.

There is **no configuration page** for this module — it has no settings form. You
set it up on a field's display, described in "How to use it" below.

## How to use it

The formatter is chosen on a Paragraphs field's **Manage display**:

1. Make sure the paragraph type used by your field has the numeric field you want
   to total (for example a "price" or "quantity" field).
2. Go to **Structure → Content types → *(your type)* → Manage display**.
3. Find your multi‑value Paragraphs field and set its **Format** to **Paragraphs
   Sum formatter**.
4. Open the formatter's settings (the gear icon) and **select the numeric field
   you want to sum**.
5. Save. When the content is viewed, the field renders the sum of that numeric
   field across all the paragraphs it contains.
