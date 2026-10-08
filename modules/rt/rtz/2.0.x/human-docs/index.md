# Remove Trailing Zeros — manual setup guide

**Remove Trailing Zeros** (`rtz`) is a display‑only field formatter for decimal and
float fields. Drupal stores numbers with a fixed number of decimal places, so a
value can show up as `7.000` or `12.50` even when the trailing zeros add nothing.
This formatter trims them for display: `7.000` becomes `7`, `12.50` becomes `12.5`,
and `12.00` becomes `12`.

It changes only how the number is *shown*, not how it is *stored* — the underlying
value and its scale in the database are untouched. It adds no settings page: you
switch it on wherever a decimal or float field is displayed, either on a content
type's *Manage display* or in a View's field settings.

Because it strips zeros, it suits measurements, quantities, and ratings, where
`7.00` reads better as `7`. It's usually **not** what you want for currency, where
`12.50` is the correct presentation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You apply it on a field's
display, described in "How to use it" below.

## How to use it

On a content type or other fieldable entity:

1. Go to **Structure → Content types → *(your type)* → Manage display**.
2. Find your decimal or float field and set its **Format** to **Remove Trailing
   Zeros**.
3. Click **Save**.

To use it in a **View**, add the decimal or float field to the view, open the
field's settings, and choose the **Remove Trailing Zeros** formatter there.
