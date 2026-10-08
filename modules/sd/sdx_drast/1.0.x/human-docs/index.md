# SDX DRAST — manual setup guide

**SDX DRAST** (`sdx_drast`) is a theme engine that replaces Drupal's Twig template
engine with a structured-data pipeline. The name stands for **D**rupal **R**ender
**A**rrays to **S**tructured **T**okens: instead of producing HTML strings, the
engine outputs typed JSON that React, Vue, or Svelte components consume directly. You
write `block.tsx` instead of `block.html.twig`, and your framework component receives
structured props rather than pre-rendered markup.

The point is to bridge the gap between how Drupal renders (HTML strings) and how
JavaScript frameworks want to work (data). DRAST hooks into Drupal's standard render
pipeline: when a theme hook is rendered it emits a self-contained structured token
instead of calling Twig, and after the page is built those tokens are resolved into a
typed component tree and sent to the client as JSON. Every rendering path — full page
load, SPA navigation, AJAX dialog — produces the same structured output, so your
components never parse the DOM or decode HTML markers. It implements Drupal's template
engine contract as a drop-in Twig replacement, discovers `.tsx`/`.vue`/`.svelte`
templates for any theme hook, and supports region-level partial reloads driven by
cache-tag checksums. An optional **DataProvider** submodule (`sdx_data_provider`)
supplies typed, route-level data for many admin pages.

DRAST is part of the **SDX** ecosystem and requires the SDX module — it is the "go
all-in" option mentioned in SDX's own documentation. It is an early release
(`1.0.0-alpha3`), needs PHP 8.3+, and targets Drupal 10.3+ and 11, so treat it as
pre-production.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install SDX first, then this module, and
   switch your theme to the engine.

## How to use it

After installing (see below), set `engine: sdx` in your theme's `.info.yml` to
activate the engine, then create framework templates in your theme's `templates/`
directory (for example `templates/block/block.tsx`), and run `drush cr` to rebuild
the theme registry. A base theme with common Drupal templates already implemented is
available as **SDX React Base** to start from.
