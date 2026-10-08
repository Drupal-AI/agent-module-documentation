# Twig VarDumper — manual setup guide

**Twig VarDumper** (`twig_vardumper`) is a developer/theming tool that makes
inspecting variables in Twig templates far more pleasant. It adds two Twig
functions — `dump()` and `vardumper()` — that render your variables with
Symfony's **VarDumper**, giving you a collapsible, syntax-highlighted, searchable
widget instead of the flat wall of text you get from core's plain `{{ dump() }}`.

Both functions do exactly the same thing (`vardumper()` just exists as an
alternative name in case another extension or theme already defines `dump`). Call
either in any `.html.twig` template: pass one variable, pass several, or call it
with no arguments to dump the entire current template context. The output is the
interactive `sf-dump` block where you can expand and collapse arrays and objects,
see type and visibility colouring, and search within a large structure.

The single most important thing to know: **output only appears when Twig debug is
enabled.** With Twig debug off (Drupal's default, and how production should be
configured) the functions return nothing at all — so it is safe to leave
`{{ dump(...) }}` calls in templates without leaking anything on production.
That's what makes this a development tool.

There is no admin UI, no configuration, no permissions, and no Drush commands —
the entire feature is those two Twig functions. It requires the
`symfony/var-dumper` library, which Drupal core already ships, so you rarely need
anything extra.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — Twig VarDumper has no admin pages and no settings form (`configure` is
null). You use it purely from within Twig templates.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. **Turn on Twig debug** — without this the functions output nothing. In a
   development services file (for example `sites/default/services.yml`, or a
   `development.services.yml` included from `settings.php`):

   ```yaml
   parameters:
     twig.config:
       debug: true
   ```

   Then rebuild the cache with `drush cr`. (Twig debug is a container parameter
   in a services file, not something you set with `drush config:set`.)
3. Call the function in any template:

   ```twig
   {# Dump one variable #}
   {{ dump(node) }}

   {# Dump several at once #}
   {{ vardumper(node, user, page) }}

   {# Dump the ENTIRE current template context #}
   {{ dump() }}
   ```

Both functions are variadic and their output is treated as safe HTML (the dump
markup is not escaped). Typical uses: inspecting `page.content` to see why a
region is empty, exploring a render array level by level, checking what a field
or entity actually exposes to the template, or confirming a value you set in a
`hook_preprocess_*`.

Because nothing is emitted while Twig debug is off, you can leave these calls in
place during development and not worry about them showing up in production.
