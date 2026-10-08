# JS Component — manual setup guide

**JS Component** (`js_component`) lets a developer register a JavaScript/React (or
Twig‑wrapped) front‑end component from any module or theme using a simple YAML
file, and then exposes each registered component as a placeable Drupal block. That
means you can mount a React app, a Vue/Svelte widget, or a chart/map/calendar
library inside a block — placed and configured through the normal Block Layout UI —
without writing a custom module or block plugin.

Each component is declared in a `THEME_OR_MODULE.js_component.yml` file. The
definition names a label, the DOM id the JS mounts on, a `libraries` block (same
syntax as a `*.libraries.yml` file) that attaches the component's JS and CSS, and
optionally a site‑builder settings form, a Twig template, and PHP handler classes.
JS Component discovers those YAML files across all modules and enabled themes,
turns each `libraries` block into a real Drupal library, and creates a
`js_component:<id>` block for every component.

When you place one of those blocks, it renders either an empty mount `<div>` or the
component's Twig template, attaches the library, and hands the component its data —
either through `drupalSettings` or as DOM `data-*` attributes, depending on the
definition. Data can be supplied server‑side by a data‑provider handler class or by
event subscribers, and settings values can run through Token replacement (for
example `[node:title]`) when enabled. There is no global config page, no
permissions, and no Drush commands — everything is developer YAML plus block
placement.

This guide is written for a **human** (here, mostly a developer and a site
builder) working through the code and the Block Layout UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — define a component in YAML, place its
   block, and pass it settings and data.

## Where it lives in the admin menu

There is no dedicated settings page. You define components in code (a
`*.js_component.yml` file in a module or theme) and then work in **Structure →
Block layout** (`/admin/structure/block`) to place a component's block and fill in
its per‑instance settings form.

## How to use it

At a high level: drop a `*.js_component.yml` file into your module or theme
describing the component and the library that loads its built JS/CSS; clear caches
so the component is discovered; then place the generated **block** wherever you
want the component to appear and configure it. The full YAML key reference and the
data‑passing options are in [Configuration](configuration/index.md).
