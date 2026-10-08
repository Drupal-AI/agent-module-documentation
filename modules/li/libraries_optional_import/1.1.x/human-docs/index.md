# Libraries optional import — manual setup guide

**Libraries optional import** (`libraries_optional_import`) lets a theme mark
individual asset files in a library definition as **optional**, so that when a
file isn't actually present on disk Drupal quietly drops it instead of throwing a
"missing library file" error.

Normally Drupal expects every CSS or JS file you declare in a `*.libraries.yml`
to exist, and it complains (or breaks aggregation) if one is missing. That is
usually the right behavior — but not always. Sometimes a build pipeline only
emits certain assets under certain conditions, or a subtheme may or may not ship a
particular override file. This module gives you a clean way to say "load this one
*if* it's there, otherwise never mind."

You use it purely by adding an `optional: true` flag to the assets you want to
treat that way. Behind the scenes the module hooks into library info alteration
and, for any asset carrying that flag, checks whether the file really exists under
the owning theme's path — removing the entry when it doesn't, before the library
is used. Required (non‑optional) assets are left completely untouched and still
enforced.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no settings form,
routes, or permissions. It works the moment it is enabled, and you control its
behavior declaratively in your theme's library definitions, as shown below.

## How to use it

In your theme's `*.libraries.yml`, add `optional: true` to any CSS or JS file
that might not exist:

```yaml
global:
  version: 1.x
  css:
    theme:
      dist/app.css: { }
      dist/app-optional.css: { optional: true }
  js:
    dist/app.js: { }
    dist/app-optional.js: { optional: true }
  dependencies:
    - core/jquery
    - core/drupal
```

Here `app.css` and `app.js` are always required, while `app-optional.css` and
`app-optional.js` are only loaded when the files exist. The flag works the same
way for both the `css` and `js` groups. Typical uses: assets produced by an
optional build step, environment‑specific files that only exist in some
deployments, or a fallback stylesheet that should load only when a theme override
file is not present.
