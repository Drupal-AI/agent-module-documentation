# Block Renderer — manual setup guide

**Block Renderer** (`block_renderer`) is a **developer utility** for rendering a
Drupal block programmatically — producing a block's rendered output on demand,
independent of the normal region/layout placement, so that output can be reused
elsewhere.

Sometimes you need a block's markup outside its usual spot on the page: to embed
it in custom markup, to return it to a consumer such as a decoupled front end, or
to compose several blocks together in code. Block Renderer gives you a way to get
at that output directly. Because rendering a block runs its build and access
logic, blocks still honour their own **access checks and cache metadata** when
rendered this way — so treat the resulting output with the same care you would any
rendered block. The module adds no access-control role of its own.

It has no configuration UI and no module dependencies, and its `.info.yml`
declares a wide core range (`^8 || ^9 || ^10 || ^11`). Note the current release is
an alpha (`8.x-1.0-alpha6`), so test it before relying on it in production.

This guide is written for a **human**. Because this module is used from code, the
sibling [`agent/`](../agent/start.md) docs — written for an AI coding agent —
cover the mechanics concisely and are worth reading alongside this page.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — this module has **no admin interface and no settings page**. It is used
programmatically from your own module or theme code. Enabling it simply makes its
rendering utility available.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. From your own code, use the module's utility to render a block and reuse its
   output — for example embedding it in custom markup or returning it to a
   decoupled consumer.
3. Remember that the rendered block still honours its own access and cache
   metadata; handle the output accordingly.

See the [`agent/`](../agent/start.md) docs for the concrete approach.
