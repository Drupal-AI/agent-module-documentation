# jQuery UI Autocomplete — manual setup guide

**jQuery UI Autocomplete** (`jquery_ui_autocomplete`) provides the jQuery UI
Autocomplete widget — a text field with a suggestions dropdown — as a Drupal asset
library, so that themes and modules can keep using it after it was removed from
Drupal core. Like its sibling library modules, it is a thin **library‑provider
module** with no features, screens, or settings of its own.

When Drupal core dropped its bundled jQuery UI libraries, each widget was moved
into a standalone contrib module. This one ships the `jquery.ui.autocomplete`
component and exposes it as the Drupal asset library
`jquery_ui_autocomplete/autocomplete`. Any module or theme that still needs the
jQuery UI autocomplete widget can depend on that library instead of the removed
core one. Because the autocomplete widget renders its suggestion list using the
menu widget, this module depends on **both** the base jQuery UI module and jQuery
UI Menu.

There is **nothing to configure**: no admin UI, no settings, no permissions, and
no plugins. Installing the module simply makes the library attachable. It supports
Drupal 9.2, 10, and 11 and exists for **backward compatibility** during the move
away from jQuery UI — new development should prefer native HTML autocomplete or a
modern JavaScript component.

This guide is written for a **human** installing the module. Because using the
library is a developer task, the attach‑and‑depend details live in the sibling
[`agent/`](../agent/start.md) docs, which are the terse, token‑cheap counterpart
aimed at an AI coding agent.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

jQuery UI Autocomplete has **no configuration page** (`configure` is null), no
admin menu items, and no permissions. Once enabled, the only thing it does is make
the `jquery_ui_autocomplete/autocomplete` asset library attachable.

## How to use it

You use this module from code, by attaching or depending on its library:

- **From a render array**, attach the library directly:

  ```php
  $build['#attached']['library'][] = 'jquery_ui_autocomplete/autocomplete';
  ```

- **From a theme or module `*.libraries.yml`**, declare it as a dependency of one
  of your own libraries:

  ```yaml
  my_component:
    dependencies:
      - jquery_ui_autocomplete/autocomplete
  ```

Because the module declares dependencies on both `jquery_ui_menu` and the base
`jquery_ui` libraries, the assets needed for the suggestion dropdown load first,
in the right order. If you are installing this only to satisfy another contrib
module that depends on the jQuery UI Autocomplete library, you don't need to
attach anything yourself — just enabling the module is enough.
