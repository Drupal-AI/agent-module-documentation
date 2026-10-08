# Theme Compiler — manual setup guide

**Theme Compiler** (`theme_compiler`) lets a **theme** declare source assets —
typically SCSS — and have Drupal compile them into plain, deployable files (CSS)
**at runtime**, without shipping a Node/Gulp build step in the theme's release.
It builds on the [Compiler](https://www.drupal.org/project/compiler) framework and
uses a compiler plugin (most commonly the `scss` plugin from **SCSS Compiler**) to
do the actual transformation.

The problem it solves is the friction of front-end tooling in a Drupal theme: with
Theme Compiler you keep your `.scss` sources in the theme and let Drupal produce
the `.css` on demand — automatically when the theme is installed or uninstalled,
and whenever the theme's settings change. That last point is the powerful bit: a
theme can expose its own settings (a brand color, a spacing value) and feed them
into the Sass compile, so admins can retune the compiled CSS from the theme
settings form.

You configure it not through an admin page but through a small YAML file in your
theme: a `THEME.theme_compiler.yml` that maps each **output path** to a compiler
`plugin` and a list of `source` files. The compiled result is written under the
public files directory (`public://compiled-assets/<theme>/…` by default) and served
as an ordinary static file, which you then reference from a normal theme library.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module along with a compiler plugin.

There is **no configuration page** for this module — it has no settings form.
Setup happens in your theme's `THEME.theme_compiler.yml` file, described in "How
to use it" below.

## How to use it

1. Install a compiler-plugin module — usually **SCSS Compiler** (`compiler_scss`),
   which provides the `scss` plugin.
2. In your theme's root, create `THEME.theme_compiler.yml`. Each top-level key is
   the **target path** where the compiled file is stored; under it, `plugin` names
   the compiler and `source` lists theme-relative source files. For example:

   ```yaml
   style.css:
     plugin: scss
     source:
       - scss/main.scss
   ```

3. Add the compiled file as a theme **library** (in `THEME.libraries.yml`),
   pointing at its public path and setting `preprocess: false` so it isn't
   swept into CSS aggregation:

   ```yaml
   example-library:
     css:
       theme:
         /sites/default/files/compiled-assets/THEME_MACHINE_NAME/style.css: { preprocess: false }
   ```

4. Rebuild the cache to trigger asset discovery. Compilation runs on theme
   install/uninstall and whenever the theme's settings are saved.

To feed values into the compile — for example inject a Sass variable from a theme
setting — implement `hook_theme_compiler_TYPE_alter()` (e.g.
`mytheme_theme_compiler_scss_alter()`) and call `$compiler->setVariable(...)`.
Since 3.1.x you can also react to a finished compile with
`hook_theme_compiler_asset_updated()`.
