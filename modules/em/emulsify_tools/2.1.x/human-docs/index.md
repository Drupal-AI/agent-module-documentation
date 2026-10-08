# Emulsify Tools — manual setup guide

**Emulsify Tools** (`emulsify_tools`) is a toolset for building and maintaining
[Emulsify](https://www.drupal.org/project/emulsify)-based Drupal themes. It bundles
four things themers reach for: a set of **Twig helper functions**, support for
**theme-defined Twig namespaces**, Drush commands to **generate Emulsify child
themes**, and Drush commands to **deploy the favicon packages** that Emulsify's
Drupal 7.x companion theme generates.

The Twig helpers are the part most people use every day. `bem()` builds BEM class
names and attribute objects (so `bem('title', ['small'], 'card')` prints
`card__title card__title--small`), `add_attributes()` merges an attribute map into a
template's attributes without leaking into included templates, and a `{% switch %}` /
`{% case %}` / `{% default %}` tag adds switch statements to Twig. The namespace
feature lets a theme declare Symfony-style component namespaces in its `.info.yml`
(the same shape the Components module uses), so you can reference templates as
`@atoms/button/button.twig` across the active theme, its base themes, and the default
front-end theme.

The module works the moment you enable it — the Twig helpers and namespaces are
available to any theme immediately, and no configuration is required. There is no
settings page of its own. The child-theme generator and favicon commands require
Drush 13+, and the favicon features specifically expect the Emulsify Drupal 7.x
companion theme; the Twig helpers, tags, and namespaces are useful on any theme. It
has no permissions, no plugin types, and depends only on core.

This guide is written for a **human** clicking through the admin UI (and running
Drush). If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no admin page — Emulsify Tools has no configure route and no settings form of
its own. It stores a single configuration value, `admin_theme_favicon_themes`, which
is normally set from an Emulsify theme's own theme-settings form (a toggle it adds
there), not from a page of its own.

## How to use it

### Twig helper functions

Available in any theme's templates once the module is enabled:

- **`bem(baseClass, modifiers, blockname, extra)`** — prints BEM classes as an
  attribute object. Examples: `{{ bem('title') }}` → `class="title"`;
  `{{ bem('title', ['small','red']) }}` → `class="title title--small title--red"`;
  `{{ bem('title', ['small'], 'card') }}` → `class="card__title card__title--small"`.
  A block name turns the base into `block__base`; each modifier appends
  `--modifier`; the `extra` list adds plain classes verbatim (handy for JS hooks).
- **`add_attributes(map)`** — merges a map such as
  `{ class: ['foo','bar'], 'data-x': 'y' }` into the current template's attributes and
  returns a detached collection, so the merge does not leak into child includes. It
  combines nicely with `bem()`: `<div {{ add_attributes({ class: bem('foo', ['bar'], 'foobar') }) }}></div>`.
- **`{% switch %}`** — a switch/case tag:
  ```twig
  {% switch content.field_name.0 %}
    {% case 'text' %}<p>Text</p>
    {% case 'image' %}<p>Image</p>
    {% default %}<p>No match</p>
  {% endswitch %}
  ```

### Theme-defined Twig namespaces

A theme declares namespaces in its **`.info.yml`** under `components.namespaces`:

```yaml
components:
  namespaces:
    atoms: components/01-atoms
    molecules:
      - components/02-molecules
      - src/components/molecules
```

Relative paths resolve from the theme directory; a leading `/` resolves from the
Drupal app root. Templates are then referenced as `@atoms/button/button.twig`, and
because nested templates are also registered by basename, `@atoms/button.twig` works
when the name is unique. Namespaces are searched across the active theme, its base
themes, and the default front-end theme.

### Generate an Emulsify child theme (Drush 13+)

```bash
drush emulsify_tools:bake MyThemeName   # or the alias: drush emulsify MyThemeName
```

This scaffolds an Emulsify child theme under `themes/custom/<machine name>` using
`emulsify` as its runtime parent.

### Favicon deployment (Drush 13+, Emulsify 7.x companion theme)

These regenerate, inspect, and reset the favicon package Emulsify generates from a
theme's saved settings — useful in a deploy pipeline after a config import:

- `drush emulsify_tools:favicon-generate [theme]` — generate/refresh the package.
- `drush emulsify_tools:favicon-status [theme]` — report whether generation is
  enabled, whether the package exists, whether GD/Imagick are present, and whether a
  portable SVG source exists.
- `drush emulsify_tools:favicon-reset [theme]` — remove the generated package and
  restore default favicon behaviour.
- `drush emulsify_tools:repair-favicon-config [theme]` — backfill missing favicon
  install/schema entries in older Emulsify child themes.

To also apply a theme's generated favicon on **admin** pages, turn on the toggle
Emulsify Tools adds to that theme's settings form; this records the theme in the
module's one config value.
