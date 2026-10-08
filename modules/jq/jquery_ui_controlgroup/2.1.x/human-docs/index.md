# jQuery UI Controlgroup — manual setup guide

**jQuery UI Controlgroup** (`jquery_ui_controlgroup`) re‑exposes the jQuery UI
Controlgroup widget as a Drupal asset library, so themes and modules can group
related form buttons and inputs into a single, visually connected control.

Some background: Drupal core used to bundle the whole jQuery UI library, but core
removed it and split each widget into its own contributed project. This module is
the one that brings back the Controlgroup widget. It is a **thin
dependency‑provider** — it declares a dependency on the base `jquery_ui` module
(which ships the actual jQuery UI assets) and registers the
`jquery_ui_controlgroup/controlgroup` asset library so your code can depend on it.

The module has **no configuration UI, no permissions, no plugins, and no services**
— in fact it contains only an `.info.yml` file. You enable it purely so that a
render array's `#attached` or a theme's library declaration can reference the
Controlgroup assets, and then you initialize `.controlgroup()` on your markup in
your own JavaScript. Because jQuery UI is no longer actively developed upstream,
treat this as a **compatibility bridge** for legacy code rather than a foundation
for new work.

This guide is written for a **human** (site builder or front‑end developer). If
you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — there is no admin page or settings for this module. It only provides an
asset library for developers to attach.

## How to use it

Once enabled, reference the library `jquery_ui_controlgroup/controlgroup` from
your code. In a render array:

```php
$build['content'] = [
  '#type' => 'markup',
  '#markup' => $html,               // your grouped controls (buttons / inputs)
  '#attached' => [
    'library' => ['jquery_ui_controlgroup/controlgroup'],
  ],
];
```

Or as a dependency in your own `*.libraries.yml`:

```yaml
my_widget:
  version: 1.x
  js:
    js/my-widget.js: {}
  dependencies:
    - jquery_ui_controlgroup/controlgroup
```

Then initialize the widget in a Drupal behavior:

```js
(function ($, Drupal) {
  Drupal.behaviors.myControlgroup = {
    attach: function (context) {
      $(once('myControlgroup', '.my-controls', context)).controlgroup({
        direction: 'horizontal',   // or 'vertical'
      });
    },
  };
})(jQuery, Drupal);
```

The jQuery UI assets themselves (`controlgroup-min.js` and `controlgroup.css`)
are served by the base `jquery_ui` module, and the required dependencies
(`core/jquery`, `jquery_ui/widget`, and internal helpers) are attached
automatically. Controlgroup pairs well with `jquery_ui_checkboxradio` when you're
grouping styled radios and checkboxes.
