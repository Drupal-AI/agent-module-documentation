# SCSS Compiler — manual setup guide

**SCSS Compiler** (`scss`) builds a theme's Sass/SCSS source files into CSS from
inside Drupal, using the pure-PHP [scssphp](https://scssphp.github.io/scssphp/)
library. That means no Node toolchain, no gulp, and no build step in your
deployment — which is especially useful on hosts that do not allow command-line
access or where a front-end tooling setup is impractical. It can recompile
automatically when a source file changes.

Under the hood the module wraps the `scssphp/scssphp` library in a compiler service
and points it at a theme's source directory. You tell it which theme to compile,
where the SCSS sources live (typically a `sass` or `scss` folder in the theme),
and where the compiled CSS should go (typically `css`). It then watches those
sources and rebuilds when they change. There is also a Drush command (`drush scss`)
so compilation can be part of a release instead of a page request.

One behaviour worth understanding: recompilation is triggered by page requests. A
setting decides whether **logged-out (anonymous) visitors** can trigger a rebuild.
If you leave that off — a common production choice — then only authenticated
traffic will trigger recompiles, so a change deployed without an authenticated hit
will not compile. On production it is usually best to run the Drush command as part
of deployment rather than relying on page requests, since compiling on request
means a slow first hit after each change and any error in a Sass file surfaces
during a page render.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its scssphp
   library with Composer, then enable it.
2. [Configuration](configuration/index.md) — choose the theme, source and
   destination directories, import paths, and compilation options.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Development → SCSS**
(`/admin/config/development/scss`), reachable by any user with the **Administer site
configuration** permission.
