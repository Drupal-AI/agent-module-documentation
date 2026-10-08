# Single File Components — manual setup guide

**Single File Components** (`sfc`) lets developers build frontend components where the
Twig template, CSS, JavaScript and a bit of PHP all live together in a single file.
The PHP portion acts much like a preprocess function. The aim is to bring some of the
ergonomics of component-based design to traditional Drupal theming — keeping
everything a component needs in one place instead of scattered across templates,
libraries and preprocess hooks.

Once you've written a component you use it like any other template — for example
`{% include "sfc--say-hello.html.twig" %}`. Components can be defined as PHP classes
or as `.vue`-style `.sfc` files. The module generates each component's library
definition automatically and attaches it for you, so you don't hand-write
`*.libraries.yml` entries. JavaScript placed in the component's `ATTACH` constant is
automatically wrapped in a Drupal behavior and a `jQuery.once` call. You can also
derive blocks, layouts and field formatters from components via annotations, and
provide backend actions without writing a route or controller. Because components are
Drupal plugins, you can extend, derive and alter them, and they support dependency
injection so they can be unit tested.

This is squarely a **developer/theming framework**, not a click-together feature.
There is no configuration UI — you work with it by writing component files. It
renders content through Drupal's normal layers and has no access-control role of its
own. It has no dependencies, ships `sfc_dev` and `sfc_example` submodules, and
provides Drush commands. PHP 7+ is required if you define the `LIBRARY` or
`DEPENDENCIES` constants. Supports Drupal 9, 10 and 11.

This guide is written for a **human** getting the module installed. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and pick
   the submodules you need.

## How to use it

There's no admin form. After enabling, you write components as PHP classes or `.sfc`
files and include them in your templates like normal Twig partials. The best
technical reference is the module's own `README.md`, and the **`sfc_example`**
submodule ships working example components to learn from. There is also a live
component library at **`/sfc/library`** where you can browse and stress-test
components while developing.
