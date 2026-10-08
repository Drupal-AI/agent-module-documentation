# CSS Size Field — manual setup guide

**CSS Size Field** (`css_size_field`) adds a **field type for storing a CSS size**
— a length value together with its unit, such as `20px`, `1.5rem`, or `100%`. It
is made up of two parts, a **number** and a **unit**, and ships with a default
widget for editing and a default formatter for display. Use it whenever editors
need to capture a size that will later feed a template or some styling — a card
width, a spacing value, a max‑height, and so on — as structured content rather
than free text.

It is a content‑editing/field module with no access‑control role. It requires no
other modules and works on Drupal 10, 11, and 12.

One thing to keep in mind for developers: when a stored size is emitted into CSS
or an inline `style` attribute in a template, output it as a validated/sanitized
value rather than concatenating it raw, so that field data can't become a CSS
injection vector.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no module settings page** — you add and configure the field on an
entity like any other Drupal field, as described in "How to use it" below.

## Where it lives in the admin menu

CSS Size Field adds no admin settings page. You use it through the standard Field
UI at **Structure → Content types → *(type)* → Manage fields** (and the matching
**Manage form display** / **Manage display** tabs).

## How to use it

1. Go to **Structure → Content types → *(type)* → Manage fields** (or the fields
   list of any fieldable entity) and click **Add field**.
2. Choose the **CSS Size** field type and give it a label.
3. Save the field settings. On **Manage form display**, editors will get the CSS
   Size widget — a number input paired with a unit selector.
4. On **Manage display**, the default CSS Size formatter renders the stored
   value (number + unit) for output.
