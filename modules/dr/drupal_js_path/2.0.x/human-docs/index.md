# Drupal Path in JS — manual setup guide

**Drupal Path in JS** (`drupal_js_path`) is a small developer utility that makes
Drupal's routing available to your front‑end JavaScript. Once enabled, your
scripts can ask Drupal for the alias or internal path of a route by name — rather
than hard‑coding URLs into JS files that then break the moment a path or alias
changes.

The problem it solves is a maintenance one. When JavaScript needs a URL — for an
AJAX call, an analytics tag, or client‑side routing — developers usually either
pass the URL in through `drupalSettings` or paste it directly into a script. Both
approaches mean editing JS whenever the URL changes. This module instead exposes
two helper functions so JS can resolve a route on demand:

```javascript
Drupal.alias(routeName, routeParams, routeOptions);  // the URL alias
Drupal.path(routeName, routeParams, routeOptions);   // the internal path
```

It is purely a developer tool: it has no content model, no access role, and no
settings form. It supports a very wide range of Drupal versions (8 through 12).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it exposes JavaScript
helper functions and has nothing to click through.

## How to use it

After enabling the module, use the two functions from any of your JavaScript
(for example inside a `Drupal.behaviors` attach). Pass the machine route name and
any route parameters, and you get back the current alias or internal path:

```javascript
// Resolve the canonical URL of node 123
const url = Drupal.alias('entity.node.canonical', { node: 123 });

// Resolve the internal path (/node/123) instead of the alias
const internal = Drupal.path('entity.node.canonical', { node: 123 });
```

Because the URL is resolved through Drupal's routing at runtime, you don't have
to update your JavaScript when an alias or path changes.
