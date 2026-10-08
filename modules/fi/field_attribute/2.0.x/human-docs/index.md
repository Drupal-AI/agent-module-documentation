# Field Attribute — manual setup guide

**Field Attribute** (`field_attribute`) lets you add **extra HTML attributes** to a
text field's rendered output — without writing a custom template or preprocess
hook. If you need a `class`, a `data-*` attribute, or similar markup metadata on a
field so your theme, JavaScript, or an integration can hook onto it, this module
adds those options right in the field's formatter settings.

It is a fields / theming feature: it affects the markup and attributes of the
field's output, not its content and not access. The attribute values are set by an
administrator, so — as with any attribute output — keep them trusted.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page** — attributes are set per field's formatter,
as described in "How to use it" below.

## How to use it

The attribute settings live on each text field's **formatter**, on the *Manage
display* tab:

1. Go to **Structure → (content type, user, or other entity) → Manage display**.
   Field Attribute works for content types, users, and other fieldable entities.
2. Find the text field you want, and click the **gear / edit** button for its
   formatter to reveal the formatter settings.
3. Use the **options** element that Field Attribute adds to enter the extra HTML
   attributes for that field.
4. **Save** the display, then reload a page that shows the field to see the
   attributes in the rendered markup.
