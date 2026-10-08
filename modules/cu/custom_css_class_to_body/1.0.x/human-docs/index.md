# Custom CSS Class to Body — manual setup guide

**Custom CSS Class to Body** (`custom_css_class_to_body`) adds custom CSS classes to
the page's `<body>` element for specific nodes and specific content types. That
gives themers and site builders a clean styling hook: instead of writing a
preprocess function to put a class on the body, you configure the class here and
target it from your theme's CSS — for example, giving every *Landing page* node a
distinctive body class, or flagging one particular node so its page can be styled
differently.

It is a purely presentational feature. The classes it adds change the body markup
only; they have no effect on content, data, or access. The module has no
third‑party dependencies and works on Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no standalone settings page documented for this module; you configure the
body classes for the nodes and content types you care about as described in "How to
use it" below.

## How to use it

Once enabled, the module lets you associate CSS classes with:

- **Specific content types** — every node of that type gets the class on its
  `<body>`, so you can style, say, all *Article* pages or all *Landing page* nodes
  together.
- **Specific node pages** — a single node gets its own class, for when one page
  needs distinct styling.

Configure the classes for the relevant content types and nodes, then reference those
classes from your theme's CSS. Because the classes land on `<body>`, they make handy
top‑level scopes for page‑specific styling (`body.my-landing-page .hero { … }`)
without any custom preprocessing.
