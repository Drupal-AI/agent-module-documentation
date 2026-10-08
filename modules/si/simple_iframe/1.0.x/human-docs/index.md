# Simple IFrame — manual setup guide

**Simple IFrame** (`simple_iframe`) is the most basic way to let editors embed an
`<iframe>` on your site through a field. It adds a `simple_iframe` field type that
stores three values — a **URL**, a **width**, and a **height** — along with a
matching edit widget and a formatter that renders a real `<iframe>` pointing at the
stored URL. Add the field to any content type (or any other fieldable entity), and
editors get three simple text boxes to paste an embed URL and set its size.

The output is deliberately template‑driven: the formatter renders each item through
a small Twig template (`simple-iframe.html.twig`) that produces
`<div class="simple-iframe"><iframe src="…" width="…" height="…">…</iframe></div>`.
Because it is a template, your theme can override the markup to add attributes like
`title`, `loading="lazy"`, or a `sandbox`, or to wrap the iframe in a responsive
aspect‑ratio container.

There is no global settings page, no permissions, and no configuration entity —
everything is ordinary field configuration on a bundle. The width defaults to
`100%` for responsiveness and the height is set per field. It works on Drupal 8, 9,
10, and 11, and depends only on core's **Field** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You configure Simple IFrame entirely through
the **Field UI**: add a field of type *Simple IFrame* to a bundle at **Structure →
Content types →** *(your type)* **→ Manage fields**, then tune its display under
**Manage display** and its edit widget under **Manage form display**.

## How to use it

1. Go to **Manage fields** on the bundle you want (for example a content type,
   taxonomy term, paragraph, or media type) and **Add field**.
2. Choose the **Simple IFrame** field type and give it a label.
3. On the field settings, set the default **width** (defaults to `100%` for a
   responsive embed) and default **height** ("set a number or %"). These become the
   pre‑filled defaults for new items.
4. Optionally, under **Manage form display**, adjust the widget's URL textfield
   **size** (default 100).
5. When editing content, editors paste an iframe URL (the field accepts
   protocol‑relative `//example.com/…` URLs using the `//` placeholder convention)
   and optionally override the width and height per item.

The field is multi‑value capable, so you can add several embeds to one entity. To
change the rendered markup, copy `simple-iframe.html.twig` into your theme's
`templates/` directory and edit it — the `url`, `width`, and `height` variables
come straight from the field item, and the template already includes a "Your
browser does not support iframes" fallback message. Style the wrapper with the
`.simple-iframe` CSS class.
