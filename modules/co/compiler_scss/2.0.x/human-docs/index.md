# SCSS Compiler — manual setup guide

**SCSS Compiler** (`compiler_scss`) adds an `scss` compiler plugin to the
[Compiler](https://www.drupal.org/project/compiler) framework, letting Drupal turn
SCSS (Sass) source into CSS **at runtime, in pure PHP** — no Node.js, no `sass`
binary, no build step. It is powered by the `scssphp/scssphp` library and is aimed
squarely at developers building custom modules or themes that need dynamic
stylesheets whose values come from the site's own configuration.

The problem it solves is the awkwardness of a Node-based front-end build in a
Drupal deployment: instead of committing pre-built CSS or running a separate
toolchain in CI, you can author SCSS and have Drupal compile it on demand — for
example when a theme's settings change. It pairs naturally with **Theme Compiler**
(`theme_compiler`), which uses this plugin to compile a theme's declared SCSS
assets into deployable CSS files.

This is developer infrastructure: it has **no admin UI, no routes, no permissions,
and no settings of its own**. You drive it from code — asking the compiler plugin
manager for the `scss` plugin, injecting Sass variables and functions from PHP,
and calling `compile()`. It also ships a handy set of Drupal config-schema types
and matching form elements (for colors, numbers with units, font families, and
font weights) so that a configuration-driven "design tokens" module can store
style values as config and feed them into the compiled CSS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside the Compiler framework.

There is **no configuration page** for this module — it is a developer library
with no settings form. It is used from code, or indirectly through Theme Compiler.

## How it's used

The most common path is **through Theme Compiler**: install both modules, declare
an SCSS asset in your theme's `THEME.theme_compiler.yml` with `plugin: scss`, and
Drupal compiles it to CSS whenever the theme is (un)installed or its settings
change. To use the compiler directly from PHP, get the `plugin.manager.compiler`
service, create the `scss` plugin, configure it with methods like `setVariable()`,
`setFunction()`, `setImportPaths()`, and `setOutputStyle()`, then call `compile()`
with a `CompilerInputSource` (inline SCSS) or `CompilerInputFile` (a file). PHP
values you inject are auto-converted to Sass values — RGB(A) arrays become colors,
`{value, unit}` arrays become unit-aware numbers, arrays become Sass lists/maps.
