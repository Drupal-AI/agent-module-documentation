# Canvas Override — manual setup guide

**Canvas Override** (`canvas_override`) is a developer‑oriented module that
replaces how **Canvas**, Drupal's Experience Builder page builder, loads a page's
component tree. Canvas stores each page as a tree of components, and a piece of
Canvas called the *component tree loader* turns that stored data into the tree
Canvas renders. This module swaps in its own loader so a site can change where
that tree comes from, or transform it on the way in — for example applying an
inherited default layout, producing a per‑context variation, or reading an older
stored format during a migration.

It depends on the **Canvas** module, targets Drupal 11, and is a **1.0.0‑beta1**
release aimed at developers rather than editors. It has no settings form and no
content of its own; its whole job is to intercept and replace core Canvas
behaviour in code.

> **Important compatibility warning.** As documented from source, this module
> **cannot be enabled against Canvas 1.8.0**. In that Canvas release the loader
> class is declared `final` (meaning "do not extend me"), while Canvas Override
> works by extending it. PHP refuses that outright with a fatal error — *"cannot
> extend final class …ComponentTreeLoader"* — at class‑load time, which prevents
> the service container from building and takes the whole site (and Drush) down.
> Neither module's Composer constraints stop this pairing, so Composer will
> happily resolve it. Before adopting Canvas Override, check which Canvas release
> it was written for and pin your `canvas` version accordingly; if it fatals,
> remove the module and rebuild.

This guide is written for a **human** clicking through the site. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and the version‑compatibility caveat you must check first.

## Where it lives in the admin menu

Canvas Override has no admin menu items and no settings form. It operates entirely
in code by replacing a Canvas service, so there is nothing to click.

## How to use it

This is a developer building block, not an editor feature. After confirming it is
compatible with your Canvas release (see the warning above), enable it; its
replacement loader then governs how Canvas resolves component trees. Any custom
loading or transformation logic is something a developer implements on top of the
override it provides.
