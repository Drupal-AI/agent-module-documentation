# Bulma Components — manual setup guide

**Bulma Components** (`bulma_components`) is a library of ready-made
[Single Directory Components](https://www.drupal.org/docs/develop/theming-drupal/using-single-directory-components)
(SDC) built with the [Bulma](https://bulma.io/) CSS framework. If you are theming
a site with Bulma, this module gives you pre-built components — using Bulma's
markup and CSS classes — that you can drop into templates and compose your UI
from, rather than writing the same Bulma boilerplate by hand each time.

The components come with schema-validated props, so each one declares what data
it accepts and Drupal validates that you passed the right values. That makes the
components predictable to reuse across a theme.

This is purely a theming / component library. It has no content of its own, no
admin screens, and no permissions or access role — it exists to be used by theme
developers. It depends on the
[Components](https://www.drupal.org/project/components) and
[Component Schema](https://www.drupal.org/project/component_schema) modules, and
it runs on Drupal 10.2+, 11, and 12.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it with its dependencies.

## Where it lives in the admin menu

Nowhere — Bulma Components adds no admin pages, settings, or menu items. Once
enabled, its components become available to your theme and templates.

## How to use it

After enabling the module (and its Components / Component Schema dependencies),
reference the provided Bulma components from your theme's templates the same way
you would use any SDC, passing the props each component declares. The module ships
the components; wiring them into your markup is done in your theme.
