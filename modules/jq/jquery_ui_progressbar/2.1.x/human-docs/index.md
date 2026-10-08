# jQuery UI Progressbar — manual setup guide

**jQuery UI Progressbar** (`jquery_ui_progressbar`) is a thin "enabler" module
that makes the jQuery UI Progressbar widget available again as a Drupal asset
library. Drupal core used to bundle the jQuery UI libraries, but core deprecated
and removed them and split each widget into its own contrib module. This module
is the shim for the Progressbar widget: enable it, and the asset library
`jquery_ui_progressbar/progressbar` (jQuery UI 1.13.2) becomes attachable from
your code.

The module itself ships no PHP, JavaScript, configuration, permissions, or
routes — only an `info.yml` that depends on the base `jquery_ui` module. The
actual progressbar assets physically live inside `jquery_ui`, and enabling this
module is what registers the `jquery_ui_progressbar/progressbar` library id so it
can be attached. When you attach it, it automatically pulls in its jQuery and
jQuery UI dependencies.

This is a **developer / library module** — there is no admin screen and nothing
to configure. You use it by attaching the library from a render array, a
`*.libraries.yml` dependency, or a Twig template, then driving the widget in your
own JavaScript. Note that jQuery UI is unmaintained upstream; for new work prefer
a native HTML `<progress>` element or a modern component, and use this only to
keep legacy `$.ui.progressbar` code running on Drupal 10/11.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once the module is enabled, attach the library wherever you need the widget.

Render array:

```php
$build['#attached']['library'][] = 'jquery_ui_progressbar/progressbar';
```

Another module or theme's `*.libraries.yml`:

```yaml
my_widget:
  dependencies:
    - jquery_ui_progressbar/progressbar
```

Twig template:

```twig
{{ attach_library('jquery_ui_progressbar/progressbar') }}
<div id="progress"></div>
```

Then drive the widget in your JavaScript:

```js
// Determinate
$('#progress').progressbar({ value: 37 });
$('#progress').progressbar('value', 60);   // update the value

// Indeterminate / loading
$('#progress').progressbar({ value: false });

// Events
$('#progress').progressbar({ change: function () {}, complete: function () {} });
```

Placement and values are entirely up to the attaching code — the module has no
settings of its own.
