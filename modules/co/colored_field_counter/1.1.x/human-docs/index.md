# Colored Field Counter — manual setup guide

**Colored Field Counter** (`colored_field_counter`) adds a **character counter with
colored feedback** to text-field widgets on the content edit form. As an editor types,
the widget shows how many characters have been entered and how many the field can
accept, and it changes color to signal whether the length is in a good range — green
for optimal, orange for suboptimal, and red for lengths that are not optimized. It is a
handy nudge for fields where length matters, like meta descriptions or teasers. (It is
similar in spirit to the Textfield Counter module.)

The module ships **two kinds of widget**. The **simple** widget is configured with
three numbers: a recommended size (in characters), a lower margin percentage (when the
counter turns orange, computed as "recommended size − x%"), and a lock-input
percentage (a hard maximum, "recommended size + x%", which blocks further input — this
lock does not apply to WYSIWYG fields). The counter is green up to the lower margin,
orange from there to the recommended size, and red beyond it. The **complex** widget
instead gives you a small table of three rows where you set, per row, a color and a
lower and upper character limit, for full control over the thresholds.

These widgets work on a range of text field types — Text (plain), Text (plain, long),
Text (formatted), Text (formatted, long), Text (formatted, long, with summary) — and on
**Link** fields (for the label length). It is an edit-form enhancement only: it has no
content or access role, and no site-wide settings page — you turn it on per field via
the Field UI. It supports Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** — the counter is enabled per field on the widget,
described in "How to use it" below.

## How to use it

1. Go to the bundle that has the text (or link) field — e.g. **Structure → Content
   types → *(type)* → Manage form display**.
2. For the field you want a counter on, change its **widget** to one of Colored Field
   Counter's widgets:
   - the **simple** widget — then set the **recommended size**, **lower margin (%)**,
     and **lock input (%)**; or
   - the **complex** widget — then fill the three-row table with a **color** and a
     **lower/upper limit** per row.
3. Save the form display. When editors use that form, the field shows the live,
   color-coded character counter.
