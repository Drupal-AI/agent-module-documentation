# Commerce Kickstart Demo Assets — manual setup guide

**Commerce Kickstart Demo Assets** (`commerce_kickstart_demo_assets`) is a small
support package: it ships the **JavaScript, Twig templates, and other static
files** used by the **Commerce Kickstart Demo recipe**. It is not really a module
you choose and configure on its own — it exists so the Kickstart demo has code
files a recipe alone cannot provide.

A little background makes this clearer. In Drupal 7, *Commerce Kickstart* was a
full **distribution**: you installed it and got a complete, working demo store to
learn from. Distributions fit poorly with how Drupal is assembled today, and
core's **recipes** have largely replaced them — a recipe *applies* configuration
and content to an existing site rather than dictating how the whole site was
built. But a recipe can only apply configuration; it cannot ship a JavaScript
file or a Twig template. Those have to come from a module. That is exactly what
this package is: the files the Kickstart demo recipe needs but cannot carry
itself.

Because of that, you normally don't install this directly — it arrives as a
**dependency when the Commerce Kickstart demo recipe is applied**. It has no
dependencies of its own, no routes, no permissions, and no settings. Its core
requirement is **`^11`** (Drupal 11 only), which is consistent with a package
built for the modern recipe system.

One important caveat: the Kickstart demo is meant for **evaluation and learning**,
not for a production storefront. Demo content and demo assets on a live site are
clutter at best and a source of confusion about what is "real" at worst — and a
**recipe does not uninstall**, so unpicking what it applied is manual work. Plan
the removal at the same time you plan the installation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — how it arrives (usually as part of the
   Kickstart demo recipe) and how to enable it directly if you need to.

There is **no configuration page** for this module — it has no settings form,
routes, or permissions. It simply makes its asset files available to the demo.

## How to use it

You don't interact with this package directly. It becomes active when you apply
the **Commerce Kickstart demo recipe**, which pulls it in as a dependency and
then references its templates and JavaScript. If you are building or applying that
recipe, this package will be present automatically. There is nothing to click.
