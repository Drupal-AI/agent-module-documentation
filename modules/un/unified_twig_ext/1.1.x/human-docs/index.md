# Unified Twig Extensions — manual setup guide

**Unified Twig Extensions** (`unified_twig_ext`) lets a Pattern Lab-style theme
share its custom Twig functions, filters and tags with Drupal. If your front-end
team builds components in a stand-alone Pattern Lab prototype and writes helper
Twig extensions (say a custom `icon()` function or a `{% grid %}` tag), this
module makes those same extensions available inside Drupal templates — without
you having to re-implement them as a Drupal module. The theme becomes the single
source of truth for that Twig logic.

It works by auto-loading plain PHP files from your **default theme**. When Twig
starts up, the module looks one directory level below the default theme for a
`_twig-components/` folder, then scans its `functions/`, `filters/` and `tags/`
subfolders and includes every PHP file it finds. Each file defines one Twig
extension following a simple naming convention. There is no admin screen, no
settings, no permissions and no Drush commands — you enable the module, drop your
extension files into the theme, clear the cache, and they work.

Because it is aimed at theme developers, this module has nothing to click. The
sections below explain the folder layout and file conventions so you know where
to put your code.

This guide is written for a **human** working in a theme. If you want terse,
token-cheap references for an AI coding agent — including the exact file
conventions and the load rules — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — this module has no admin pages, no settings form and no configuration.
Once enabled it runs automatically against whatever theme is set as the site's
default.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. In your **default theme**, create a `_twig-components/` folder one level below
   the theme root — for example `mytheme/source/_twig-components/` (the folder in
   between can be `source`, `pattern-lab`, or similar). Inside it, add any of
   three subfolders: `functions/`, `filters/`, `tags/`.
3. Add your extension files, one per file:
   - A **function** file sets a `$function` variable to a `\Twig\TwigFunction`.
   - A **filter** file sets a `$filter` variable to a `\Twig\TwigFilter`.
   - A **tag** file named `NAME.tag.php` defines a matching token-parser class.
   - Files whose names start with `.`, `_` or `pl_` are skipped, which is handy
     for keeping experimental files from loading.
4. Run `drush cr` (or clear caches from the UI) so Drupal picks up the new files.
   The functions, filters and tags are then usable in any Drupal Twig template,
   for example `{{ greeting() }}`.

A few things worth knowing: only the **default** theme is scanned, so helpers
placed in a non-default (for example admin) theme are never loaded, and you must
clear the cache after adding or changing files. The exact file examples and edge
cases live in the [`agent/`](../agent/start.md) docs.
