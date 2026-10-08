# Pinto Theme Helper — manual setup guide

**Pinto Theme Helper** (`pinto_theme`) helps you build **entire Drupal themes** with
the [Pinto](https://www.drupal.org/project/pinto) framework. Where the base Pinto
module gives you a way to define individual components as typed PHP objects, this
helper provides the rendering support and glue needed to take that code-first,
component-driven approach all the way up to a full theme.

It is a **developer and theming framework**, not a configurable feature. It supports
theme rendering and has no content or access-control role of its own. As with the
rest of the Pinto family, the real work happens in code — you build your theme's
components and templates against the Pinto API — so keep the official Pinto
documentation at <https://pinto.docs.contrib.social/> to hand.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — Pinto Theme Helper is a code-first framework with
no admin settings form. You use it by building your theme's components in code.

## How to use it

Use Pinto Theme Helper alongside the base Pinto component system to structure a whole
theme around Pinto objects: define your theme's components as typed PHP classes, pair
them with Twig templates, and let Pinto's rendering helpers drive the theme's output.
After adding or changing component code, clear the cache (`drush cr`) so Drupal picks
it up. See the [official Pinto Theme documentation](https://www.drupal.org/project/pinto_theme)
for the details of building a full Pinto-based theme.

> **A note on versioning:** the module is at an early `0.0.x` release. Review it as
> you would any pre-stable dependency before relying on it for a production theme.
