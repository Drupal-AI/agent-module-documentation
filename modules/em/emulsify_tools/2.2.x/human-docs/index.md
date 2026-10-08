# Emulsify Tools — manual setup guide

**Emulsify Tools** (`emulsify_tools`) is the Drupal-side companion module for the
[Emulsify](https://www.drupal.org/project/emulsify) theme and component-driven Twig
workflows. It bundles the utilities that help Emulsify-based themes work cleanly with
reusable components, and it is aimed at front-end developers and themers rather than
site administrators.

It provides four kinds of tooling:

- **Twig helper functions and tags** — `bem()` for generating BEM-style class names,
  `add_attributes()` for merging attribute maps into reusable component templates,
  and a `{% switch %}/{% case %}/{% default %}` tag for cleaner conditional logic in
  Twig.
- **Theme-defined Twig namespaces** — declare component paths in a theme's
  `.info.yml` (under `components.namespaces`, the same structure the Components module
  uses) so templates can be referenced with namespace syntax like
  `@atoms/button/button.twig`, resolved across the active theme, its base themes, and
  the default front-end theme.
- **Child-theme generation** — a Drush command that scaffolds an Emulsify child theme
  for you.
- **Favicon deployment commands** — Drush commands to generate, inspect, reset, and
  repair the favicon package that Emulsify 7.x child themes use, so favicons stay
  consistent across environments after deployments and config imports.

This is a developer's toolkit: most of what it does happens in your Twig templates
and on the command line, not in the admin UI. It has **no configure route and no
settings form** — its one config object (`emulsify_tools.settings`) holds a single
list, `admin_theme_favicon_themes`, which is toggled from within a theme's own
settings page rather than a module form. It has no permissions of its own.

The Twig helpers, switch/case tag, and namespace support are useful for any
Emulsify-based theme. The child-theme generator and the favicon commands pair with
the Emulsify Drupal theme (favicon workflows specifically need Emulsify 7.x), and the
Drush commands need Drush 13+.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and the Drush commands it provides.

There is **no configuration page** for this module — it has no settings form. Its
Twig helpers and namespace support are used from theme code, and its features are
driven by Drush commands, described below.

## Where it lives / how to use it

Emulsify Tools adds no admin settings page. You use it from three places:

- **Your theme's Twig templates** — call `bem()`, `add_attributes()`, and the
  `switch`/`case` tag; for example `{{ bem('title', ['small'], 'card') }}` outputs
  `card__title card__title--small`.
- **Your theme's `.info.yml`** — declare component namespaces under
  `components.namespaces` (e.g. `atoms: components/01-atoms`) and reference them as
  `@atoms/button.twig`.
- **The command line (Drush 13+)** — generate a child theme and manage favicon
  packages (see [Installation](installation/index.md) for the command list).

One small admin touch point: Emulsify 7.x themes store favicon settings on the
theme's own settings page (**Appearance → Settings**), and the module adds a toggle
there to also apply a theme's generated favicon on admin pages. That choice is what
gets stored in `emulsify_tools.settings` (`admin_theme_favicon_themes`).
