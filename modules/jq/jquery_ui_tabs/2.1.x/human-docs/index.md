# jQuery UI Tabs — manual setup guide

**jQuery UI Tabs** (`jquery_ui_tabs`) re-provides the classic jQuery UI **Tabs**
widget as a Drupal asset library. Drupal core used to bundle this widget as part
of `core/jquery.ui`, but jQuery UI is no longer maintained and was deprecated and
removed from core. Any theme or custom code that relied on the tabs widget would
break — this small companion module restores exactly that one widget so legacy
code keeps working.

There is almost nothing to this module: it ships **no settings page, no
permissions, no services, and no PHP of its own**. It simply carries the assets
and depends on the base **jQuery UI** (`jquery_ui`) module, which declares the
actual library on its behalf. After enabling it, you attach the library id
`jquery_ui_tabs/tabs` to a render array (or depend on it from your own
`*.libraries.yml`) and initialize `.tabs()` in your own JavaScript. The library
loads the minified tabs widget plus its base CSS and pulls in the jQuery UI
helper libraries it needs.

A word of caution: jQuery UI is **End‑of‑Life** upstream. The maintainers
recommend migrating tabbed interfaces off jQuery UI to a maintained alternative
rather than adding new dependencies on it. This module exists to keep existing
code running during that transition — not as a foundation for new work.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has no configuration UI, so there is no configuration page — see
*How to use it* below.

## Where it lives in the admin menu

jQuery UI Tabs has **no admin menu item and no settings form**. It is a library
provider: enabling it makes the `jquery_ui_tabs/tabs` library available for code
to attach. Nothing appears in the administration UI.

## How to use it

Attach the library to any render array that needs the tabs widget:

```php
$build['#attached']['library'][] = 'jquery_ui_tabs/tabs';
```

Or declare a dependency on it from your own module's or theme's
`*.libraries.yml` file. Then initialize the widget in your own JavaScript
behavior by calling `.tabs()` on the appropriate markup. The library id is
always `jquery_ui_tabs/tabs`; it loads the tabs JavaScript and base theme CSS
and depends on the base `jquery_ui` assets, so those are always present.
