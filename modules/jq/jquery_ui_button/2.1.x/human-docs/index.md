# jQuery UI Button — manual setup guide

**jQuery UI Button** (`jquery_ui_button`) re‑provides the single jQuery UI Button
widget as a standalone Drupal asset library, after jQuery UI was deprecated and
removed from Drupal core. Install it and attach the `jquery_ui_button/button`
library wherever your themes, modules, or legacy custom code still call
`$.fn.button()`. The Button widget also covers the legacy `buttonset()` behavior,
so there is no separate `buttonset` library to worry about.

Core historically bundled the jQuery UI Button widget, but jQuery UI is no longer
maintained (marked End of Life by the OpenJS Foundation), so core removed it.
This module ships just the Button piece so existing code keeps working. It
carries **no PHP logic, no configuration, no permissions, and no services** — the
library is actually registered on its behalf by the base `jquery_ui` module,
which is why this module depends on it. Unlike most of the split‑out widget
modules, the Button widget also needs the Controlgroup and Checkboxradio widgets,
so this module additionally depends on `jquery_ui_controlgroup` and
`jquery_ui_checkboxradio`; those are pulled in automatically.

As with the rest of the jQuery UI contrib family, the maintainers recommend
migrating off jQuery UI to a maintained alternative rather than taking on new
dependencies — treat this as a **compatibility bridge**.

This guide is written for a **human** (site builder or front‑end developer). If
you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — there is nothing to configure. The module only provides an asset
library for developers to attach.

## How to use it

Once enabled, attach the library `jquery_ui_button/button` where you need it. In
a render array:

```php
$build['#attached']['library'][] = 'jquery_ui_button/button';
```

From your own module or theme `*.libraries.yml`:

```yaml
my_module/my_lib:
  dependencies:
    - jquery_ui_button/button
```

Or depend on the module itself from a custom module's `*.info.yml`:

```yaml
dependencies:
  - jquery_ui:jquery_ui_button
```

The library declares its own dependencies — `core/jquery`,
`jquery_ui_controlgroup/controlgroup`, `jquery_ui_checkboxradio/checkboxradio`,
`jquery_ui/widget`, and internal helpers — so you do not attach those yourself.
When migrating legacy code, replace old `core/jquery.ui.button`‑style references
with `jquery_ui_button/button`.
