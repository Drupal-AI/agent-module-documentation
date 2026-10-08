# jQuery UI Menu — manual setup guide

**jQuery UI Menu** (`jquery_ui_menu`) provides the jQuery UI Menu widget as a
Drupal asset library, so that themes and modules can keep using it after it was
removed from Drupal core. It is a thin **library‑provider module** — it has no
features, screens, or settings of its own. Its whole purpose is to make one
JavaScript library attachable again.

When Drupal core deprecated and removed its bundled jQuery UI libraries, each
widget was split out into its own contrib module. This one ships the
`jquery.ui.menu` component — the JavaScript, CSS, and its dependencies — and
exposes it as the Drupal asset library `jquery_ui_menu/menu`. Any module or theme
that still relies on the jQuery UI Menu widget can declare a dependency on that
library instead of the removed core one.

There is **nothing to configure**: no admin UI, no settings, no permissions, and
no plugins. Installing the module simply makes the library available to attach. It
depends on the base **jQuery UI** module (`drupal/jquery_ui`), which vends the
jQuery UI core files, and it is itself a dependency of jQuery UI Autocomplete. It
supports Drupal 9.2, 10, and 11. It exists mainly for **backward compatibility**
during the transition away from jQuery UI — new development is encouraged to use
native browser features or modern JavaScript instead.

This guide is written for a **human** installing the module. Because using the
library is a developer task, the attach‑and‑depend details live in the sibling
[`agent/`](../agent/start.md) docs, which are the terse, token‑cheap counterpart
aimed at an AI coding agent.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

jQuery UI Menu has **no configuration page** (`configure` is null), no admin menu
items, and no permissions. Once enabled, the only thing it does is make the
`jquery_ui_menu/menu` asset library attachable.

## How to use it

You use this module from code, by attaching or depending on its library:

- **From a render array**, attach the library directly:

  ```php
  $build['#attached']['library'][] = 'jquery_ui_menu/menu';
  ```

- **From a theme or module `*.libraries.yml`**, declare it as a dependency of one
  of your own libraries:

  ```yaml
  my_component:
    dependencies:
      - jquery_ui_menu/menu
  ```

Because the module declares its own dependency on the base `jquery_ui` library,
the required jQuery UI core assets are guaranteed to load first. If you are
installing this only to satisfy another contrib module that depends on the jQuery
UI Menu library, you don't need to attach anything yourself — just enabling the
module is enough.
