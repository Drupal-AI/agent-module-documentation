# UI Patterns — manual setup guide

**UI Patterns** (`ui_patterns`) 2.x turns Drupal core's **Single Directory
Components (SDC)** into plugins you can place and configure all over the site —
as field formatters, blocks, layouts, Views styles, and field values — without
writing render code. If your theme or a module defines components (a card, a
button, a banner, a teaser) as SDC, UI Patterns lets site builders wire those
components into content through the normal Drupal admin UI.

Under the hood it decorates core's SDC component manager and re-exposes every
discovered component (identified as `theme_or_module:component`) as something
configurable. Each component's `*.component.yml` schema — its **props** and
**slots** — becomes a form. The value fed into each prop or slot comes from a
**Source plugin**: a small pluggable resolver such as a plain textfield, a token,
a referenced entity field, a menu, a breadcrumb, or even another nested
component. So the same component can be driven by static text in one place and by
live entity data in another. A **PropType** system validates and normalizes each
value against the component's JSON-schema-typed prop, and only offers Sources that
are compatible with a given prop.

Crucially, nothing about your components changes — they remain standard, portable
SDC — so a design system can live in a theme and stay framework-agnostic while
site builders consume it without a developer.

The main `ui_patterns` module is the engine and has **no configuration UI of its
own**. The places you actually use components are the **submodules** (the
"delivery surfaces"), which you enable depending on where you want components to
appear. See the list in [Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and pick the delivery submodules you need.
2. [Configuration](configuration/index.md) — how components surface through each
   submodule, and how you configure a component's props and slots from Sources.

## Where it lives in the admin menu

There is no single settings page. Instead, components appear inside existing
Drupal admin screens depending on which submodules you enable — the **Manage
display** field-formatter settings, the **Block layout** / Layout Builder block
chooser, the **Layout Builder** section layouts, and the **Views** row/style
options. If you enable the library submodule, you also get a component-browser
page to preview every available component.

## How to use it

1. Make sure your theme or a module provides SDC components (each is a folder with
   a `*.component.yml` defining props and slots).
2. Install the base module and the delivery submodule for where you want to use
   components (see [Installation](installation/index.md)).
3. Go to the relevant surface — for example a bundle's **Manage display** to
   render a field as a component, or **Block layout** to place a component as a
   block.
4. Choose the component, then fill each **prop** and **slot** by picking a
   **Source** (static text, a token, an entity field, a nested component, and so
   on). See [Configuration](configuration/index.md) for the details.
