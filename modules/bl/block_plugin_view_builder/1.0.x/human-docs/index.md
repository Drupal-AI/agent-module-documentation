# Block Plugin View Builder — manual setup guide

**Block Plugin View Builder** (`block_plugin_view_builder`) is a **developer
tool**. It gives module and theme developers a clean way to render a *block
plugin* from code — getting its output without placing the block in a region on
the block layout.

Drupal's block system has two separate things: a **block plugin** (the code that
produces a block's render array) and a **block placement** (configuration saying
that plugin appears in a region under certain conditions). Usually you want both.
But sometimes you only need the plugin's output — a controller that needs the
site's search form in its response, a custom page assembling several components, a
mail template wanting a rendered block, or a test that needs a plugin's output
without a full page around it. Doing that by hand is a multi-step sequence, and
two of the steps — checking the plugin's **access** and attaching its **cache
metadata** — are easy to forget because the output looks correct without them.
This module packages that sequence into a helper so those steps aren't skipped.

Two things are worth knowing before you use it. Rendering a plugin directly
**bypasses the placement's visibility conditions** — that is the point, but those
conditions are sometimes where a site expressed "this block is only for
administrators", so a directly-rendered plugin can appear where the configuration
said it should not. And a block plugin's **cache metadata belongs to whatever
renders it**: a plugin that varies per user must keep its cacheability, or you can
end up caching one user's fragment for everyone. The helper exists precisely to
make handling these correct. It has no configuration UI, no dependencies, and
supports Drupal 10 and 11.

This guide is written for a **human**. Because this module is used from code, the
sibling [`agent/`](../agent/start.md) docs — written for an AI coding agent —
cover the mechanics concisely and are worth reading alongside this page.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — this module has **no admin interface and no settings page**. It is used
programmatically from your own module or theme code. Enabling it simply makes its
render helper available to other code.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. From your own code, use the module's helper to render a block plugin — for
   example to embed the search form in a controller's output, assemble a page from
   several plugins, or render a block into a mail template.
3. Let the helper perform the access check and attach cache metadata for you, and
   remember that rendering a plugin directly bypasses any placement visibility
   conditions.

See the [`agent/`](../agent/start.md) docs for the concrete render sequence.
