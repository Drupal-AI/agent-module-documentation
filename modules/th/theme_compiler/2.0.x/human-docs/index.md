# Theme Compiler — manual setup guide

**Theme Compiler** (`theme_compiler`) lets a **theme** ship source assets — such
as SCSS — and have Drupal compile them into served files *on demand*, with no
Node/Gulp/Webpack build step baked into the theme's release. The theme author
declares which files should be compiled (and to what URL the result is served) in
a small `THEME.theme_compiler.yml` file; this module reads that file, builds the
routes, compiles when needed, and serves the compiled bytes. In short: keep the
`.scss` source in your theme, and let Drupal produce the deployable `.css` at
runtime.

It builds on the [Compiler](../../../compiler/1.0.x/human-docs/index.md)
framework and needs an actual compiler plugin to do the work — for SCSS, install
[SCSS Compiler](../../../compiler_scss/1.0.x/human-docs/index.md), which provides
the `scss` compiler. Theme Compiler recompiles automatically at sensible moments:
when a theme is installed or uninstalled, and when a theme's settings change (so
Sass variables driven by theme settings stay in sync). Compiled output is stored
in a sandboxed public directory and cache-tagged for correct invalidation. It's a
fairly widely used helper — roughly 2,500 sites run it.

This is a **theme-developer tool**, not a click-and-go feature: there is no admin
UI, no settings form, no permissions and no Drush commands (`configure: null`).
All the "configuration" is the YAML file you ship inside a theme, summarised under
"How to use it" below and covered fully in the sibling
[`agent/`](../agent/start.md) docs — the terse, token-cheap references written for
an AI coding agent. Theme Compiler requires **PHP 8.1+**, the **Compiler** module,
and the `sabre/uri` library (installed automatically by Composer).

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   Compiler and `sabre/uri`), enable it, and add a compiler plugin such as SCSS
   Compiler.

## Where it lives in the admin menu

Nowhere. Theme Compiler has no admin page or menu entry. It works through routes
it generates and through the YAML file a theme provides.

## How to use it

1. **Make sure a compiler plugin is installed** for the language you're
   compiling. For SCSS that means the **SCSS Compiler** (`compiler_scss`) module,
   which registers the `scss` compiler.

2. **Add a `THEME.theme_compiler.yml` file to your theme.** It's keyed first by
   compiler plugin id, then by the theme-relative path the result should be
   served at:

   ```yaml
   # my_theme/my_theme.theme_compiler.yml
   scss:                      # the compiler plugin id
     css/style.css:           # the URL path (theme-relative) the result is served at
       files:                 # REQUIRED: one or more theme-relative source files
         - scss/style.scss
       options:               # optional: passed to the compiler
         style: compressed
     css/admin.css:
       files: [scss/admin.scss]
   ```

   `files` is required and every path must exist — a missing source file throws
   an error while routes are being built, so keep the paths valid.

3. **Rebuild caches** (`drush cr`) after adding or editing the YAML so the routes
   regenerate. Drupal then serves each target from its theme-relative URL,
   compiling on demand and caching the result under
   `public://theme-compiler-assets/`.

Developers can also hook into the process — altering the compiler context before
compilation, altering the served response, or triggering a full recompile
programmatically. Those hooks and the internal services are documented in the
[`agent/`](../agent/start.md) docs.
