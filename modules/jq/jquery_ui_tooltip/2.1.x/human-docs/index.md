# jQuery UI Tooltip — manual setup guide

**jQuery UI Tooltip** (`jquery_ui_tooltip`) re‑provides the single jQuery UI
*Tooltip* widget as a standalone Drupal asset library. Drupal core used to bundle all
of jQuery UI, but jQuery UI reached end‑of‑life upstream, so core deprecated and then
removed it. This module is one of the split‑out companion projects (built on the
shared `jquery_ui` base module) that bring back just one widget — here, the tooltip —
so legacy code that calls `.tooltip()` keeps working after a core upgrade.

There is nothing to click and nothing to configure. The module ships essentially
only an info file; enabling it makes one attachable library available,
`jquery_ui_tooltip/tooltip`, which bundles jQuery UI 1.13.2's `tooltip-min.js` and
the base‑theme `tooltip.css`. You attach that library wherever you need the widget —
from a render array, or as a dependency of your own theme or module library — and
then call `.tooltip()` in your JavaScript. Its dependencies (jQuery, and the
`jquery_ui` widget/position helpers) load automatically in the right order.

Because jQuery UI itself is no longer maintained upstream, the maintainers recommend
using this module only to keep *existing* code working, and choosing a modern,
maintained tooltip solution for anything new. This is a developer‑facing library, not
a site‑builder feature — there is no admin UI, no permissions, and no services.

This guide is written for a **human** developer. If you want terse, token‑cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer (it
   pulls in the `jquery_ui` base module) and enable it.

There is no configuration page; how to attach and use the library is in *How to use
it* below.

## Where it lives in the admin menu

Nowhere — this module has **no admin UI, no permissions, and no settings**. Its
entire surface is the attachable library `jquery_ui_tooltip/tooltip`.

## How to use it

**1. Enable the module** (see [Installation](installation/index.md)). This also
requires the `jquery_ui` base module, which supplies the underlying helper libraries.

**2. Attach the library where you need it.** From a render array in PHP:

```php
$build['#attached']['library'][] = 'jquery_ui_tooltip/tooltip';
```

Or make one of your own libraries depend on it, so Drupal loads the widget, its CSS,
and the whole `jquery_ui/*` dependency chain in the correct order:

```yaml
# my_module.libraries.yml
my_widget:
  js:
    js/my-widget.js: {}
  dependencies:
    - jquery_ui_tooltip/tooltip
```

**3. Initialise the widget in a behavior:**

```js
// js/my-widget.js
(function ($, Drupal, once) {
  Drupal.behaviors.myTooltip = {
    attach(context) {
      $(once('my-tooltip', '[title]', context)).tooltip();
    }
  };
})(jQuery, Drupal, once);
```

**Migration note:** if you are upgrading older code, replace any reference to the
removed core library `core/jquery.ui.tooltip` with `jquery_ui_tooltip/tooltip`.
Enabling the module and attaching the library is the entire task — there is nothing
else to set up.
