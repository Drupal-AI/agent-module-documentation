# SCSS/Less Compiler — manual setup guide

**SCSS/Less Compiler** (`scss_compiler`) compiles the `.scss` (Sass) or `.less`
files your theme or module declares in its `*.libraries.yml` into CSS
automatically — so you can ship Sass sources instead of hand-built CSS, and edit
styles without running a Node/webpack build. It uses the bundled **scssphp** PHP
compiler, so there's no Node toolchain to install.

It hooks straight into Drupal's asset pipeline: when a library lists a `.scss`
file, the module compiles it to CSS on the fly (into `public://scss_compiler/…`),
recompiling whenever the source changes. During development you can turn caching
off so edits show immediately; in production you compile once and serve the
result. Output can be pretty (expanded) for debugging or compressed for
production, and it can emit source maps so browser dev tools point back to your
original Sass.

Compilation is handled by pluggable **compiler backends**: the default handles
`.scss`, and you can map the `.less` extension to the Less backend. Two developer
alter hooks let code add `@import` search paths and inject or override Sass
variables globally, per module/theme, or per file. You recompile with a single
Drush command (`drush ccr`), a "Flush compiler cache" menu action, or any normal
cache rebuild.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its scssphp
   library) with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings on the Performance
   page, how files get compiled, and how to recompile.

## Where it lives in the admin menu

There's no dedicated page — the module adds its settings to the core
**Performance** form at **Configuration → Development → Performance**
(`/admin/config/development/performance`). A **Flush compiler cache** action is
also added under the admin toolbar.

## How to use it

1. In your theme or module's `*.libraries.yml`, list a `.scss` source in a
   library's CSS (for example `css/style.scss: {}`).
2. Attach that library as usual. On the next page load the module compiles the
   Sass to CSS automatically — there's no manual build step.
3. Tune output format, source maps, and caching on the **Performance** page. See
   [Configuration](configuration/index.md).
4. When you change Sass sources (or the output format), recompile with **`drush
   ccr`**, the **Flush compiler cache** action, or a full cache rebuild.
