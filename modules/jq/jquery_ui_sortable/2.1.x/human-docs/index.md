# jQuery UI Sortable — manual setup guide

**jQuery UI Sortable** (`jquery_ui_sortable`) is a compatibility shim. It
re-supplies the jQuery UI *Sortable* asset library — the drag-and-drop reordering
widget that Drupal core used to ship as `core/jquery.ui.sortable` — after core
deprecated and removed it. If you have a legacy theme or module that reorders
elements with `.sortable()`, this module keeps it working on Drupal 10 and 11.

There is nothing to configure. The module simply declares one asset library id,
`jquery_ui_sortable/sortable`. The real jQuery UI files come from the base
**jQuery UI** (`jquery_ui`) module, which this module depends on; jQuery UI fills in
the actual `sortable-min.js` asset at build time. To use it, you point any code that
referenced the removed `core/jquery.ui.sortable` at `jquery_ui_sortable/sortable`
instead — either by attaching the library to a render array, or by listing it as a
dependency in a theme/module `*.libraries.yml`.

A word of caution from the maintainers: jQuery UI is end-of-life and no longer
maintained. Core replaced Sortable with **SortableJS**, and that is what you should
use for new code. This module exists only to keep legacy code alive during a
migration, not to encourage new use of jQuery UI. It has no configuration UI, no
permissions, no services, no plugins, and no PHP API — its entire surface is that
one library id.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its jQuery UI
   dependency) with Composer and enable it.

## Where it lives in the admin menu

Nowhere — there is no admin page, settings form, or configuration. The module's
whole job is to make the `jquery_ui_sortable/sortable` library available.

## How to use it

Once the module (and `jquery_ui`) are enabled, attach the library wherever you need
drag-and-drop reordering.

In a render array:

```php
$build['#attached']['library'][] = 'jquery_ui_sortable/sortable';
```

Site-wide from a hook:

```php
function mymodule_page_attachments(array &$attachments) {
  $attachments['#attached']['library'][] = 'jquery_ui_sortable/sortable';
}
```

As a dependency in your `mytheme.libraries.yml` / `mymodule.libraries.yml`:

```yaml
my_widget:
  js:
    js/my-widget.js: {}
  dependencies:
    - jquery_ui_sortable/sortable
```

**Migrating legacy code** is a one-line swap: replace every reference to the removed
`core/jquery.ui.sortable` with `jquery_ui_sortable/sortable`. The JavaScript API
(`$('…').sortable({…})`, the `start` / `update` / `stop` events, connected lists via
`connectWith`) is unchanged, because the underlying vendored jQuery UI files are the
same. See the [`agent/` library docs](../agent/api/library.md) for the exact
details.
