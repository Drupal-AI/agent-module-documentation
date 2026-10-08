# CKeditor Responsive Plugin — manual setup guide

**CKeditor Responsive Plugin** (`ckeditor_responsive_plugin`) adds a
**Responsive Area** button to the CKEditor 5 toolbar. Clicking it inserts
column/grid `<div>` blocks into rich‑text content, so editors can build
responsive, multi‑column layouts right inside the body field — without resorting
to tables.

The inserted blocks carry standard responsive CSS classes: column classes like
`onecol`, `twocol`, `threecol`, and grid classes like `grid-1`, `grid-2`. Your
theme styles those classes into an actual responsive layout, and the module ships
a `css/responsivearea.css` file with a working default if your theme doesn't
already define them (they also map cleanly onto Bootstrap‑style grid classes).

This is a lightweight layout tool for the cases where full Layout Builder is
overkill — reusable two‑, three‑, or four‑column primitives inside a rich‑text
field, kept as semantic `<div>`s with classes rather than inline styles. The
module has no settings page of its own; you turn it on per text format using
Drupal's normal CKEditor 5 configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it requires core CKEditor 5).

## Where it lives in the admin menu

There's no dedicated settings page. You enable the button through core's text
format configuration at **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`).

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors** and
   edit a text format that uses **CKEditor 5** (for example *Full HTML*).
2. In the CKEditor 5 toolbar configuration, drag the **Responsive Area** button
   from *Available buttons* into the *Active toolbar*.
3. If the format uses **"Limit allowed HTML tags and correct faulty HTML"**, add
   `<div class>` (and the column/grid classes you need) to the allowed tags so
   the inserted markup isn't stripped out. The plugin also needs `<h2>` and
   `<div>` to be permitted.
4. Save the format. Editors using that format now see the Responsive Area button
   and can insert responsive column/grid blocks.

If the classes don't render responsively on the front end, make sure your theme
styles them — or copy the rules from the bundled `css/responsivearea.css` into
your theme.
