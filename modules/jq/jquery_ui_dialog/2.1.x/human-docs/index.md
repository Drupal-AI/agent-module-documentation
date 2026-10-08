# jQuery UI Dialog — manual setup guide

**jQuery UI Dialog** (`jquery_ui_dialog`) is a small "shim" module. Its only job
is to re-provide the jQuery UI **dialog** asset library that Drupal core used to
ship as `core/jquery.ui.dialog` and has since deprecated and removed. If you have
older custom or contrib code that calls `$('#el').dialog()` or otherwise depends on
that library, this module keeps it working on Drupal 9.2, 10, and 11 without you
having to rewrite anything.

There is almost nothing to it: the 2.1.x release is essentially just an
`info.yml`, a `composer.json`, and a licence file — **no settings, no permissions,
no routes, no admin page.** Enabling it (and its dependencies) gives your site a
`jquery_ui_dialog/dialog` library that you can attach or depend on, backed by the
vendored jQuery UI 1.13.2 assets that the base `jquery_ui` module carries. It pulls
in the button, draggable, and resizable widgets the dialog needs, so a single
dependency gets you the full draggable/resizable modal behaviour.

A word of context: jQuery UI is end-of-life upstream. Use this module to keep
legacy dialog code alive while you migrate, but for **new** code prefer Drupal
core's own dialog system (`core/drupal.dialog`, `core/drupal.dialog.ajax`, and the
`OpenModalDialogCommand` AJAX command).

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent (including the exact library id and how to attach it), read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

## Where it lives in the admin menu

Nowhere — this module adds no admin pages, permissions, or settings. Enabling it is
the entire setup.

## How to use it

The module exposes one asset library, `jquery_ui_dialog/dialog`, for developers to
attach:

- From a render array or form:
  `$build['#attached']['library'][] = 'jquery_ui_dialog/dialog';`
- From a Twig template: `{{ attach_library('jquery_ui_dialog/dialog') }}`
- As a dependency in your own `*.libraries.yml`:

  ```yaml
  my-dialog-ui:
    version: 1.x
    js:
      js/my-dialog.js: {}
    dependencies:
      - jquery_ui_dialog/dialog
  ```

If you are migrating away from the removed core library, it is a one-line
search-and-replace: change `core/jquery.ui.dialog` to `jquery_ui_dialog/dialog`
(and the sibling `core/jquery.ui.button` → `jquery_ui_button/button`,
`core/jquery.ui.draggable` → `jquery_ui_draggable/draggable`,
`core/jquery.ui.resizable` → `jquery_ui_resizable/resizable`). Drupal resolves all
the transitive dependencies for you — you never attach them individually.
