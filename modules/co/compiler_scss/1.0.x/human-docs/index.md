# SCSS Compiler — manual setup guide

**SCSS Compiler** (`compiler_scss`) adds an `scss` compiler to the
[Compiler](../../../compiler/1.0.x/human-docs/index.md) framework, so Drupal can
turn SCSS (Sass) source into CSS using pure PHP — no Node.js, no `sass` binary,
no external build step. It's backed by the `scssphp/scssphp` library, which does
the actual compilation, so the whole thing runs inside PHP on your server.

This is **developer infrastructure**, not a click-and-go feature. It has no admin
UI, no settings form, no routes and no permissions of its own (`configure:
null`). You wouldn't install it on its own; you install it because a theme or a
module wants to compile SCSS at runtime — for example a design-token module that
lets editors pick colours and font sizes and then recompiles the site's CSS from
shared SCSS partials. Alongside the compiler itself, the module ships a handy
bridge (`registerFunction()`) that exposes PHP values to your SCSS as real Sass
functions, plus a set of Drupal config-schema types and form elements
(`compiler_scss_color`, `compiler_scss_font_family`, `compiler_scss_number`,
`compiler_scss_unit`) for storing typed style values — a hex colour, a
font-family stack, a number with a unit like `16px` — as configuration.

Because it has nothing to configure through the UI, this guide covers only
installation plus a short summary of how developers drive it. The full compile
API, the swappable backend service and the PHP↔SCSS function bridge are covered
in the sibling [`agent/`](../agent/start.md) docs — the terse, token-cheap
references written for an AI coding agent. SCSS Compiler requires **PHP 8.3+**,
the **Compiler** module, and the `scssphp/scssphp` library (installed
automatically by Composer).

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   Compiler and `scssphp/scssphp`) and enable it. There is nothing to configure.

## Where it lives in the admin menu

Nowhere. SCSS Compiler has no admin page, settings form or menu entry. Its value
is available entirely to code, through the Compiler plugin manager and the
`compiler_scss.backend` service.

## How to use it

The module registers a compiler plugin with the id `scss`. A developer typically:

- **Compiles SCSS from code.** Ask the Compiler plugin manager for the `scss`
  compiler and hand it a context built from your inputs:

  ```php
  $compiler = \Drupal::service('plugin.manager.compiler')->createInstance('scss');
  $css = $compiler->compile($context);
  ```

  Inputs can be inline SCSS (`CompilerInputDirect`) or a file
  (`CompilerInputFile`), and options can carry an `import_path` so `@import` /
  `@use` statements resolve.

- **Exposes PHP data to SCSS.** The backend's `registerFunction()` bridges a
  native PHP callable into the compiler as a Sass function, with automatic
  type handling between colours, numbers/units, lists, maps, strings and
  booleans — so a theme or module can feed live data into a stylesheet.

- **Stores style values as typed config.** Use the shipped config-schema types
  and form elements to let an admin form collect a colour, a font-family, or a
  number-with-unit, then feed those values into a recompile.

See the [`agent/`](../agent/start.md) docs for the full API, the backend service
and the type-bridging details.
