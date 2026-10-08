# Simple Less — manual setup guide

**Simple Less** (`ipless`) compiles Less (`.less`) stylesheets into CSS for you, using
a pure-PHP Less parser — so you can author styles in Less without installing Node.js,
Gulp, or any command-line build toolchain.

You point it at Less files by declaring them in a module's or theme's
`*.libraries.yml` under a `less:` key, turn the feature on from the site's Performance
page, and Simple Less generates the compiled CSS into `public://ipless/` and swaps it
into your library automatically at render time. Because the compiler is the
`wikimedia/less.php` PHP library, everything happens inside PHP on the server — there
is no separate build step to run and nothing extra to install on your deployment
target.

It also has developer conveniences for while you are actively styling: a **developer
mode** that recompiles Less on every request, a **source maps** option for debugging
the compiled CSS, and a **watch mode** that live-refreshes CSS in the browser without
a full page reload. For deployments there is a Drush command, `drush ipless:generate`,
that precompiles every Less library in one go.

This guide is written for a **human** setting the module up through the admin UI and
CLI. If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   `wikimedia/less.php` library) and enable the module.
2. [Configuration](configuration/index.md) — turn on Less compilation on the
   Performance page, the developer/source-map/watch options, and how to declare Less
   files in a `*.libraries.yml`.

## Where it lives in the admin menu

Simple Less has **no settings page of its own**. Its four options are added to core's
existing **Performance** page at **Configuration → Development → Performance**
(`/admin/config/development/performance`), inside the "Bandwidth optimization" area.

## How to use it

At a high level the workflow is:

1. Declare your `.less` files under a `less:` key in a `*.libraries.yml` file (see
   [Configuration](configuration/index.md#declaring-less-files)).
2. Enable Less compilation on the Performance page.
3. Attach the library as usual. Simple Less compiles the Less to CSS in
   `public://ipless/` and serves that CSS in place of the Less.

During development, turn on developer mode (and optionally watch mode) so edits
recompile automatically. On production you can leave compilation enabled with the
developer/watch options off, and run `drush ipless:generate` as part of your deploy to
precompile everything up front. A cache flush (`drush cr`) flags a full rebuild, so
compiled CSS regenerates after deployments.
