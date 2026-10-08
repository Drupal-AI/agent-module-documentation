# JSON Template — manual setup guide

**JSON Template** (`json_template`) is a small developer/theming utility that
makes client-side JavaScript templates — Handlebars, Mustache, and similar
engines — available to Drupal's front end. Instead of building markup on the
server, you register a template and let JavaScript render your JSON data into
HTML directly in the visitor's browser.

On its own the module adds no pages, blocks, or content of its own. It is
*infrastructure*: other modules and themes lean on it when they need to draw
dynamic widgets in the browser — recommendation blocks, live listings, and the
like. The [Recombee](https://www.drupal.org/project/recombee) module, for
example, depends on it for its front-end rendering.

Because the templates run in the browser, the usual client-side rule applies:
always let the templating engine escape the values you interpolate, rather than
splicing raw data into markup, so untrusted data cannot become client-side
script injection. The module has no content model or access behaviour of its
own — it simply provides the plumbing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.
You use it from your own module or theme's JavaScript, as described below.

## How to use it

JSON Template is meant to be used by developers and themers, not clicked through
in the admin UI. Typically you (or a module that depends on it) register a
client-side template and then, in the browser, feed JSON data through the
chosen engine (Handlebars, Mustache, etc.) to produce markup for a dynamic
widget or block. If you installed it only because another module (such as
Recombee) required it, you are already done once it is enabled — that module
takes care of the rest.
