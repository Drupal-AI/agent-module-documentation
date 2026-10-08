# Alpine.js Library support — manual setup guide

**Alpine.js Library support** (`alpine_js`) makes the [Alpine.js](https://alpinejs.dev)
JavaScript library available to your Drupal site as a proper Drupal library, and —
more importantly — it guarantees that anything you declare as an *Alpine plugin*
loads **before** Alpine itself starts up.

Alpine is a lightweight way to add interactivity (dropdowns, tabs, modals, small
form behaviours) directly in your HTML attributes, without a build step or a
front-end framework. The catch is timing: Alpine initialises on the browser's
`DOMContentLoaded` event and only registers the plugins it can see at that exact
moment. A plugin that loads a fraction too late simply does nothing — and the bug
often hides in local development and only appears once JavaScript aggregation is
switched on. This module gives that "must load first" relationship a name so the
order comes out right regardless of aggregation.

You use it by declaring your theme's or module's library as *depending on* Alpine,
or as *being* an Alpine plugin; the module's asset service then sorts out the load
order. It has no dependencies of its own and is a good fit for progressive
enhancement of server-rendered Drupal markup. If your site already has a bundler
and a component framework, this is not the layer it needs.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

This is a developer-facing library module — the "using" happens in your theme or
module code, not on a content-editing screen:

- Declare your library as depending on Alpine, or mark it as an Alpine plugin, and
  the module ensures the correct load order.
- A small settings form (`alpine_js.settings_form`) controls *how* Alpine is
  delivered to the page. The defaults are sensible, so most sites never need to
  open it — adjust it only if you need to change the delivery method.

Once enabled you can start writing Alpine behaviour as HTML attributes
(`x-data`, `x-show`, and so on) in your Twig templates and progressively enhance
existing markup.
