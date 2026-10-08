# jQuery UI Accordion — manual setup guide

**jQuery UI Accordion** (`jquery_ui_accordion`) supplies the jQuery UI Accordion
widget to Drupal as an asset library, so themes and modules can attach collapsible
accordion panels. When Drupal core removed its bundled jQuery UI libraries, each
widget was split into its own contrib project — this is the one that provides the
Accordion widget.

It is a **thin dependency‑provider** module: there is no configuration UI, no
permissions, no plugins, and no services. All it does is declare a dependency on
the base **jQuery UI** module (`jquery_ui`, which ships the actual jQuery UI
assets) and re‑expose the accordion library so other code can depend on it. You
enable it purely so that a render array's `#attached` library, or a theme's
`libraries`/`libraries-extend` declaration, can reference the jQuery UI accordion
assets.

Because it's a pure library provider, it has **nothing to configure** — enabling it
is the whole setup. It works the moment it's on; the actual accordion behavior
comes from markup and a small piece of your own JavaScript that initializes
`.accordion()` on that markup.

Note that jQuery UI is no longer actively developed upstream. This module is
intended as a **compatibility bridge** — to keep legacy themes and contributed
modules that still rely on jQuery UI Accordion working on Drupal 9, 10, and 11 —
rather than a foundation for new UI work.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no settings page — this module simply makes an asset library available.
To actually use the accordion widget you attach the library and initialize it in
your own code:

1. **Attach the library** in a render array by adding
   `jquery_ui_accordion/accordion` to `#attached['library']`. Your markup should
   follow the accordion convention: alternating header elements (such as `<h3>`)
   and content `<div>`s inside the container you'll target.
2. **Initialize the widget** in a `Drupal.behaviors` script, calling
   `.accordion()` on your container — for example with `collapsible: true` and
   `heightStyle: 'content'`.

The underlying jQuery UI assets are provided by the base `jquery_ui` module; this
module only re‑exposes the accordion library. The sibling [`agent/`](../agent/start.md)
docs show the exact render‑array and JavaScript snippets.
