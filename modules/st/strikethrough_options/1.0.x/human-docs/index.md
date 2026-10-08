# Strikethrough Options — manual setup guide

**Strikethrough Options** (`strikethrough_options`) is a small field widget that
renders radio-button or checkbox options with a **strikethrough** style, in a color
you choose. It is handy when you want to show that certain choices are crossed
out — deprecated, sold out, or otherwise unavailable — while keeping the options
list's normal behaviour intact. You can pick from four colors: **black**, **red**,
**green**, or **blue**.

Under the hood the widget extends Drupal's core options widget, so it applies to the
usual options-style fields: boolean, entity reference (and entity reference
revisions), and the list field types (`list_string`, `list_integer`,
`list_float`). It adds a CSS class to the options and ships a small stylesheet that
draws the strikethrough in the selected color — there is no server-side logic beyond
rendering, no routing, and no permissions, so it has no security surface.

The module works entirely through Drupal's **Manage form display** screen: you
select the *"Check boxes/radio buttons - Strikethrough"* widget on a compatible
field and choose the color. There is no separate admin settings page. It has no
dependencies beyond Drupal core and supports Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. Make sure you have a compatible field — typically a **List** field (for example
   `list_string`) on a content type, but boolean and entity-reference fields work
   too.
2. Go to that entity's **Manage form display** (for a content type:
   **Structure → Content types → *Type* → Manage form display**).
3. For the field, choose the **Check boxes/radio buttons - Strikethrough** widget
   from the widget dropdown.
4. Open the widget's settings (the gear icon) and pick a **strikethrough color** —
   black, red, green, or blue.
5. Save. The field's options now render with the strikethrough style while
   behaving like normal checkboxes or radios.
