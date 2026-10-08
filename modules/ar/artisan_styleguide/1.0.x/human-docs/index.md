# Artisan Styleguide — manual setup guide

**Artisan Styleguide** (`artisan_styleguide`) gives front‑end developers a
**living style guide**: a single page that showcases a theme's components,
typography, colours, and UI patterns. Instead of hunting through templates to
remember what a button or a card looks like, designers and developers can open one
page and see the theme's design system laid out together.

The point of a living style guide is that it is generated from the theme itself,
so it stays in step as the design evolves — a reference you can review against and
reuse from while you build. Under the hood the module serialises the component
data it needs for display, which is why it depends on core's **Serialization**
module.

This is a **theme‑development aid**. It carries no content of its own and plays no
access‑control role — it is a tool for the people building and maintaining the
theme rather than a visitor‑facing feature. It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once enabled, Artisan Styleguide provides the browsable style‑guide page that
gathers your theme's components, typography, and colours in one place. Open it
while developing or reviewing the theme to check that components render
consistently and to reuse existing patterns rather than rebuilding them. Because
it is a development tool tied to your theme, keep it alongside your front‑end
workflow; there is no separate settings form to configure.
