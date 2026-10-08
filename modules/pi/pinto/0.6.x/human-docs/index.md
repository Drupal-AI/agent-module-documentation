# Pinto — manual setup guide

**Pinto** (`pinto`) is a theme object system for Drupal: a way to define frontend
components in **plain PHP** instead of loose render arrays and preprocess hooks. You
write each component as a simple, typed PHP class, pair it with a Twig template, and
Pinto handles wiring it into Drupal's theming. Some people describe it as a nicer
alternative to Single Directory Components (SDC), and it includes helpers to
replicate a "single directory" setup where the PHP, Twig, CSS, and JS for a
component live side by side.

Pinto is a **developer and theming framework**, not a point-and-click feature. It
has no admin UI, no content, and no access-control role — it renders through
Drupal's normal theming pipeline. It works well anywhere you build render output:
controllers, blocks, layouts, and entity displays. The Drupal module depends on the
underlying Pinto PHP library (installed automatically via Composer), and the two are
developed independently — the library on GitHub, the Drupal integration on
Drupal.org.

Because everything is defined in code, this guide covers getting the module in
place; the actual component authoring happens in your own module's PHP and Twig, and
the official Pinto documentation at <https://pinto.docs.contrib.social/> is the
reference for the component API.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its PHP library)
   with Composer and enable it.

There is **no configuration page** — Pinto is a code-first framework with no admin
settings form. You configure it by writing component classes in your own code.

## How to use it

A Pinto component is a PHP class whose constructor declares its typed inputs, paired
with a Twig template that receives those values. In broad strokes:

1. Create a PHP class for your component (for example in a custom module), giving its
   constructor the typed properties the component needs.
2. Use the Pinto traits/attributes (such as `DrupalInvokableSlotsTrait`) so Drupal
   knows how to render the object.
3. Write the matching Twig template that outputs those properties.
4. Instantiate and invoke the component wherever you build output — in a controller,
   block, layout, or entity display.

The sibling projects extend Pinto into specific areas of Drupal:
[`pinto_block`](https://www.drupal.org/project/pinto_block) (custom Layout Builder
blocks), [`pinto_entity`](https://www.drupal.org/project/pinto_entity) (entity
rendering), [`pinto_layout`](https://www.drupal.org/project/pinto_layout) (Layout
Discovery layouts), and [`pinto_theme`](https://www.drupal.org/project/pinto_theme)
(building whole themes). Reach for those once you are comfortable with the base
component system here.
