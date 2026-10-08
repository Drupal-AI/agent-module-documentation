# Custom Checkboxes — manual setup guide

**Custom Checkboxes** (`custom_checkboxes`) provides styling for checkbox form
elements, replacing the default browser checkbox with a styled, consistent version
so your forms look the same across browsers and match your site's branding. It is
purely a front‑end theming feature: it changes how checkboxes *look*, not how forms
*behave* — no change to form data, submission, or access.

The module ships a CSS/JS library you attach where you have checkboxes, then adapt
the CSS to your own design. It works on Drupal 8.7.7 through 11 and has no module
or library dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
use it by attaching its library in your Twig templates and editing the CSS, as
described in "How to use it" below.

## How to use it

Custom Checkboxes styles nothing on its own until you attach its library in the
Twig template(s) where checkboxes appear. Add this line to the relevant template:

```twig
{{ attach_library('custom_checkboxes/custom_checkboxes') }}
```

Once the library is attached, the checkboxes on that template render with the
module's styled appearance. To match your brand, override or adapt the module's CSS
in your own theme — the intent is that you copy the provided styles and tune the
colours, sizes, and states to your needs.
