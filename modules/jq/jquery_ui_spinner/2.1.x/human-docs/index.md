# jQuery UI Spinner — manual setup guide

**jQuery UI Spinner** (`jquery_ui_spinner`) re-publishes the jQuery UI *Spinner*
widget — the little number input with up/down stepper arrows — as an attachable
Drupal asset library. jQuery UI's individual widgets were removed from Drupal
core, so contrib modules like this one bring them back for themes and modules that
still rely on them.

There is nothing to click and nothing to configure. The module carries no code of
its own: it is a thin metapackage whose only job is to make the library
`jquery_ui_spinner/spinner` (jQuery UI 1.13.2) available for you to attach. The
actual asset files live in the `jquery_ui` module, which this module depends on
along with `jquery_ui_button`. Once enabled, you attach the library from your own
module or theme and then call `.spinner()` on an input in your JavaScript.

Because upstream jQuery UI itself is end-of-life, treat this as a **compatibility
bridge** for legacy code rather than a foundation for new work.

This guide is written for a **human** developer. If you want a terse, token-cheap
reference for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (its two dependencies come along automatically).

## Where it lives in the admin menu

Nowhere — there is no settings form, no permissions, and no admin page. The module
does its job purely by providing an asset library.

## How to use it

Enable the module, then attach the `jquery_ui_spinner/spinner` library wherever you
need the widget.

From a render array or `#attached` in PHP:

```php
$build['#attached']['library'][] = 'jquery_ui_spinner/spinner';
```

Or as a dependency of one of your own libraries in `mymodule.libraries.yml`:

```yaml
my-widget:
  js:
    js/my-widget.js: {}
  dependencies:
    - jquery_ui_spinner/spinner
```

Then initialize the widget in your JavaScript:

```js
$('#my-number-input').spinner({ min: 0, max: 100, step: 1 });
```

Attach the library only on the pages or forms that need it, rather than site-wide,
to keep other pages lean.
