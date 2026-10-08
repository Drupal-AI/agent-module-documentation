# jQuery UI Checkboxradio — manual setup guide

**jQuery UI Checkboxradio** (`jquery_ui_checkboxradio`) is a small developer
module that re‑provides a single jQuery UI widget — the **Checkboxradio** widget —
as an asset library. Drupal core used to bundle jQuery UI, but jQuery UI reached
end of life upstream and core removed it, so this module ships just the
Checkboxradio piece separately. That keeps existing themes, modules and custom
code that call `$.fn.checkboxradio()` (which styles checkboxes and radio buttons as
themed jQuery UI widgets) working after a core upgrade.

There is nothing to configure and nothing appears in the admin UI. The module has
no settings form, no permissions, and no services — in fact it has no PHP code of
its own. You install it, and then you **attach the library** wherever you need the
widget. The library is registered on the module's behalf by the base `jquery_ui`
module (which is why this module depends on it), and it bundles the vendored jQuery
UI 1.13.2 `checkboxradio-min.js` plus its base theme CSS.

A word of caution: jQuery UI is no longer maintained. This module exists to bridge
legacy code during a migration — for new work, the maintainers recommend moving off
jQuery UI to a maintained alternative rather than taking on this dependency.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — this module has no admin pages, no settings and no permissions. It only
makes an asset library available for developers to use.

## How to use it

The library id is `jquery_ui_checkboxradio/checkboxradio`. Attach it in whichever
way suits your code.

In a render array via `#attached`:

```php
$build['#attached']['library'][] = 'jquery_ui_checkboxradio/checkboxradio';
```

As a dependency of your own module or theme library, in a `*.libraries.yml` file:

```yaml
my_module/my_lib:
  dependencies:
    - jquery_ui_checkboxradio/checkboxradio
```

Or depend on the module itself from a custom module's `*.info.yml`:

```yaml
dependencies:
  - jquery_ui:jquery_ui_checkboxradio
```

You do not need to attach the widget's own dependencies (`core/jquery`,
`jquery_ui/widget` and a few internal jQuery UI helpers) — they are pulled in
automatically. If you are replacing an old reference, swap
`core/jquery.ui.checkboxradio` for `jquery_ui_checkboxradio/checkboxradio`.
