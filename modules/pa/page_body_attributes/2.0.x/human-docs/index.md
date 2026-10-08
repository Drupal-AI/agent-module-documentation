# Page Body Attributes — manual setup guide

**Page Body Attributes** (`page_body_attributes`) lets you add specific HTML
attributes — such as classes or `data-` attributes — to the page's `<body>`
element, without writing a custom preprocess hook. Those attributes then give your
theme's CSS and your JavaScript a reliable hook to target the whole page.

It is a lightweight theming helper: you configure the attribute values you want on
`<body>`, and the module writes them into the body markup. This is the kind of
thing you would otherwise implement in a `hook_preprocess_html()` in a custom
module, made available without any code.

The module has no dependencies beyond Drupal core and works across Drupal 8.8
through 11. Because the values are output directly into the page's markup, keep
them in the hands of trusted administrators — treat them like any other attribute
value that ends up in your HTML.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated configuration page** documented for this module in the
knowledge base — it is a simple theming helper for adding attributes to `<body>`.
Set the attribute values you need and confirm they appear in the page markup, as
described below.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Enter the body attributes you want — classes or `data-` attributes to be
   applied to the page `<body>` element.
3. Load a page and view its source: the `<body>` tag should now carry the classes
   or attributes you set, ready for your theme's CSS or JavaScript to target.
