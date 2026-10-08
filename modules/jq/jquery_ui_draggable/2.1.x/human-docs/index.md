# jQuery UI Draggable — manual setup guide

**jQuery UI Draggable** (`jquery_ui_draggable`) restores a single piece of the old
jQuery UI library — the *Draggable* behavior — as a self-contained Drupal asset
library. Drupal 8 bundled all of jQuery UI in core, but jQuery UI is no longer
maintained and has been marked End of Life, so core deprecated and removed its
jQuery UI assets. This module carves out just the draggable component and ships it
as the library `jquery_ui_draggable/draggable`, so themes and modules that still
rely on drag behavior keep working on Drupal 10 and 11.

There is nothing to click here: the module has **no configuration UI, no
permissions, no services, and no plugins**. It exists purely to provide the library
asset. It depends on the `jquery_ui` base module, which supplies the underlying
jQuery UI core files — this module's own `libraries.yml` is an intentionally empty
stub that `jquery_ui` fills in at build time. Enable both modules and the library is
available for any theme or module to attach.

Because jQuery UI is End of Life, the maintainers recommend treating this as a
**compatibility bridge**: use it to keep existing code running today, and plan a
move to a modern drag‑and‑drop solution over time. It belongs to a family of
per‑component jQuery UI modules (Accordion, Button, Droppable, Slider, and so on)
that each restore one widget from the retired core library.

This guide is written for a **human** who is setting the module up. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its `jquery_ui` dependency.

## How to use it

This is a developer‑facing library module — you consume it from your own theme or
module's code; there is no admin screen.

**Depend on it from your own asset library.** In `mymodule.libraries.yml`:

```yaml
my_ui:
  js:
    js/my-ui.js: {}
  dependencies:
    - jquery_ui_draggable/draggable
```

**Attach it in a render array:**

```php
$build['#attached']['library'][] = 'jquery_ui_draggable/draggable';
```

**Then call `.draggable()` in your JavaScript**, for example inside a Drupal
behavior:

```js
(function ($, Drupal) {
  Drupal.behaviors.myDraggable = {
    attach: function (context) {
      $('.my-panel', context).draggable({ handle: '.my-panel__header' });
    }
  };
})(jQuery, Drupal);
```

**Migrating legacy code?** Replace any dependency on the old core library
`core/jquery.ui.draggable` with `jquery_ui_draggable/draggable`, and make sure both
the `jquery_ui` and `jquery_ui_draggable` modules are enabled.
